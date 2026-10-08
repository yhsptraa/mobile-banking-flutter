import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../local/app_database.dart';
import '../local/database_provider.dart';

class AccountRepository {
  AccountRepository(this.database);

  final AppDatabase database;

  Future<AccountModel?> findByUserId(int userId) {
    final query = database.select(database.accounts)..where((table) => table.userId.equals(userId));

    return query.getSingleOrNull();
  }

  Future<AccountModel?> findByAccountNumber(String accountNumber) {
    final query = database.select(database.accounts)..where((table) => table.accountNumber.equals(accountNumber));

    return query.getSingleOrNull();
  }

  Stream<AccountModel?> watchById(int accountId) {
    final query = database.select(database.accounts)..where((table) => table.id.equals(accountId));

    return query.watchSingleOrNull();
  }

  Future<void> updateBalance(int accountId, int newBalance) {
    final query = database.update(database.accounts)..where((table) => table.id.equals(accountId));

    return query.write(
      AccountsCompanion(
        balance: Value(newBalance),
      ),
    );
  }
}

final accountRepositoryProvider = Provider<AccountRepository>((ref) {
  return AccountRepository(ref.watch(databaseProvider));
});