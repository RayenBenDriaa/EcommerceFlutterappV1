import '/core/services/api_service.dart';
import '/core/states/request_state.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

setupLocator(){
  locator.registerLazySingleton(() => RequestState());
  locator.registerLazySingleton(() => ApiService());
}