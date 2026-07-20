import java.util.Properties

plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = Properties()
check(keystorePropertiesFile.exists()) {
    "Missing android/key.properties. Release builds require a configured keystore."
}

keystorePropertiesFile.inputStream().use { keystoreProperties.load(it) }

val releaseKeyAlias = keystoreProperties["keyAlias"] as String?
val releaseKeyPassword = keystoreProperties["keyPassword"] as String?
val releaseStoreFile = keystoreProperties["storeFile"] as String?
val releaseStorePassword = keystoreProperties["storePassword"] as String?

check(!releaseKeyAlias.isNullOrBlank()) { "Missing keyAlias in android/key.properties" }
check(!releaseKeyPassword.isNullOrBlank()) { "Missing keyPassword in android/key.properties" }
check(!releaseStoreFile.isNullOrBlank()) { "Missing storeFile in android/key.properties" }
check(!releaseStorePassword.isNullOrBlank()) { "Missing storePassword in android/key.properties" }

val resolvedReleaseKeyAlias = requireNotNull(releaseKeyAlias)
val resolvedReleaseKeyPassword = requireNotNull(releaseKeyPassword)
val resolvedReleaseStoreFile = requireNotNull(releaseStoreFile)
val resolvedReleaseStorePassword = requireNotNull(releaseStorePassword)

android {
    namespace = "com.aryanyadav.my_lexicon"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.aryanyadav.my_lexicon"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            keyAlias = resolvedReleaseKeyAlias
            keyPassword = resolvedReleaseKeyPassword
            storeFile = file(resolvedReleaseStoreFile)
            storePassword = resolvedReleaseStorePassword
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
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
