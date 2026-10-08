import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../local/app_database.dart';
import '../local/database_provider.dart';
import '../../state/session_controller.dart';
import '../models/transaction.dart';
import 'account_repository.dart';
import 'user_repository.dart';

class TransactionRepository {
  TransactionRepository(this.database);

  final AppDatabase database;

  Stream<List<TransactionModel>> watchByAccountId(int accountId) {
    final query = database.select(database.transactions)
      ..where((table) => table.accountId.equals(accountId))
      ..orderBy([(table) => OrderingTerm.desc(table.createdAt)]);

    return query.watch();
  }

  Future<int> create(TransactionsCompanion transaction) {
    return database.into(database.transactions).insert(transaction);
  }
}

final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  return TransactionRepository(ref.watch(databaseProvider));
});

final currentTransactionsProvider = StreamProvider<List<TransactionModel>>((
  ref,
) {
  final accountId = ref.watch(sessionControllerProvider).accountId;
  if (accountId == null) return Stream.value([]);
  return ref.watch(transactionRepositoryProvider).watchByAccountId(accountId);
});

final previousRecipientsProvider = FutureProvider<List<Map<String, String>>>((
  ref,
) async {
  final accounts = ref.watch(accountRepositoryProvider);
  final users = ref.watch(userRepositoryProvider);
  final rows = await ref.watch(currentTransactionsProvider.future);
  final numbers = rows
      .where((row) => row.type == TransactionType.transferOut)
      .map((row) => row.title.replaceFirst('Transfer ke ', ''))
      .toSet();
  final result = <Map<String, String>>[];
  for (final number in numbers) {
    final account = await accounts.findByAccountNumber(number);
    if (account == null) continue;
    final user = await users.getUserById(account.userId);
    if (user != null)
      result.add({'name': user.fullName, 'accountNumber': number});
  }
  return result;
});
