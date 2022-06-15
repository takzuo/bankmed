import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bankmed/feature/domain/entities/wallet_entity.dart';

class WalletModel extends WalletEntity {
  WalletModel({
    final String? walletId,
    final String? walletName,
    final Timestamp? time,
    final String? uid,
    final int? amount,
    final int? count,
    final List<dynamic>? history,
  }) : super(
          history: history,
          count: count,
          amount: amount,
          uid: uid,
          time: time,
          walletName: walletName,
          walletId: walletId,
        );

  factory WalletModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return WalletModel(
      walletId: documentSnapshot.get('walletId'),
      walletName: documentSnapshot.get('walletName'),
      uid: documentSnapshot.get('uid'),
      time: documentSnapshot.get('time'),
      amount: documentSnapshot.get('amount'),
      count: documentSnapshot.get('count'),
      history: documentSnapshot.get('history'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      "history": history,
      "count": count,
      "amount": amount,
      "uid": uid,
      "time": time,
      "walletName": walletName,
      "walletId": walletId
    };
  }
}
