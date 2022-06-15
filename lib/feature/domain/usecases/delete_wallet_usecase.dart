import 'package:bankmed/feature/domain/entities/wallet_entity.dart';
import 'package:bankmed/feature/domain/repositories/firebase_repository.dart';

class DeleteWalletUseCase {
  final FirebaseRepository repository;

  DeleteWalletUseCase({required this.repository});

  Future<void> call(WalletEntity wallet) async {
    return repository.deleteWallet(wallet);
  }
}
