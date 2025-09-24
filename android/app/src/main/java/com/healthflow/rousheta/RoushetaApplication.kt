package com.healthflow.rousheta

import android.app.Application
import android.content.res.Configuration
import dagger.hilt.android.HiltAndroidApp
import timber.log.Timber
import java.util.*
import javax.inject.Inject

@HiltAndroidApp
class RoushetaApplication : Application() {
    
    @Inject
    lateinit var localizationManager: com.healthflow.rousheta.util.LocalizationManager
    
    override fun onCreate() {
        super.onCreate()
        
        // Initialize Timber for logging
        if (BuildConfig.DEBUG) {
            Timber.plant(Timber.DebugTree())
        }
        
        // Initialize localization
        initializeLocalization()
        
        Timber.d("Rousheta Ragameya Application started")
    }
    
    private fun initializeLocalization() {
        val savedLanguage = getSharedPreferences("app_prefs", MODE_PRIVATE)
            .getString("selected_language", "ar") ?: "ar"
        
        updateLocale(savedLanguage)
    }
    
    private fun updateLocale(languageCode: String) {
        val locale = Locale(languageCode)
        Locale.setDefault(locale)
        
        val config = Configuration()
        config.setLocale(locale)
        config.setLayoutDirection(locale)
        
        resources.updateConfiguration(config, resources.displayMetrics)
    }
    
    override fun onConfigurationChanged(newConfig: Configuration) {
        super.onConfigurationChanged(newConfig)
        initializeLocalization()
    }
}
