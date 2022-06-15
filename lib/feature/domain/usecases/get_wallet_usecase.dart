import 'package:bankmed/feature/domain/entities/wallet_entity.dart';
import 'package:bankmed/feature/domain/repositories/firebase_repository.dart';

class GetWalletUseCase {
  final FirebaseRepository repository;

  GetWalletUseCase({required this.repository});

  Stream<List<WalletEntity>> call(String uid) {
    return repository.getWallet(uid);
  }
}
