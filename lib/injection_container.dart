import 'package:get_it/get_it.dart';

import 'core/firebaseFunctions/firebase_auth.dart';
import 'core/firebaseFunctions/firebase_collections.dart';
import 'core/utils/text_validator.dart';
import 'features/auth/data/dataSource/auth_data_source.dart';
import 'features/auth/data/repository/auth_repository_impl.dart';
import 'features/auth/domain/repository/auth_repository.dart';
import 'features/auth/domain/usecases/check_user_usecase.dart';
import 'features/auth/domain/usecases/login_with_email_usecase.dart';
import 'features/auth/domain/usecases/set_user_data_usecase.dart';
import 'features/auth/domain/usecases/sign_out_usecase.dart';
import 'features/auth/domain/usecases/signin_with_google_usecase.dart';
import 'features/auth/domain/usecases/signup_with_email_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/catalog/data/data_source/like_collection_data_source.dart';
import 'features/catalog/data/data_source/product_data_source.dart';
import 'features/catalog/data/repository/product_repository_impl.dart';
import 'features/catalog/domain/repository/product_repository.dart';
import 'features/catalog/domain/usecase/create_like_document.dart';
import 'features/catalog/domain/usecase/fetch_like_doc_usecase.dart';
import 'features/catalog/domain/usecase/get_product_data_usecase.dart';
import 'features/catalog/domain/usecase/like_unlike_prod_usecase.dart';
import 'features/catalog/presentation/blocs/catalog bloc/catalog_bloc.dart';
import 'features/catalog/presentation/blocs/like%20bloc/like_bloc.dart';
import 'features/checkout/data/data%20source/checkout_data_source.dart';
import 'features/checkout/data/repository/checkout_repository_impl.dart';
import 'features/checkout/domain/repository/checkout_repository.dart';
import 'features/checkout/domain/usecases/add_to_cart_usecase.dart';
import 'features/checkout/domain/usecases/fetch_cart_products_usecase.dart';
import 'features/checkout/presentation/bloc/checkout_bloc.dart';
import 'features/profile/data/data%20source/user_data_source.dart';
import 'features/profile/data/repository/profile_repository_impl.dart';
import 'features/profile/domain/repository/profile_repository.dart';
import 'features/profile/domain/usecase/fetch_user_data_usecase.dart';
import 'features/profile/domain/usecase/udpate_user_data_usecase.dart';
import 'features/profile/presentation/bloc/profile_bloc.dart';
import 'shared/validation/bloc/validation_bloc.dart';

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
  sl.registerFactory(() => LikeBloc(
      createLikeDocumentUsecase: sl(),
      fetchLikeDocUsecase: sl(),
      likeUnlikeProdUsecase: sl()));

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
      updateUserDataUsecase: sl(),
    ),
  );
  sl.registerFactory(
    () => CheckoutBloc(
      addToCartUsecase: sl(),
      fetchCartProductsUsecase: sl(),
    ),
  );

  //usecase

  sl.registerLazySingleton(() => AddToCartUsecase(repository: sl()));
  sl.registerLazySingleton(() => FetchCartProductsUsecase(repository: sl()));

  sl.registerLazySingleton(() => LoginWithEmailUsecase(repository: sl()));
  sl.registerLazySingleton(() => SignupWithEmailUsecase(repository: sl()));
  sl.registerLazySingleton(() => SigninWithGoogleUsecase(repository: sl()));
  sl.registerLazySingleton(() => CheckUserUsercase(repository: sl()));
  sl.registerLazySingleton(() => SignOutUsecase(repository: sl()));

  sl.registerLazySingleton(() => GetProductDataUsecase(repository: sl()));
  sl.registerLazySingleton(() => FetchUserDataUsecase(repository: sl()));
  sl.registerLazySingleton(() => SetUserDataUsecase(repository: sl()));
  sl.registerLazySingleton(() => UpdateUserDataUsecase(repository: sl()));

  sl.registerLazySingleton(() => CreateLikeDocumentUsecase(repository: sl()));
  sl.registerLazySingleton(() => FetchLikeDocUsecase(repository: sl()));
  sl.registerLazySingleton(() => LikeUnlikeProdUsecase(repository: sl()));

  //repo
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      dataSource: sl(),
    ),
  );
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      productDataSource: sl(),
      likesDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      dataSource: sl(),
    ),
  );
  sl.registerLazySingleton<CheckoutRepository>(
    () => CheckoutRepositoryImpl(
      dataSource: sl(),
    ),
  );

  // datasource
  //yesle chai euta matra intance banaidinxa thru out the app
  sl.registerLazySingleton<AuthDataSource>(
      () => AuthDataSourceImpl(fireAuth: sl()));

  sl.registerLazySingleton<ProductDataSource>(
      () => ProductDataSourceImpl(fireCollection: sl()));
  sl.registerLazySingleton<LikeCollectionDataSource>(
      () => LikeCollectionDataSourceImpl(fireCollections: sl()));

  sl.registerLazySingleton<UserDataSource>(
      () => UserDataSourceImpl(fireAuth: sl()));
  sl.registerLazySingleton<CheckoutDataSource>(() => CheckoutDataSourceImpl(
        fireAuth: sl(),
        fireCollections: sl(),
      ));

  //core
  sl.registerLazySingleton<TextValidator>(() => TextValidator());
  sl.registerLazySingleton<FireAuth>(() => FireAuth());
  sl.registerLazySingleton<FireCollections>(() => FireCollections());
}
