import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:bankmed/feature/data/datasources/firebase_remote_data_source_impl.dart';
import 'package:bankmed/feature/data/repositories/firebase_repository_impl.dart';
import 'package:bankmed/feature/domain/repositories/firebase_repository.dart';
import 'package:bankmed/feature/domain/usecases/add_new_wallet_usecase.dart';
import 'package:bankmed/feature/domain/usecases/delete_wallet_usecase.dart';
import 'package:bankmed/feature/domain/usecases/get_create_current_user_usecase.dart';
import 'package:bankmed/feature/domain/usecases/get_current_uid_usecase.dart';
import 'package:bankmed/feature/domain/usecases/get_wallet_usecase.dart';
import 'package:bankmed/feature/domain/usecases/is_sign_in_usecase.dart';
import 'package:bankmed/feature/domain/usecases/sign_in_usecase.dart';
import 'package:bankmed/feature/domain/usecases/sign_out_usecase.dart';
import 'package:bankmed/feature/domain/usecases/sign_up_usecase.dart';
import 'package:bankmed/feature/domain/usecases/update_wallet_usecase.dart';
import 'package:bankmed/feature/presentation/cubit/auth/auth_cubit.dart';
import 'package:bankmed/feature/presentation/cubit/wallet/wallet_cubit.dart';
import 'package:bankmed/feature/presentation/cubit/user/user_cubit.dart';

import 'feature/data/datasources/firebase_remote_data_source.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  //Cubit/Bloc
  sl.registerFactory<AuthCubit>(() => AuthCubit(
      isSignInUseCase: sl.call(),
      signOutUseCase: sl.call(),
      getCurrentUidUseCase: sl.call()));
  sl.registerFactory<UserCubit>(() => UserCubit(
        getCreateCurrentUserUseCase: sl.call(),
        signInUseCase: sl.call(),
        signUPUseCase: sl.call(),
      ));
  sl.registerFactory<WalletCubit>(() => WalletCubit(
        updateWalletUseCase: sl.call(),
        getWalletUseCase: sl.call(),
        deleteWalletUseCase: sl.call(),
        addNewWalletUseCase: sl.call(),
      ));

  //useCase
  sl.registerLazySingleton<AddNewWalletUseCase>(
      () => AddNewWalletUseCase(repository: sl.call()));
  sl.registerLazySingleton<DeleteWalletUseCase>(
      () => DeleteWalletUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCreateCurrentUserUsecase>(
      () => GetCreateCurrentUserUsecase(repository: sl.call()));
  sl.registerLazySingleton<GetCurrentUidUseCase>(
      () => GetCurrentUidUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetWalletUseCase>(
      () => GetWalletUseCase(repository: sl.call()));
  sl.registerLazySingleton<IsSignInUseCase>(
      () => IsSignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignUPUseCase>(
      () => SignUPUseCase(repository: sl.call()));
  sl.registerLazySingleton<UpdateWalletUseCase>(
      () => UpdateWalletUseCase(repository: sl.call()));

  //repository
  sl.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(remoteDataSource: sl.call()));

  //data source
  sl.registerLazySingleton<FirebaseRemoteDataSource>(() =>
      FirebaseRemoteDataSourceImpl(auth: sl.call(), firestore: sl.call()));

  //External
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;

  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => fireStore);
}
