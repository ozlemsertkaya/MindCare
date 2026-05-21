android {
    namespace = "com.example.mindcare_app"
    compileSdk = 34

    ndkVersion = flutter.ndkVersion

    defaultConfig {
        applicationId = "com.example.mindcare_app"
        minSdk = 21
        targetSdk = 34

        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}