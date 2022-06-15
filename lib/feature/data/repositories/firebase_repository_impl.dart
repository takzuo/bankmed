import 'package:bankmed/feature/data/datasources/firebase_remote_data_source.dart';
import 'package:bankmed/feature/domain/entities/wallet_entity.dart';
import 'package:bankmed/feature/domain/entities/user_entity.dart';
import 'package:bankmed/feature/domain/repositories/firebase_repository.dart';

class FirebaseRepositoryImpl extends FirebaseRepository {
  final FirebaseRemoteDataSource remoteDataSource;

  FirebaseRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> addNewWallet(WalletEntity wallet) async =>
      remoteDataSource.addNewWallet(wallet);

  @override
  Future<void> deleteWallet(WalletEntity wallet) async =>
      remoteDataSource.deleteWallet(wallet);

  @override
  Future<void> getCreateCurrentUser(UserEntity user) async =>
      remoteDataSource.getCreateCurrentUser(user);

  @override
  Future<String> getCurrentUId() async => remoteDataSource.getCurrentUId();

  @override
  Stream<List<WalletEntity>> getWallet(String uid) =>
      remoteDataSource.getWallet(uid);

  @override
  Future<bool> isSignIn() async => remoteDataSource.isSignIn();

  @override
  Future<void> signIn(UserEntity user) async => remoteDataSource.signIn(user);

  @override
  Future<void> signOut() async => remoteDataSource.signOut();

  @override
  Future<void> signUp(UserEntity user) async => remoteDataSource.signUp(user);

  @override
  Future<void> updateWallet(WalletEntity wallet) async =>
      remoteDataSource.updateWallet(wallet);
}
