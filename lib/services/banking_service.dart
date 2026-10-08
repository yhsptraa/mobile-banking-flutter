import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/local/app_database.dart';
import '../data/local/database_provider.dart';
import '../data/models/transaction.dart';

class BankingService {
  BankingService(this.database);
  final AppDatabase database;

  Future<void> transfer({
    required int accountId,
    required String accountNumber,
    required int amount,
  }) async {
    if (amount < 10000) throw StateError('Nominal transfer minimal Rp 10.000');
    await database.transaction(() async {
      final recipient =
          await (database.select(database.accounts)
                ..where((table) => table.accountNumber.equals(accountNumber)))
              .getSingleOrNull();
      if (recipient == null)
        throw StateError('Rekening tujuan tidak ditemukan');
      if (recipient.id == accountId)
        throw StateError('Tidak bisa transfer ke rekening sendiri');
      final sender = await (database.select(
        database.accounts,
      )..where((table) => table.id.equals(accountId))).getSingleOrNull();
      if (sender == null) throw StateError('Rekening tidak ditemukan');
      await _debit(accountId, amount);
      await _credit(recipient.id, amount);
      await _record(
        accountId,
        TransactionType.transferOut,
        'Transfer ke ${recipient.accountNumber}',
        amount,
      );
      await _record(
        recipient.id,
        TransactionType.transferIn,
        'Transfer dari ${sender.accountNumber}',
        amount,
      );
    });
  }

  Future<void> spend({
    required int accountId,
    required int amount,
    required String title,
    TransactionType type = TransactionType.payment,
    String? qrData,
  }) async {
    if (type != TransactionType.payment && type != TransactionType.withdrawal) {
      throw ArgumentError('Jenis transaksi pengeluaran tidak valid');
    }
    await database.transaction(() async {
      await _debit(accountId, amount);
      await _record(accountId, type, title, amount, qrData: qrData);
    });
  }

  Future<void> topUp({required int accountId, required int amount}) async {
    _validateAmount(amount);
    await database.transaction(() async {
      await _credit(accountId, amount);
      await _record(
        accountId,
        TransactionType.transferIn,
        'Top Up demo',
        amount,
      );
    });
  }

  void _validateAmount(int amount) {
    if (amount <= 0 || amount > 1000000000)
      throw StateError('Nominal harus antara Rp 1 dan Rp 1.000.000.000');
  }

  Future<void> _debit(int accountId, int amount) async {
    _validateAmount(amount);
    final count =
        await (database.update(database.accounts)..where(
              (table) =>
                  table.id.equals(accountId) &
                  table.balance.isBiggerOrEqualValue(amount),
            ))
            .write(
              AccountsCompanion.custom(
                balance: database.accounts.balance - Variable(amount),
              ),
            );
    if (count != 1)
      throw StateError('Saldo tidak mencukupi atau rekening tidak ditemukan');
  }

  Future<void> _credit(int accountId, int amount) async {
    final count =
        await (database.update(
          database.accounts,
        )..where((table) => table.id.equals(accountId))).write(
          AccountsCompanion.custom(
            balance: database.accounts.balance + Variable(amount),
          ),
        );
    if (count != 1) throw StateError('Rekening tidak ditemukan');
  }

  Future<void> _record(
    int accountId,
    TransactionType type,
    String title,
    int amount, {
    String? qrData,
  }) {
    return database
        .into(database.transactions)
        .insert(
          TransactionsCompanion.insert(
            accountId: accountId,
            type: type,
            title: title,
            amount: amount,
            qrData: Value(qrData),
          ),
        );
  }
}

final bankingServiceProvider = Provider(
  (ref) => BankingService(ref.watch(databaseProvider)),
);
