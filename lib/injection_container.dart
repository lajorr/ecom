import 'package:ecom/core/firebaseFunctions/firebase_auth.dart';
import 'package:ecom/core/utils/text_validator.dart';
import 'package:ecom/features/auth/data/dataSource/auth_data_source.dart';
import 'package:ecom/features/auth/data/repository/auth_repository_impl.dart';
import 'package:ecom/features/auth/domain/repository/auth_repository.dart';
import 'package:ecom/features/auth/domain/usecases/login_with_email_usecase.dart';
import 'package:ecom/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void init() {
  // bloc
  sl.registerFactory(
    () => AuthBloc(
      textValidator: sl(),
      loginUsecase: sl(),
    ),
  );

  //usecase
  sl.registerLazySingleton(() => LoginWithEmailUsecase(repository: sl()));

  //repo
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      dataSource: sl(),
    ),
  );

  // datasource
  sl.registerLazySingleton<AuthDataSource>(
      () => AuthDataSourceImpl(fireAuth: sl()));

  //core

  sl.registerLazySingleton<TextValidator>(() => TextValidator());
  sl.registerLazySingleton<FireAuth>(() => FireAuth());
}
