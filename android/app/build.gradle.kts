import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

val keystoreProperties = Properties()

android {
    namespace = "com.unistal.mdpe_approve_app"
    compileSdk = 35
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.unistal.mdpe_approve_app"
        minSdk = 24
        targetSdk = 35
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    flavorDimensions += "app"

    productFlavors {
        create("prodPBGPL") {
            dimension = "app"
            applicationIdSuffix = ".pbgmdpeapproval.app"
            resValue("string", "app_name", "MGL MDPE Approval")
            manifestPlaceholders.putAll(
                mapOf(
                    "appIcon" to "@mipmap/unistal_logo",
                    "appIconRound" to "@mipmap/unistal_logo"
                )
            )
        }
        create("prodMGL") {
            dimension = "app"
            applicationIdSuffix = ".mglmdpeapproval.app"
            resValue("string", "app_name", "MGL MDPE Approval")
            manifestPlaceholders.putAll(
                mapOf(
                    "appIcon" to "@mipmap/unistal_logo",
                    "appIconRound" to "@mipmap/unistal_logo"
                )
            )

            // Load keystore only for this flavor
            val keystorePropertiesFile = rootProject.file("mgl_mdpe_tpi.properties")
            if (keystorePropertiesFile.exists()) {
                keystoreProperties.load(FileInputStream(keystorePropertiesFile))
            }
        }
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String
            keyPassword = keystoreProperties["keyPassword"] as String
            storeFile = file(keystoreProperties["storeFile"] as String)
            storePassword = keystoreProperties["storePassword"] as String
        }
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = false
            isShrinkResources = false
            isDebuggable = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }

}

flutter {
    source = "../.."
}

dependencies {
    implementation("com.google.android.play:app-update:2.1.0")
    implementation("com.google.android.play:app-update-ktx:2.1.0")
    implementation(platform("com.google.firebase:firebase-bom:33.11.0"))
}
