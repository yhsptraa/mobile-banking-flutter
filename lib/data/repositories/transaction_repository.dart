import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../local/app_database.dart';
import '../local/database_provider.dart';

class TransactionRepository {
  TransactionRepository(this.database);

  final AppDatabase database;

  Stream<List<TransactionModel>> watchByAccountId(int accountId) {
    final query = database.select(database.transactions)..where((table) => table.accountId.equals(accountId))..orderBy([
      (table) => OrderingTerm.desc(table.createdAt),
    ]);

    return query.watch();
  }

  Future<int> create(TransactionsCompanion transaction) {
    return database.into(database.transactions).insert(transaction);
  }
}

final transactionRepositoryProvider =
    Provider<TransactionRepository>((ref) {
  return TransactionRepository(ref.watch(databaseProvider));
});