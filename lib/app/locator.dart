import 'package:get_it/get_it.dart';
import 'package:mindmesh/app/theme/theme.dart';
import 'package:mindmesh/services/file_picker_service.dart';
import 'package:mindmesh/services/hive_service.dart';
import 'package:mindmesh/services/http_service.dart';
import 'package:mindmesh/services/navigation_service.dart';
import 'package:mindmesh/services/snackbar_service.dart';


GetIt locator = GetIt.instance;
void setupLocator(){
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => AppTheme());
  locator.registerLazySingleton(() => HttpService());
  locator.registerLazySingleton(() => HiveService());
  locator.registerLazySingleton(() => SnackBarService());
  locator.registerLazySingleton(() => FilePickerService());
}
