import 'package:ecom/core/firebaseFunctions/firebase_storage.dart';
import 'package:ecom/core/location-functions/map_location.dart';
import 'package:ecom/features/chat/data/data%20source/chat_data_source.dart';
import 'package:ecom/features/chat/domain/repository/chat_repository.dart';
import 'package:ecom/features/chat/domain/usecase/fetch_chat_room_data_usecase.dart';
import 'package:ecom/features/chat/domain/usecase/send_message_usecase.dart';
import 'package:ecom/features/chat/presentation/blocs/cubit/show_send_button_cubit.dart';
import 'package:ecom/features/checkout/presentation/blocs/cubit/credit_card_set_cubit.dart';
import 'package:ecom/features/checkout/presentation/blocs/orders%20bloc/orders_bloc.dart';
import 'package:ecom/features/favorites/data/datasource/favorites_datasource.dart';
import 'package:ecom/features/favorites/data/repository/favorites_repository_impl.dart';
import 'package:ecom/features/favorites/domain/repository/favorites_repository.dart';
import 'package:ecom/features/favorites/domain/usecase/fetch_fav_products_usecase.dart';
import 'package:ecom/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:ecom/features/map/data/data%20source/map_data_source.dart';
import 'package:ecom/features/map/domain/repositity/map_repository.dart';
import 'package:ecom/features/map/domain/usecase/get_current_user_position_usecase.dart';
import 'package:ecom/features/map/presentation/bloc/map_bloc.dart';
import 'package:ecom/features/navbar/presentation/cubit/nav_index_cubit.dart';
import 'package:ecom/features/payment/data/data%20source/payment_datasource.dart';
import 'package:ecom/features/payment/domain/repository/payment_repository.dart';
import 'package:ecom/features/payment/domain/usecase/add_card_details_usecase.dart';
import 'package:ecom/features/payment/domain/usecase/fetch_credit_card_details_usecase.dart';
import 'package:ecom/features/payment/presentation/bloc/payment_bloc.dart';
import 'package:ecom/features/profile/domain/usecase/upload_profile_picture_usecase.dart';
import 'package:ecom/shared/theme%20cubit/cubit/theme_cubit.dart';
import 'package:get_it/get_it.dart';

import 'core/firebaseFunctions/firebase_auth.dart';
import 'core/firebaseFunctions/firebase_collections.dart';
import 'core/utils/text_validator.dart';
import 'features/auth/data/dataSource/auth_data_source.dart';
import 'features/auth/data/repository/auth_repository_impl.dart';
import 'features/auth/domain/repository/auth_repository.dart';
import 'features/auth/domain/usecases/check_user_usecase.dart';
import 'features/auth/domain/usecases/login_with_email_usecase.dart';
import 'features/auth/domain/usecases/sign_out_usecase.dart';
import 'features/auth/domain/usecases/signup_with_email_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/catalog/data/data_source/like_collection_data_source.dart';
import 'features/catalog/data/data_source/product_data_source.dart';
import 'features/catalog/data/repository/product_repository_impl.dart';
import 'features/catalog/domain/repository/product_repository.dart';
import 'features/catalog/domain/usecase/fetch_like_doc_usecase.dart';
import 'features/catalog/domain/usecase/get_product_data_usecase.dart';
import 'features/catalog/domain/usecase/like_unlike_prod_usecase.dart';
import 'features/catalog/presentation/blocs/catalog bloc/catalog_bloc.dart';
import 'features/catalog/presentation/blocs/like%20bloc/like_bloc.dart';
import 'features/chat/data/repository/chat_repository_impl.dart';
import 'features/chat/domain/usecase/fetch_messages_usecase.dart';
import 'features/chat/presentation/blocs/chat bloc/chat_bloc.dart';
import 'features/checkout/data/data%20source/checkout_data_source.dart';
import 'features/checkout/data/repository/checkout_repository_impl.dart';
import 'features/checkout/domain/repository/checkout_repository.dart';
import 'features/checkout/domain/usecases/add_to_cart_usecase.dart';
import 'features/checkout/domain/usecases/fetch_cart_products_usecase.dart';
import 'features/checkout/domain/usecases/fetch_order_usecase.dart';
import 'features/checkout/domain/usecases/place_order_usecase.dart';
import 'features/checkout/domain/usecases/remove_cart_item_usecase.dart';
import 'features/checkout/presentation/blocs/checkoutbloc/checkout_bloc.dart';
import 'features/map/data/repository/map_repository_impl.dart';
import 'features/payment/data/repository/payment_repository_impl.dart';
import 'features/profile/data/data%20source/user_data_source.dart';
import 'features/profile/data/repository/profile_repository_impl.dart';
import 'features/profile/domain/repository/profile_repository.dart';
import 'features/profile/domain/usecase/fetch_user_data_usecase.dart';
import 'features/profile/domain/usecase/update_user_data_usecase.dart';
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
      signOutUsecase: sl(),
    ),
  );
  sl.registerFactory(
    () => LikeBloc(
      fetchLikeDocUsecase: sl(),
      likeUnlikeProdUsecase: sl(),
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
      updateUserDataUsecase: sl(),
      uploadProfilePictureUsecase: sl(),
    ),
  );
  sl.registerFactory(() => CheckoutBloc(
        addToCartUsecase: sl(),
        fetchCartProductsUsecase: sl(),
        removeCartItemUsecase: sl(),
      ));

  sl.registerFactory(
    () => OrdersBloc(
      fetchOrderUsecase: sl(),
      placeOrderUsecase: sl(),
    ),
  );
  sl.registerFactory(
    () => PaymentBloc(
      addCardDetailsUsecase: sl(),
      fetchCreditCardDetailsUsecase: sl(),
    ),
  );

  sl.registerFactory(
    () => FavoritesBloc(
      fetchFavProductsUsecase: sl(),
    ),
  );
  sl.registerFactory(
    () => MapBloc(
      getCurrentUserPositionUsecase: sl(),
    ),
  );

  sl.registerFactory(
    () => ChatBloc(
      sendMessageUsecase: sl(),
      fetchMessagesUsecase: sl(),
      fetchChatRoomDataUsecase: sl(),
    ),
  );

  // Cubit
  sl.registerFactory(() => ShowSendButtonCubit());
  sl.registerFactory(() => NavIndexCubit());
  sl.registerFactory(() => CreditCardSetCubit());
  sl.registerFactory(() => ThemeCubit());

  //usecase

  sl.registerLazySingleton(() => AddToCartUsecase(repository: sl()));
  sl.registerLazySingleton(() => FetchCartProductsUsecase(repository: sl()));

  sl.registerLazySingleton(() => LoginWithEmailUsecase(repository: sl()));
  sl.registerLazySingleton(() => SignupWithEmailUsecase(repository: sl()));

  sl.registerLazySingleton(() => CheckUserUsercase(repository: sl()));
  sl.registerLazySingleton(() => SignOutUsecase(repository: sl()));

  sl.registerLazySingleton(() => GetProductDataUsecase(repository: sl()));
  sl.registerLazySingleton(() => FetchUserDataUsecase(repository: sl()));
  sl.registerLazySingleton(() => UpdateUserDataUsecase(repository: sl()));

  sl.registerLazySingleton(() => FetchLikeDocUsecase(repository: sl()));
  sl.registerLazySingleton(() => LikeUnlikeProdUsecase(repository: sl()));

  sl.registerLazySingleton(() => RemoveCartItemUsecase(repository: sl()));
  sl.registerLazySingleton(() => PlaceOrderUsecase(repository: sl()));
  sl.registerLazySingleton(() => FetchOrderUsecase(repository: sl()));

  sl.registerLazySingleton(() => AddCardDetailsUsecase(repository: sl()));
  sl.registerLazySingleton(
      () => FetchCreditCardDetailsUsecase(repository: sl()));
  sl.registerLazySingleton(() => FetchFavProductsUsecase(repository: sl()));
  sl.registerLazySingleton(
      () => GetCurrentUserPositionUsecase(repository: sl()));
  sl.registerLazySingleton(() => UploadProfilePictureUsecase(repository: sl()));

  //chat
  sl.registerLazySingleton(() => SendMessageUsecase(repository: sl()));
  sl.registerLazySingleton(() => FetchMessagesUsecase(repository: sl()));
  sl.registerLazySingleton(() => FetchChatRoomDataUsecase(repository: sl()));

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
  sl.registerLazySingleton<PaymentRepository>(
    () => PaymentRepositoryImpl(
      dataSource: sl(),
    ),
  );
  sl.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepositoryImpl(
      dataSource: sl(),
    ),
  );
  sl.registerLazySingleton<MapRepository>(
    () => MapRepositoryImpl(
      dataSource: sl(),
    ),
  );
  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(
      dataSource: sl(),
    ),
  );

  // datasource
  //yesle chai euta matra intance banaidinxa thru out the app
  sl.registerLazySingleton<AuthDataSource>(
    () => AuthDataSourceImpl(
      fireAuth: sl(),
      fireCollections: sl(),
    ),
  );

  sl.registerLazySingleton<ProductDataSource>(
      () => ProductDataSourceImpl(fireCollection: sl()));
  sl.registerLazySingleton<LikeCollectionDataSource>(
      () => LikeCollectionDataSourceImpl(fireCollections: sl()));

  sl.registerLazySingleton<UserDataSource>(
    () => UserDataSourceImpl(
      fireAuth: sl(),
      fireStorage: sl(),
      fireCollections: sl(),
    ),
  );
  sl.registerLazySingleton<CheckoutDataSource>(
    () => CheckoutDataSourceImpl(
      fireAuth: sl(),
      fireCollections: sl(),
    ),
  );
  sl.registerLazySingleton<PaymentDatasource>(
    () => PaymentDatasourceImpl(
      fireCollections: sl(),
    ),
  );
  sl.registerLazySingleton<FavoritesDataSource>(
    () => FavoritesDataSourceImpl(
      fireCollections: sl(),
    ),
  );

  sl.registerLazySingleton<MapDataSource>(
    () => MapDataSourceImpl(
      mapLocation: sl(),
    ),
  );
  sl.registerLazySingleton<ChatDataSource>(
    () => ChatDataSourceImpl(
      fireCollections: sl(),
      fireAuth: sl(),
    ),
  );

  //core
  sl.registerLazySingleton<TextValidator>(() => TextValidator());
  sl.registerLazySingleton<FireAuth>(() => FireAuth());
  sl.registerLazySingleton<FireCollections>(() => FireCollections());
  sl.registerLazySingleton<MapLocation>(() => MapLocation());
  sl.registerLazySingleton<FireStorage>(() => FireStorage());
}


