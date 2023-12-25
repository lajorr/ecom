import 'package:ecom/features/auth/domain/usecases/signin_with_google_usecase.dart';
import 'package:get_it/get_it.dart';

import 'core/firebaseFunctions/firebase_auth.dart';
import 'core/utils/text_validator.dart';
import 'features/auth/data/dataSource/auth_data_source.dart';
import 'features/auth/data/repository/auth_repository_impl.dart';
import 'features/auth/domain/repository/auth_repository.dart';
import 'features/auth/domain/usecases/login_with_email_usecase.dart';
import 'features/auth/domain/usecases/signup_with_email_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

void init() {
  // bloc
  sl.registerFactory(
    () => AuthBloc(
      textValidator: sl(),
      loginUsecase: sl(),
      signupUsecase: sl(),
      googleSigninUsecase: sl(),
    ),
  );

  //usecase
  sl.registerLazySingleton(() => LoginWithEmailUsecase(repository: sl()));
  sl.registerLazySingleton(() => SignupWithEmailUsecase(repository: sl()));
  sl.registerLazySingleton(() => SigninWithGoogleUsecase(repository: sl()));

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
