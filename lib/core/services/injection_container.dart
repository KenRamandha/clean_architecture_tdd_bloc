import 'package:clean_rchitecture_tdd_bloc/src/authentification/data/datasources/authentification_remote_data_source.dart';
import 'package:clean_rchitecture_tdd_bloc/src/authentification/data/repositories/authentification_repository_implementation.dart';
import 'package:clean_rchitecture_tdd_bloc/src/authentification/domain/repositories/authentification_repository.dart';
import 'package:clean_rchitecture_tdd_bloc/src/authentification/domain/usecases/create_user.dart';
import 'package:clean_rchitecture_tdd_bloc/src/authentification/domain/usecases/get_users.dart';
import 'package:clean_rchitecture_tdd_bloc/src/authentification/persentation/cubit/authentification_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  sl
    // App Logic
    ..registerFactory(
      () => AuthentificationCubit(
        createUser: sl(),
        getUsers: sl(),
      ),
    )
    // Use Case
    ..registerLazySingleton(() => CreateUser(sl()))
    ..registerLazySingleton(() => GetUsers(sl()))

    // Repositorie
    ..registerLazySingleton<AuthentificationRepository>(
      () => AuthentificationRepositoryImplementation(sl()),
    )

    // DataSorce
    ..registerLazySingleton<AuthentificationRemoteDataSource>(
      () => AuthentificationRemoteDatasourceImplementation(sl()),
    )

    // External Dependencies
    ..registerLazySingleton(() => http.Client());
}