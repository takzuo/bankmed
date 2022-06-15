import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bankmed/feature/domain/entities/wallet_entity.dart';
import 'package:bankmed/feature/domain/usecases/add_new_wallet_usecase.dart';
import 'package:bankmed/feature/domain/usecases/delete_wallet_usecase.dart';
import 'package:bankmed/feature/domain/usecases/get_wallet_usecase.dart';
import 'package:bankmed/feature/domain/usecases/update_wallet_usecase.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  final UpdateWalletUseCase updateWalletUseCase;
  final DeleteWalletUseCase deleteWalletUseCase;
  final GetWalletUseCase getWalletUseCase;
  final AddNewWalletUseCase addNewWalletUseCase;

  WalletCubit(
      {required this.getWalletUseCase,
      required this.deleteWalletUseCase,
      required this.updateWalletUseCase,
      required this.addNewWalletUseCase})
      : super(WalletInitial());

  Future<void> addWallet({required WalletEntity wallet}) async {
    try {
      await addNewWalletUseCase.call(wallet);
    } on SocketException catch (_) {
      emit(WalletFailure());
    } catch (_) {
      emit(WalletFailure());
    }
  }

  Future<void> deleteWallet({required WalletEntity wallet}) async {
    try {
      await deleteWalletUseCase.call(wallet);
    } on SocketException catch (_) {
      emit(WalletFailure());
    } catch (_) {
      emit(WalletFailure());
    }
  }

  Future<void> updateWallet({required WalletEntity wallet}) async {
    try {
      await updateWalletUseCase.call(wallet);
    } on SocketException catch (_) {
      emit(WalletFailure());
    } catch (_) {
      emit(WalletFailure());
    }
  }

  Future<void> getWallet({required String uid}) async {
    emit(WalletLoading());
    try {
      getWalletUseCase.call(uid).listen((wallets) {
        emit(WalletLoaded(wallets: wallets));
      });
    } on SocketException catch (_) {
      emit(WalletFailure());
    } catch (_) {
      emit(WalletFailure());
    }
  }
}
