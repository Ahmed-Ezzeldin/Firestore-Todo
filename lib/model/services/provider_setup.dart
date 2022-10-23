import 'package:firebase_mvvm/model/services/auth_service.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/single_child_widget.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthService());
}

AuthService auth = locator<AuthService>();

List<SingleChildWidget> providers = [
  ...helpersProviders,
];

List<SingleChildWidget> helpersProviders = [
  // ChangeNotifierProvider(create: (_) => UserProvider()),
];
