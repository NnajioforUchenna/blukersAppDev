# Actions During Deployment
1. Firebase options... Make sure Production details is selected before deployment
2. Stripe Payment Details
3. Base Url


# Deploying to IOS
1. Change the version in the pubspec.yaml file last number (version: 1.0.14)
2. Run the following command in the terminal
```flutter build ipa
```

# Deploying to Android
1. Change the version in the pubspec.yaml file last number (version: 1.0.1+23)
2. Run the following command in the terminal
```flutter build appbundle
```

# Deploying to Web
1. flutter build web
2. firebase deploy
```