# Rousheta Ragameya (روشتة رقمية)

**Egyptian Digital Prescription System**

A comprehensive mobile application solution for digital prescription management in Egypt, featuring both Android and iOS native applications with a complete backend infrastructure.

## 🎯 Project Overview

Rousheta Ragameya is a digital prescription platform designed specifically for the Egyptian healthcare market, providing:

- **Digital Prescription Management**: Secure handling of medical prescriptions
- **Egyptian Market Localization**: Arabic/English bilingual support with RTL layout
- **SMS Integration**: Cequens SMS service for notifications and verification
- **QR Code System**: Secure prescription verification for pharmacies
- **Location Services**: Find nearby pharmacies
- **HealthFlow Branding**: Professional medical app design

## 📱 Applications

### Android App
- **Technology**: Kotlin + Jetpack Compose
- **Design**: Material Design 3
- **Features**: Egyptian National ID validation, SMS integration, bilingual support
- **Location**: `./android/`

### iOS App
- **Technology**: Swift + SwiftUI
- **Design**: Apple Human Interface Guidelines
- **Features**: Native iOS implementation with matching functionality
- **Location**: `./ios/`

## 🏗️ Architecture

### Backend API
- **Technology**: Node.js + Express
- **Database**: PostgreSQL
- **Cache**: Redis
- **Location**: `./backend/`

### DevOps Infrastructure
- **Container**: Docker + Kubernetes
- **Cloud**: AWS (EKS, RDS, ElastiCache)
- **CI/CD**: GitHub Actions
- **Location**: `./devops/`

## 🚀 Quick Start

### Prerequisites
- Android Studio (for Android development)
- Xcode (for iOS development)
- Node.js 18+ (for backend)
- Docker & Docker Compose
- AWS CLI (for deployment)

### Local Development

1. **Clone the repository**
   ```bash
   git clone https://github.com/HealthFlowEgy/rousheta-ragameya.git
   cd rousheta-ragameya
   ```

2. **Start backend services**
   ```bash
   docker-compose up -d
   ```

3. **Run Android app**
   ```bash
   cd android
   ./gradlew assembleDebug
   ```

4. **Run iOS app**
   ```bash
   cd ios
   pod install
   open RoushetaRagameya.xcworkspace
   ```

## 🔧 Configuration

### Environment Variables
Copy `.env.example` to `.env` and configure:
- Cequens SMS credentials
- Database connections
- JWT secrets
- API endpoints

### Build Configuration
- **Android**: Configure signing keys in `android/app/build.gradle`
- **iOS**: Configure provisioning profiles in Xcode
- **Backend**: Set environment-specific configs in `backend/config/`

## 📦 Deployment

### Staging Deployment
```bash
./devops/scripts/deploy.sh staging apply
```

### Production Deployment
```bash
./devops/scripts/deploy.sh production apply
```

## 🧪 Testing

### Android Testing
```bash
cd android
./gradlew test
./gradlew connectedAndroidTest
```

### iOS Testing
```bash
cd ios
xcodebuild test -workspace RoushetaRagameya.xcworkspace -scheme RoushetaRagameya
```

### Backend Testing
```bash
cd backend
npm test
npm run test:integration
```

## 📋 Features

### Core Functionality
- ✅ User registration and authentication
- ✅ Egyptian National ID validation (14-digit format)
- ✅ Egyptian phone number validation
- ✅ Prescription management and viewing
- ✅ QR code generation and scanning
- ✅ Pharmacy location services
- ✅ SMS notifications via Cequens
- ✅ Bilingual Arabic/English support
- ✅ RTL (Right-to-Left) text direction

### Security Features
- ✅ JWT-based authentication
- ✅ Encrypted data storage
- ✅ Secure API communication
- ✅ Input validation and sanitization

### Egyptian Localization
- ✅ Arabic as primary language
- ✅ Egyptian National ID format validation
- ✅ Egyptian mobile number formats
- ✅ Cultural UI/UX considerations
- ✅ Cairo font support for Arabic text

## 🏥 HealthFlow Integration

This application is part of the HealthFlow ecosystem:
- **Brand Colors**: #1e3a8a (blue), #d97706 (gold)
- **Design System**: Consistent across all HealthFlow products
- **API Integration**: Compatible with HealthFlow backend services

## 📱 App Store Information

### Android (Google Play)
- **Package Name**: `com.healthflow.rousheta`
- **Min SDK**: 24 (Android 7.0)
- **Target SDK**: 34 (Android 14)

### iOS (App Store)
- **Bundle ID**: `com.healthflow.rousheta`
- **Min iOS**: 15.0
- **Target iOS**: 17.0

## 🔐 Security & Compliance

- **Data Encryption**: AES-256 encryption for sensitive data
- **HIPAA Compliance**: Healthcare data protection standards
- **Egyptian Regulations**: Compliant with local healthcare laws
- **Privacy**: No personal data collection without consent

## 📞 Support

For technical support and inquiries:
- **Email**: support@healthflow.com
- **Website**: https://healthflow.com
- **Documentation**: https://docs.healthflow.com

## 📄 License

Copyright © 2025 HealthFlow. All rights reserved.

---

**Built with ❤️ for Egyptian Healthcare**
