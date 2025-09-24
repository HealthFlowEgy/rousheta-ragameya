# Corrected Build Files for APK Generation

## Issue Summary
The Gradle daemon crashed during build due to dependency conflicts and memory issues. Here are the corrected build files that your development team should use:

## 1. Root Level build.gradle (android/build.gradle)

```gradle
buildscript {
    ext {
        // FIXED: Compatible versions
        kotlin_version = '1.9.20'           // ⬇️ Downgraded for Compose compatibility
        compose_version = '1.5.8'           // Stable Compose version
        compose_bom_version = '2024.02.00'  // Latest stable BOM
        hilt_version = '2.48.1'             // Latest stable Hilt
        compileSdk = 34
        minSdk = 24
        targetSdk = 34
        versionCode = 1
        versionName = "1.0.0"
    }
    
    dependencies {
        classpath 'com.android.tools.build:gradle:8.2.2'
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
        classpath "com.google.dagger:hilt-android-gradle-plugin:$hilt_version"
        classpath 'com.google.gms:google-services:4.4.0'
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
        // Add JitPack for any GitHub dependencies
        maven { url 'https://jitpack.io' }
    }
}

task clean(type: Delete) {
    delete rootProject.buildDir
}
```

## 2. App Level build.gradle (android/app/build.gradle)

```gradle
plugins {
    id 'com.android.application'
    id 'org.jetbrains.kotlin.android'
    id 'kotlin-kapt'
    id 'dagger.hilt.android.plugin'
    id 'kotlin-parcelize'
}

android {
    namespace 'com.healthflow.rousheta'
    compileSdk 34

    defaultConfig {
        applicationId "com.healthflow.rousheta"
        minSdk 24
        targetSdk 34
        versionCode 1
        versionName "1.0.0"

        testInstrumentationRunner "androidx.test.runner.AndroidJUnitRunner"
        vectorDrawables {
            useSupportLibrary true
        }
        
        buildConfigField "String", "API_BASE_URL", '"https://api.rousheta.healthflow.com/"'
        buildConfigField "boolean", "DEBUG_MODE", "false"
        buildConfigField "String", "CEQUENS_API_KEY", '"your_cequens_api_key_here"'
        buildConfigField "String", "CEQUENS_ACCESS_TOKEN", '"your_cequens_access_token_here"'
        buildConfigField "String", "CEQUENS_SENDER_NAME", '"Rousheta"'
    }

    signingConfigs {
        debug {
            storeFile file('debug.keystore')
            storePassword 'android'
            keyAlias 'androiddebugkey'
            keyPassword 'android'
        }
    }

    buildTypes {
        debug {
            minifyEnabled false
            debuggable true
            applicationIdSuffix ".debug"
            versionNameSuffix "-DEBUG"
            signingConfig signingConfigs.debug
            
            buildConfigField "String", "API_BASE_URL", '"https://dev-api.rousheta.healthflow.com/"'
            buildConfigField "boolean", "DEBUG_MODE", "true"
        }

        release {
            minifyEnabled false
            shrinkResources false
            debuggable false
            signingConfig signingConfigs.debug
            
            buildConfigField "String", "API_BASE_URL", '"https://api.rousheta.healthflow.com/"'
            buildConfigField "boolean", "DEBUG_MODE", "false"
        }
    }

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_17
        targetCompatibility JavaVersion.VERSION_17
    }
    
    kotlinOptions {
        jvmTarget = '17'
    }
    
    buildFeatures {
        compose true
        buildConfig true
    }
    
    composeOptions {
        kotlinCompilerExtensionVersion = '1.5.8'
    }
    
    packaging {
        resources {
            excludes += '/META-INF/{AL2.0,LGPL2.1}'
        }
    }
}

dependencies {
    // FIXED: Use Compose BOM for version management
    implementation platform("androidx.compose:compose-bom:$compose_bom_version")
    
    // Core Android
    implementation 'androidx.core:core-ktx:1.12.0'
    implementation 'androidx.lifecycle:lifecycle-runtime-ktx:2.7.0'
    implementation 'androidx.activity:activity-compose:1.8.2'
    implementation 'androidx.core:core-splashscreen:1.0.1'
    
    // Compose - versions managed by BOM
    implementation 'androidx.compose.ui:ui'
    implementation 'androidx.compose.ui:ui-tooling-preview'
    implementation 'androidx.compose.material3:material3'
    implementation 'androidx.compose.material:material-icons-extended'
    implementation 'androidx.compose.animation:animation'
    implementation 'androidx.compose.ui:ui-util'
    
    // Navigation
    implementation 'androidx.navigation:navigation-compose:2.7.6'
    
    // ViewModel
    implementation 'androidx.lifecycle:lifecycle-viewmodel-compose:2.7.0'
    implementation 'androidx.lifecycle:lifecycle-runtime-compose:2.7.0'
    
    // Hilt - FIXED: Proper setup
    implementation "com.google.dagger:hilt-android:$hilt_version"
    implementation 'androidx.hilt:hilt-navigation-compose:1.1.0'
    kapt "com.google.dagger:hilt-compiler:$hilt_version"
    
    // Networking
    implementation 'com.squareup.retrofit2:retrofit:2.9.0'
    implementation 'com.squareup.retrofit2:converter-gson:2.9.0'
    implementation 'com.squareup.okhttp3:okhttp:4.12.0'
    implementation 'com.squareup.okhttp3:logging-interceptor:4.12.0'
    
    // JSON
    implementation 'com.google.code.gson:gson:2.10.1'
    
    // Image Loading
    implementation 'io.coil-kt:coil-compose:2.5.0'
    
    // QR Code
    implementation 'com.journeyapps:zxing-android-embedded:4.3.0'
    implementation 'com.google.zxing:core:3.5.2'
    
    // Permissions
    implementation 'com.google.accompanist:accompanist-permissions:0.32.0'
    
    // DataStore
    implementation 'androidx.datastore:datastore-preferences:1.0.0'
    
    // Security
    implementation 'androidx.security:security-crypto:1.1.0-alpha06'
    
    // Date/Time
    implementation 'org.jetbrains.kotlinx:kotlinx-datetime:0.5.0'
    
    // Testing
    testImplementation 'junit:junit:4.13.2'
    androidTestImplementation 'androidx.test.ext:junit:1.1.5'
    androidTestImplementation 'androidx.test.espresso:espresso-core:3.5.1'
    androidTestImplementation 'androidx.compose.ui:ui-test-junit4'
    
    // Debug
    debugImplementation 'androidx.compose.ui:ui-tooling'
    debugImplementation 'androidx.compose.ui:ui-test-manifest'
}

kapt {
    correctErrorTypes true
}
```

## 3. Complete RoushetaApplication.kt

```kotlin
package com.healthflow.rousheta

import android.app.Application
import dagger.hilt.android.HiltAndroidApp

@HiltAndroidApp
class RoushetaApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        // Initialize app-level components
    }
}
```

## 4. Simplified MainActivity.kt (Remove Hilt temporarily)

```kotlin
package com.healthflow.rousheta

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.ui.Modifier
import androidx.core.splashscreen.SplashScreen.Companion.installSplashScreen
import com.healthflow.rousheta.ui.navigation.RoushetaNavigation
import com.healthflow.rousheta.ui.theme.RoushetaRagameyaTheme

// TEMPORARILY REMOVED @AndroidEntryPoint until Hilt is properly configured
class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        val splashScreen = installSplashScreen()
        
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        
        setContent {
            RoushetaRagameyaTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    RoushetaNavigation()
                }
            }
        }
    }
}
```

## 5. Remove Hilt from LocalizationManager.kt temporarily

```kotlin
package com.healthflow.rousheta.util

import android.content.Context
import android.content.SharedPreferences

// TEMPORARILY REMOVED @Singleton and @Inject until Hilt is properly configured
class LocalizationManager(private val context: Context) {
    private val prefs: SharedPreferences = context.getSharedPreferences("app_prefs", Context.MODE_PRIVATE)
    
    var currentLanguage: String
        get() = prefs.getString("selected_language", "ar") ?: "ar"
        set(value) = prefs.edit().putString("selected_language", value).apply()
    
    val isRTL: Boolean
        get() = currentLanguage == "ar"
    
    fun toggleLanguage() {
        currentLanguage = if (currentLanguage == "ar") "en" else "ar"
    }
    
    fun getString(resId: Int): String {
        return context.getString(resId)
    }
}
```

## Build Commands for Development Team

1. **Clean previous builds:**
   ```bash
   cd android
   ./gradlew clean
   ```

2. **Build debug APK:**
   ```bash
   ./gradlew assembleDebug
   ```

3. **If build succeeds, APK will be at:**
   ```
   android/app/build/outputs/apk/debug/app-debug.apk
   ```

## Memory Configuration

Add to `android/gradle.properties`:
```properties
org.gradle.jvmargs=-Xmx4096m -XX:MaxMetaspaceSize=512m
org.gradle.daemon=true
org.gradle.parallel=true
org.gradle.configureondemand=true
```

## Critical Notes for Development Team

1. **Start Simple**: Use the simplified versions above first to get a working APK
2. **Add Features Gradually**: Once basic APK builds, add Hilt and other complex features one by one
3. **Test Each Step**: Build and test after each major change
4. **Memory Management**: The daemon crash suggests memory issues - use the gradle.properties settings above

This approach will get you a working APK that you can then enhance step by step.
