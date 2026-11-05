group = "com.baseflow.googleapiavailability"
version = "1.0"

buildscript {
    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        classpath("com.android.tools.build:gradle:9.1.0")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

plugins {
    id("com.android.library")
}

android {
    namespace = "com.baseflow.googleapiavailability"

    compileSdk = 36

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        minSdk = 16
    }

    lint {
        disable.add("InvalidPackage")
    }
}

dependencies {
    implementation("com.google.android.gms:play-services-base:18.1.0")
    implementation("androidx.annotation:annotation:1.11.0")
}
