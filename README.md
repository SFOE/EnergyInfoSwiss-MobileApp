# EnergyInfoSwiss

#### Project setup
1. Clone repository: ``git clone git@gitlab.ti8m.ch:bfe-energie-dashboard/energy-dashboard-flutter-app.git``
2. Pull latest changes from repository (on develop branch): ``git pull``
3. Get flutter dependencies: ``flutter pub get``
4. Make sure you are registered in Amplify Studio and have access to the EnergyInfo-Swiss app. Amplify Studio: https://eu-central-1.admin.amplifyapp.com/admin/d275p8bhezlplb/staging/home
5. Make sure Amplify CLI is installed and configured on your local machine: https://docs.amplify.aws/cli/start/install/
6. Pull Amplify into your project (in root directory): ``amplify pull --appId d275p8bhezlplb --envName staging``
7. Follow the instructions of Amplify CLI
8. After successfully pulling backend environment staging from the cloud, you can run the app


#### Platform requirements (since Amplify integration)
- Android minimum API level: 24
- Gradle version: 7
- Kotlin: > 1.7
- iOS minimum deployment target: 13.0
