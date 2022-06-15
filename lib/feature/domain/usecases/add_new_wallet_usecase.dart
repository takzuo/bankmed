import 'package:bankmed/feature/domain/entities/wallet_entity.dart';
import 'package:bankmed/feature/domain/repositories/firebase_repository.dart';

class AddNewWalletUseCase {
  final FirebaseRepository repository;

  AddNewWalletUseCase({required this.repository});

  Future<void> call(WalletEntity wallet) async {
    return repository.addNewWallet(wallet);
  }
}
