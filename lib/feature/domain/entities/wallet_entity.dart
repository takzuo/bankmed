import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class WalletEntity extends Equatable {
  final String? walletId;
  final String? walletName; //TODO crear list<String>
  final Timestamp? time;
  final String? uid;
  final int? amount;
  final int? count;
  final List<dynamic>? history;

  WalletEntity(
      {this.walletId,
      this.walletName,
      this.time,
      this.uid,
      this.amount,
      this.count,
      this.history});

  @override
  // TODO: implement props
  List<Object?> get props =>
      [walletName, walletId, time, uid, amount, count, history];
}
