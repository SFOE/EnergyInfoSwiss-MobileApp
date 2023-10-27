import 'package:energy_dashboard/core/helpers/api_base_helper.dart';
import 'package:energy_dashboard/core/helpers/web_base_helper.dart';
import 'package:energy_dashboard/core/utils/localization.dart';
import 'package:energy_dashboard/data/repositories/api_repository.dart';
import 'package:energy_dashboard/data/repositories/auth_repository.dart';
import 'package:energy_dashboard/data/repositories/database_repository.dart';
import 'package:energy_dashboard/domain/services/kpi_manager.dart';
import 'package:get_it/get_it.dart';


// register all singletons for service locator
initDI() async {
  GetIt.I.registerSingleton(ApiRepository());
  GetIt.I.registerSingleton(ApiBaseHelper());
  GetIt.I.registerSingleton(WebBaseHelper());
  GetIt.I.registerSingleton(AppLocalization());
  GetIt.I.registerSingleton(DatabaseRepository());
  GetIt.I.registerSingleton(AuthRepository());
  GetIt.I.registerLazySingleton(() => KPIManager());  // keep lazy
}