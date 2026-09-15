plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "pe.upc.cauce.cauce_mobile"
    compileSdk = flutter.compileSdkVersion
    // ndkVersion = flutter.ndkVersion
    // Comentado el 2026-09-15: ningun plugin del proyecto compila codigo
    // nativo. No hay CMakeLists ni externalNativeBuild en el arbol, y
    // sqlite3_flutter_libs embarca .so precompilados. AGP resuelve esta
    // linea al configurar el proyecto, asi que exigia descargar 713 MB de
    // NDK en cada maquina para nada. Restaurar si entra una dependencia
    // con build nativo.

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "pe.upc.cauce.cauce_mobile"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        // API 26 explicito, por encima del default 24 de Flutter. Lo exige
        // CLAUDE.md seccion 3 para el piloto, y ademas cubre el minimo de
        // EncryptedSharedPreferences de flutter_secure_storage, que es API 23.
        minSdk = 26
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
