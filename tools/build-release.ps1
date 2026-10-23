# Compila el APK release de Cauce con FLAVOR=prod y muestra lo necesario para verificarlo.
# Solo comprueba que existen .env.* y android/key.properties: nunca los lee ni los imprime.

$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$expectedFlutter = '3.44.2'

function Stop-Release([string]$message) {
    Write-Host ''
    Write-Host "ERROR: $message" -ForegroundColor Red
    Pop-Location
    exit 1
}

Push-Location $repoRoot

# 1. Archivos que el build necesita. Los cuatro .env van como assets y faltar uno rompe el build.
Write-Host '== 1. Archivos requeridos'
$required = @('.env.prod', '.env.dev', '.env.staging', 'android\key.properties')
$missing = @($required | Where-Object { -not (Test-Path -LiteralPath (Join-Path $repoRoot $_)) })
if ($missing.Count -gt 0) {
    Stop-Release ("Faltan estos archivos: {0}. Ver RELEASE.md." -f ($missing -join ', '))
}
Write-Host '   OK: existen .env.prod, .env.dev, .env.staging y android\key.properties'

# 2. Version de Flutter fijada por el proyecto.
Write-Host "== 2. Version de Flutter (se espera $expectedFlutter)"
$flutterInfo = (& flutter --version --machine | Out-String) | ConvertFrom-Json
if ($flutterInfo.frameworkVersion -ne $expectedFlutter) {
    Stop-Release ("Flutter es {0} y el proyecto exige {1}." -f $flutterInfo.frameworkVersion, $expectedFlutter)
}
Write-Host "   OK: Flutter $($flutterInfo.frameworkVersion)"

# 3. Rutas del SDK de Android y de Java, tal como las reporta flutter doctor.
Write-Host '== 3. SDK de Android y Java (flutter doctor -v)'
$doctor = & flutter doctor -v | Out-String
$sdkMatch = [regex]::Match($doctor, 'Android SDK at (.+)')
$javaMatch = [regex]::Match($doctor, 'Java binary at:\s*(.+)')
if (-not $sdkMatch.Success -or -not $javaMatch.Success) {
    Stop-Release 'flutter doctor -v no reporta "Android SDK at" o "Java binary at".'
}
$sdkDir = $sdkMatch.Groups[1].Value.Trim()
$javaBin = $javaMatch.Groups[1].Value.Trim()
$env:JAVA_HOME = Split-Path -Parent (Split-Path -Parent $javaBin)
$buildTools = Get-ChildItem -Directory (Join-Path $sdkDir 'build-tools') |
    Sort-Object { [version]($_.Name -replace '[^0-9.].*$', '') } -Descending |
    Select-Object -First 1
if ($null -eq $buildTools) {
    Stop-Release "No hay build-tools en $sdkDir."
}
$aapt = Join-Path $buildTools.FullName 'aapt.exe'
$apksigner = Join-Path $buildTools.FullName 'apksigner.bat'
Write-Host "   SDK: $sdkDir"
Write-Host "   build-tools: $($buildTools.Name)"
Write-Host "   JAVA_HOME: $env:JAVA_HOME"

# 4. Compilacion. APK universal, sin --split-per-abi.
Write-Host '== 4. flutter build apk --release --dart-define=FLAVOR=prod'
& flutter build apk --release --dart-define=FLAVOR=prod
if ($LASTEXITCODE -ne 0) {
    Stop-Release "flutter build termino con codigo $LASTEXITCODE."
}

$apk = Join-Path $repoRoot 'build\app\outputs\flutter-apk\app-release.apk'
if (-not (Test-Path -LiteralPath $apk)) {
    Stop-Release "No se encontro el APK en $apk."
}

# 5. Ruta, tamano y SHA-256 del APK.
Write-Host '== 5. APK'
$apkItem = Get-Item -LiteralPath $apk
$sha256 = (Get-FileHash -Algorithm SHA256 -LiteralPath $apk).Hash.ToLowerInvariant()
Write-Host "   Ruta:    $($apkItem.FullName)"
Write-Host ("   Tamano:  {0:N1} MB ({1} bytes)" -f ($apkItem.Length / 1MB), $apkItem.Length)
Write-Host "   SHA-256: $sha256"

# 6. Permisos reales del APK.
Write-Host '== 6. Permisos (aapt dump permissions)'
if (Test-Path -LiteralPath $aapt) {
    & $aapt dump permissions $apk
} else {
    Write-Host "   AVISO: no hay aapt en $($buildTools.FullName); revisa los permisos a mano."
}

# 7. Firma. Un APK firmado con la llave de debug no se entrega.
Write-Host '== 7. Firma (apksigner verify --print-certs)'
if (-not (Test-Path -LiteralPath $apksigner)) {
    Stop-Release "No hay apksigner en $($buildTools.FullName); la firma no se pudo verificar."
}
$certs = & $apksigner verify --print-certs $apk | Out-String
if ($LASTEXITCODE -ne 0) {
    Stop-Release 'apksigner no pudo verificar la firma del APK.'
}
Write-Host $certs.Trim()
if ($certs -match 'Android Debug') {
    Stop-Release 'El APK esta firmado con la llave de debug. No lo distribuyas.'
}

Write-Host ''
Write-Host 'Listo: APK release firmado con la llave propia.' -ForegroundColor Green
Write-Host "SHA-256 para la Release de GitHub: $sha256"
Pop-Location
