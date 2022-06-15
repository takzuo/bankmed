part of 'wallet_cubit.dart';

abstract class WalletState extends Equatable {
  const WalletState();
}

class WalletInitial extends WalletState {
  @override
  List<Object> get props => [];
}

class WalletLoading extends WalletState {
  @override
  List<Object> get props => [];
}

class WalletFailure extends WalletState {
  @override
  List<Object> get props => [];
}

class WalletLoaded extends WalletState {
  final List<WalletEntity> wallets;

  WalletLoaded({required this.wallets});

  @override
  List<Object> get props => [wallets];
}
