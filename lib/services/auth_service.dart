import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/local/app_database.dart';
import '../data/repositories/account_repository.dart';
import '../data/repositories/user_repository.dart';

class LoginResult {
  const LoginResult({required this.user, required this.account});

  final UserModel user;
  final AccountModel account;
}

class AuthService {
  AuthService({required this.userRepository, required this.accountRepository});

  final UserRepository userRepository;
  final AccountRepository accountRepository;

  Future<LoginResult?> login({
    required String username,
    required String password,
  }) async {
    final user = await userRepository.findByUsername(username.trim());

    if (user == null) return null;

    final passwordValid = verifyPassword(password, user.passwordHash);

    if (!passwordValid) return null;

    final account = await accountRepository.findByUserId(user.id);

    if (account == null) return null;

    return LoginResult(user: user, account: account);
  }

  bool verifyPassword(String password, String passwordHash) {
    return password == passwordHash;
  }
}

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(
    userRepository: ref.watch(userRepositoryProvider),
    accountRepository: ref.watch(accountRepositoryProvider),
  );
});
