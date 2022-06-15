import 'package:bankmed/feature/domain/entities/wallet_entity.dart';
import 'package:bankmed/feature/domain/repositories/firebase_repository.dart';

class UpdateWalletUseCase {
  final FirebaseRepository repository;

  UpdateWalletUseCase({required this.repository});

  Future<void> call(WalletEntity wallet) async {
    return repository.updateWallet(wallet);
  }
}
