import 'package:ecom/features/auth/domain/usecases/check_user_usecase.dart';
import 'package:ecom/features/auth/domain/usecases/set_user_data_usecase.dart';
import 'package:ecom/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:ecom/features/auth/domain/usecases/signin_with_google_usecase.dart';
import 'package:ecom/features/catalog/data/data_source/product_data_source.dart';
import 'package:ecom/features/catalog/data/repository/product_repository_impl.dart';
import 'package:ecom/features/catalog/domain/repository/product_repository.dart';
import 'package:ecom/features/catalog/domain/usecase/get_product_data_usecase.dart';
import 'package:ecom/features/catalog/presentation/bloc/catalog_bloc.dart';
import 'package:ecom/features/profile/data/data%20source/user_data_source.dart';
import 'package:ecom/features/profile/data/repository/profile_repository_impl.dart';
import 'package:ecom/features/profile/domain/usecase/fetch_user_data_usecase.dart';
import 'package:ecom/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:ecom/shared/validation/bloc/validation_bloc.dart';
import 'package:get_it/get_it.dart';

import 'core/firebaseFunctions/firebase_auth.dart';
import 'core/utils/text_validator.dart';
import 'features/auth/data/dataSource/auth_data_source.dart';
import 'features/auth/data/repository/auth_repository_impl.dart';
import 'features/auth/domain/repository/auth_repository.dart';
import 'features/auth/domain/usecases/login_with_email_usecase.dart';
import 'features/auth/domain/usecases/signup_with_email_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/profile/domain/repository/profile_repository.dart';

final sl = GetIt.instance;

void init() {
  // bloc
  sl.registerFactory(
    () => AuthBloc(
      checkUserUsercase: sl(),
      loginUsecase: sl(),
      signupUsecase: sl(),
      googleSigninUsecase: sl(),
      signOutUsecase: sl(),
      setUserDataUsecase: sl(),
    ),
  );

  sl.registerFactory(
    () => ValidationBloc(
      textValidator: sl(),
    ),
  );

  sl.registerFactory(
    () => CatalogBloc(
      getProductDataUsecase: sl(),
    ),
  );
  sl.registerFactory(
    () => ProfileBloc(
      fetchUserDataUsecase: sl(),
    ),
  );

  //usecase
  sl.registerLazySingleton(() => LoginWithEmailUsecase(repository: sl()));
  sl.registerLazySingleton(() => SignupWithEmailUsecase(repository: sl()));
  sl.registerLazySingleton(() => SigninWithGoogleUsecase(repository: sl()));
  sl.registerLazySingleton(() => CheckUserUsercase(repository: sl()));
  sl.registerLazySingleton(() => SignOutUsecase(repository: sl()));

  sl.registerLazySingleton(() => GetProductDataUsecase(repository: sl()));
  sl.registerLazySingleton(() => FetchUserDataUsecase(repository: sl()));
  sl.registerLazySingleton(() => SetUserDataUsecase(repository: sl()));

  //repo
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      dataSource: sl(),
    ),
  );
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      dataSource: sl(),
    ),
  );
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      dataSource: sl(),
    ),
  );

  // datasource
  sl.registerLazySingleton<AuthDataSource>(
      () => AuthDataSourceImpl(fireAuth: sl()));

  sl.registerLazySingleton<ProductDataSource>(() => ProductDataSourceImpl());
  sl.registerLazySingleton<UserDataSource>(
      () => UserDataSourceImpl(fireAuth: sl()));

  //core

  sl.registerLazySingleton<TextValidator>(() => TextValidator());
  sl.registerLazySingleton<FireAuth>(() => FireAuth());
}
