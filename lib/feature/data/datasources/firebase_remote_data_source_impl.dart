import 'package:bankmed/feature/data/datasources/firebase_remote_data_source.dart';
import 'package:bankmed/feature/data/models/wallet_model.dart';
import 'package:bankmed/feature/data/models/user_model.dart';
import 'package:bankmed/feature/domain/entities/wallet_entity.dart';
import 'package:bankmed/feature/domain/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  FirebaseRemoteDataSourceImpl({required this.auth, required this.firestore});

  @override
  Future<void> addNewWallet(WalletEntity walletEntity) async {
    final walletCollectionRef = firestore
        .collection("users")
        .doc(walletEntity.uid)
        .collection("wallets");

    final walletId = walletCollectionRef.doc().id;

    walletCollectionRef.doc(walletId).get().then((wallet) {
      final newWallet = WalletModel(
              uid: walletEntity.uid,
              walletId: walletId,
              walletName: walletEntity.walletName,
              time: walletEntity.time,
              amount: 0,
              count: 0)
          .toDocument();

      if (!wallet.exists) {
        walletCollectionRef.doc(walletId).set(newWallet);
      }
      return;
    });
  }

  @override
  Future<void> deleteWallet(WalletEntity walletEntity) async {
    final walletCollectionRef = firestore
        .collection("users")
        .doc(walletEntity.uid)
        .collection("wallets");

    walletCollectionRef.doc(walletEntity.walletId).get().then((wallet) {
      if (wallet.exists) {
        walletCollectionRef.doc(walletEntity.walletId).delete();
      }
      return;
    });
  }

  @override
  Future<void> getCreateCurrentUser(UserEntity user) async {
    final userCollectionRef = firestore.collection("users");
    final uid = await getCurrentUId();
    userCollectionRef.doc(uid).get().then((value) {
      final newUser = UserModel(
        uid: uid,
        status: user.status,
        email: user.email,
        name: user.name,
      ).toDocument();
      if (!value.exists) {
        userCollectionRef.doc(uid).set(newUser);
      }
      return;
    });
  }

  @override
  Future<String> getCurrentUId() async => auth.currentUser!.uid;

  @override
  Stream<List<WalletEntity>> getWallet(String uid) {
    final walletCollectionRef =
        firestore.collection("users").doc(uid).collection("wallets");

    return walletCollectionRef.snapshots().map((querySnap) {
      return querySnap.docs
          .map((docSnap) => WalletModel.fromSnapshot(docSnap))
          .toList();
    });
  }

  @override
  Future<bool> isSignIn() async => auth.currentUser?.uid != null;

  @override
  Future<void> signIn(UserEntity user) async => auth.signInWithEmailAndPassword(
      email: user.email!, password: user.password!);

  @override
  Future<void> signOut() async => auth.signOut();

  @override
  Future<void> signUp(UserEntity user) async =>
      auth.createUserWithEmailAndPassword(
          email: user.email!, password: user.password!);

  @override
  Future<void> updateWallet(WalletEntity wallet) async {
    Map<String, dynamic> walletMap = Map();
    final walletCollectionRef =
        firestore.collection("users").doc(wallet.uid).collection("wallets");

    if (wallet.walletName != null) walletMap['walletName'] = wallet.walletName;
    if (wallet.time != null) walletMap['time'] = wallet.time;
    if (wallet.amount != null) walletMap['amount'] = wallet.amount;
    if (wallet.count != null) walletMap['count'] = wallet.count;
    if (wallet.history != null) walletMap['history'] = wallet.history;

    walletCollectionRef.doc(wallet.walletId).update(walletMap);
    //walletCollectionRef.doc(wallet.walletId).set(walletMap);
  }
}
