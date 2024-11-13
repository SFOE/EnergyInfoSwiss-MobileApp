# EnergyInfoSwiss

#### Project setup

1. Clone repository: `git clone git@gitlab.ti8m.ch:bfe-energie-dashboard/energy-dashboard-flutter-app.git`
2. Pull latest changes from repository (on develop branch): `git pull`
3. Get flutter dependencies: `flutter pub get`
4. Make sure you are registered in Amplify Studio and have access to the EnergyInfo-Swiss app. Amplify Studio: https://eu-central-1.admin.amplifyapp.com/admin/d275p8bhezlplb/staging/home
5. Make sure Amplify CLI is installed and configured on your local machine: https://docs.amplify.aws/cli/start/install/
6. Pull Amplify into your project (in root directory): `amplify pull --appId d275p8bhezlplb --envName staging`
7. Follow the instructions of Amplify CLI
8. After successfully pulling backend environment staging from the cloud, you can run the app

#### DEV development

- to ensure you develop agains DEV environment, you have to change the url's
  - in api_base_helper.dart to `kApiBaseUrlDev`
  - in web_base_helper.dart to `kWebBaseUrlDev`

#### Release

1. increase the version in pubspec.yaml
2. after the + set the versionName (just increment one)
3. run `flutter build apk` to ensure the versionName will be written into local.properties

To build iOS you need the following:

- Make sure you installed cocoapods `sudo gem install cocoapods` and pods are installed in the ios folder `cd ios` => `pod install`
- If you have some errors, make sure you update all possible dependencies with `flutter pub upgrade`

##### Android

1. run `flutter build appbundle`
2. create a release in play console
3. upload app bundle to new release in play console

##### iOS

1. run `open ios/Runner.xcworkspace` to open the project in xcode
2. in the general tab, update the version and the build number
3. in the signing & capabilities tab make sure auotmatically signing is checked and the correct team is selected (Bundesamt fuer Energie BFE)
4. run `flutter build ipa` or build directly in xcode (Product > Build)
5. you need to upload the builded ipa to appstoreconnect, for that you can use the transporter app from apple https://apps.apple.com/us/app/transporter/id1450874784?mt=12

#### Platform requirements (since Amplify integration)

- Android minimum API level: 24
- Gradle version: 7
- Kotlin: > 1.7
- iOS minimum deployment target: 13.0
