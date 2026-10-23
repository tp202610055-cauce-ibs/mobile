# Release de Cauce Mobile

Cómo generar, verificar, publicar e instalar el APK release de Android. Todos los comandos son de PowerShell y se escriben desde la raíz del repo `mobile`, salvo que el paso diga otra cosa.

| Dato | Valor |
|---|---|
| Plataforma | Solo Android 8.0 o superior (minSdk 26) |
| applicationId | `pe.upc.cauce.cauce_mobile`. No se cambia nunca |
| Backend | `https://portal.cauceibs.org` |
| Flutter | 3.44.2 exacto. El script se detiene con otra versión |
| Tipo de APK | Universal, un solo archivo para todos los teléfonos |

## 1. Archivos que el build necesita y que git no guarda

| Archivo | Qué es | Quién lo crea |
|---|---|---|
| `.env.prod` | Configuración del entorno de producción | Tú, una vez |
| `.env.dev` y `.env.staging` | Configuración de los otros entornos. El build los empaqueta igual, así que tienen que existir | Ya existen en la laptop de desarrollo |
| `android/key.properties` | Dónde está la llave de firma y sus contraseñas | Tú, en el paso 2 |
| El archivo `.jks` | La llave de firma | Tú, en el paso 2, **fuera del repo** |

Los archivos `.env.*` empaquetados viajan dentro del APK. **Nunca llevan secretos**: solo direcciones y nombres públicos.

### Claves de `.env.prod`

Son las mismas que las de `.env.example`, y ninguna es secreta:

| Clave | Valor en producción |
|---|---|
| `API_BASE_URL` | `https://portal.cauceibs.org` (sin `/api/v1`, porque el cliente ya lo agrega) |
| `ENV_NAME` | `prod` |
| `CLIENT_ID` | `cauce-mobile` |
| `DEEP_LINK_SCHEME` | `cauce` |

El archivo completo, para copiar:

```properties
API_BASE_URL=https://portal.cauceibs.org
ENV_NAME=prod
CLIENT_ID=cauce-mobile
DEEP_LINK_SCHEME=cauce
```

## 2. Generar la llave de firma (una sola vez)

La llave identifica a la app. **Si se pierde, ninguna actualización vuelve a instalarse encima de la app de los evaluadores:** tendrían que desinstalar y perder sus datos locales. Por eso el respaldo del paso 2.8 no es opcional.

**2.1. Abre PowerShell.** En el menú Inicio, escribe `PowerShell` y ábrelo. Luego entra al repo con `cd`, como de costumbre.

**2.2. Ubica `keytool`.** Escribe:

```powershell
flutter doctor -v
```

Busca la línea que empieza con `Java binary at:`. En esta laptop dice:

```
• Java binary at: C:\Program Files\Android\Android Studio\jbr\bin\java
```

`keytool.exe` está en esa misma carpeta: cambia el `java` final por `keytool.exe`. Si tu línea dice otra cosa, usa la tuya en los pasos siguientes.

**2.3. Crea la carpeta de la llave, fuera del repo:**

```powershell
New-Item -ItemType Directory -Force C:\Users\LENOVO\cauce-keys
```

**2.4. Genera la llave.** Es un solo comando. Cambia la ruta de `keytool.exe` si en el paso 2.2 te salió otra:

```powershell
& "C:\Program Files\Android\Android Studio\jbr\bin\keytool.exe" -genkeypair -v -keystore C:\Users\LENOVO\cauce-keys\cauce-upload.jks -storetype PKCS12 -keyalg RSA -keysize 2048 -validity 10000 -alias cauce
```

**2.5. Responde las preguntas de `keytool`:**

1. La contraseña del almacén, dos veces. Que sea larga y use **solo letras y números**: sin ñ, sin tildes y sin símbolos, porque en `key.properties` los caracteres como `\ # ! = :` se rompen. Al escribirla no aparece nada en pantalla: es normal.
2. Nombre y apellido, unidad, organización, ciudad, región y código de país de dos letras (`PE`). Ninguno de estos datos es secreto.
3. Al final te pide confirmar: escribe la palabra que te muestre (`sí` o `yes`).

Con este formato (PKCS12) hay una sola contraseña: la de la llave es la misma que la del almacén.

**2.6. Comprueba la llave.** Te pide la contraseña:

```powershell
& "C:\Program Files\Android\Android Studio\jbr\bin\keytool.exe" -list -v -keystore C:\Users\LENOVO\cauce-keys\cauce-upload.jks
```

Debe mostrar `Alias name: cauce` (o `Nombre de alias: cauce`) y una huella `SHA256:`. Anota esa huella junto al respaldo.

**2.7. Crea `android/key.properties`.** Abre el Bloc de notas con:

```powershell
notepad android\key.properties
```

Responde «Sí» cuando pregunte si quieres crear el archivo, pega estas cuatro líneas, reemplaza las contraseñas y guarda:

```properties
storeFile=C:/Users/LENOVO/cauce-keys/cauce-upload.jks
storePassword=LA_CONTRASENA_DEL_PASO_2.5
keyAlias=cauce
keyPassword=LA_MISMA_CONTRASENA
```

- En `storeFile` van **barras normales** (`/`). La barra invertida se rompe en un `.properties`.
- Sin comillas y sin espacios alrededor del `=`.

Confirma que git lo ignora:

```powershell
git check-ignore -v android/key.properties
```

Tiene que imprimir una línea que menciona `android/.gitignore`. Si no imprime nada, **no sigas** y avisa. Además, `git status` no debe listar `key.properties`.

**2.8. Respalda la llave y la contraseña fuera de la laptop y fuera del repo:**

- Copia `C:\Users\LENOVO\cauce-keys\cauce-upload.jks` a un lugar privado que no sea esta laptop, por ejemplo un USB guardado o una carpeta privada en la nube.
- Guarda la contraseña y la huella SHA-256 en un gestor de contraseñas, nunca en un archivo del repo ni junto al `.jks`.
- Nunca subas el `.jks` ni `key.properties` a GitHub.

Si falta `android/key.properties` o alguna de sus cuatro claves, el build release se detiene con un mensaje que nombra las claves ausentes. Nunca firma con la llave de debug.

## 3. Compilar

**3.1. Libera memoria.** Cierra Chrome y Docker Desktop, y espera a que no quede ningún `docker build` ni `dotnet test` corriendo.

**3.2. Corre el script:**

```powershell
powershell -ExecutionPolicy Bypass -File tools\build-release.ps1
```

El script hace esto, en orden, y se detiene en el primer problema:

1. Comprueba que existen `.env.prod`, `.env.dev`, `.env.staging` y `android\key.properties`. No los lee.
2. Comprueba que Flutter sea la 3.44.2.
3. Toma de `flutter doctor -v` la ruta del SDK de Android y la de Java.
4. Corre `flutter build apk --release --dart-define=FLAVOR=prod`.
5. Imprime la ruta, el tamaño y el SHA-256 del APK.
6. Vuelca los permisos con `aapt`.
7. Verifica la firma con `apksigner` y **falla si el certificado dice `Android Debug`**.

El APK queda en `build\app\outputs\flutter-apk\app-release.apk`. La primera compilación tarda varios minutos.

### Si te quedas sin memoria

Los síntomas son mensajes como `Java heap space`, `OutOfMemoryError`, `Could not reserve enough space` o `Gradle build daemon disappeared unexpectedly`.

1. Detén Gradle:

   ```powershell
   $env:JAVA_HOME = "C:\Program Files\Android\Android Studio\jbr"
   android\gradlew.bat --stop
   ```

   `JAVA_HOME` es la carpeta de la línea `Java binary at:` sin el `\bin\java` final.
2. Crea el archivo de Gradle de tu usuario:

   ```powershell
   notepad $env:USERPROFILE\.gradle\gradle.properties
   ```

   Pega esta línea y guarda:

   ```properties
   org.gradle.jvmargs=-Xmx3G -XX:MaxMetaspaceSize=1G -XX:ReservedCodeCacheSize=256m
   ```

   Este archivo pesa más que el `android/gradle.properties` del repo, así que Gradle usa 3 GB en vez de 8 sin tocar el repo. Puedes dejarlo puesto.
3. Vuelve a correr el script.

## 4. Verificar el APK

El script ya hace lo principal. Revisa su salida:

| Qué | Debe decir |
|---|---|
| Permisos (paso 6) | Incluye `android.permission.INTERNET`. Cualquier permiso que no esperes se reporta antes de publicar |
| Firma (paso 7) | El nombre que pusiste en el paso 2.5, nunca `CN=Android Debug`. La huella SHA-256 del certificado coincide con la del paso 2.6 |
| SHA-256 (paso 5) | Se copia tal cual en la Release |

Para confirmar el nombre visible y la versión:

```powershell
& "C:\Users\LENOVO\AppData\Local\Android\sdk\build-tools\36.0.0\aapt.exe" dump badging build\app\outputs\flutter-apk\app-release.apk | Select-String "package:|application-label:"
```

Debe mostrar `name='pe.upc.cauce.cauce_mobile'`, la `versionName` y la `versionCode` del `pubspec.yaml`, y `application-label:'Cauce'`. La ruta del SDK es la línea `Android SDK at` de `flutter doctor -v`.

## 5. Publicar como Release de GitHub

El repo `tp202610055-cauce-ibs/mobile` es público, así que el enlace de descarga funciona sin iniciar sesión.

1. Copia el APK con un nombre que diga la versión. El contenido y el SHA-256 no cambian:

   ```powershell
   Copy-Item build\app\outputs\flutter-apk\app-release.apk "$env:USERPROFILE\Desktop\cauce-0.10.0-10.apk"
   ```

   Usa `-` y no `+` en el nombre: el `+` se rompe en las URL.
2. En GitHub, entra a `tp202610055-cauce-ibs/mobile`, luego a **Releases** y a **Draft a new release**.
3. En **Choose a tag** elige el tag del cierre del bloque.
4. Título: `Cauce 0.10.0 (build 10)`.
5. Notas, con el SHA-256 que imprimió el script:

   ```
   APK release para Android 8.0 o superior. Backend: https://portal.cauceibs.org

   SHA-256 de cauce-0.10.0-10.apk:
   <pega aquí el SHA-256>
   ```

6. Arrastra `cauce-0.10.0-10.apk` desde el Escritorio a la caja de archivos adjuntos.
7. Pulsa **Publish release**.

El enlace directo para los evaluadores queda así:

```
https://github.com/tp202610055-cauce-ibs/mobile/releases/download/<tag>/cauce-0.10.0-10.apk
```

## 6. Instalar en un teléfono Android

**6.1. Si el teléfono tiene una build de desarrollo de Cauce, desinstálala antes.** La firma es distinta y Android rechaza la instalación encima con «App no instalada». Desinstalar borra los datos locales: si había registros pendientes de sincronizar, sincronízalos antes.

**6.2. Descarga el APK** desde el enlace de la Release, con el navegador del teléfono.

**6.3. Permite la instalación.** La primera vez, Android pide permiso para instalar apps desde el navegador («fuentes desconocidas» o «Instalar apps desconocidas»). Concédelo para ese navegador.

**6.4. Pasa el aviso de Play Protect.** Si dice que la app no es conocida o no está verificada, elige **Más detalles** y luego **Instalar de todas formas**. Si ofrece escanearla, puedes aceptar.

**6.5. En teléfonos Xiaomi con MIUI o HyperOS**, ve a **Ajustes > Aplicaciones > Administrar aplicaciones > Cauce** (el nombre del menú cambia un poco según la versión) y:

- Activa **Inicio automático**.
- En **Ahorro de batería**, elige **Sin restricciones**.

Sin esto, MIUI cierra la app en segundo plano y la sincronización se corta.

## 7. Pendientes conocidos de esta versión

- **Ícono:** usa el genérico de Flutter. El design system todavía no trae un asset de ícono.
- **Notificaciones push:** esta versión no las recibe.
