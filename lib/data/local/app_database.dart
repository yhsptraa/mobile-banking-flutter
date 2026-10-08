import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../models/account.dart';
import '../models/transaction.dart';
import '../models/user.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Users, Accounts, Transactions])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'dummy_bank'));

  AppDatabase.withExecutor(super.executor);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async {
      await migrator.createAll();
    },
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        // Some version 1 installations already contain these columns.
        final columns = await customSelect('PRAGMA table_info(users)').get();
        final names = columns.map((row) => row.read<String>('name')).toSet();
        if (!names.contains('phone_number')) {
          await migrator.addColumn(users, users.phoneNumber);
        }
        if (!names.contains('profile_image_path')) {
          await migrator.addColumn(users, users.profileImagePath);
        }
      }
    },
    beforeOpen: (_) async {
      await transaction(() async {
        await _seedUser(
          username: 'admin',
          fullName: 'Jhon Doe',
          password: 'admin123',
          accountNumber: '9018814116',
          balance: 6000000,
        );
        await _seedUser(
          username: 'jonathan',
          fullName: 'Jonathan Christoper',
          password: 'jonathan123',
          accountNumber: '9018814117',
          balance: 1230000,
        );
        await _seedUser(
          username: 'joshua',
          fullName: 'Joshua Christoper',
          password: 'joshua123',
          accountNumber: '9018814118',
          balance: 1400000,
        );
      });
    },
  );

  Future<void> _seedUser({
    required String username,
    required String fullName,
    required String password,
    required String accountNumber,
    required int balance,
  }) async {
    final existingUser = await (select(users)..where((table) => table.username.equals(username))).getSingleOrNull();

    final userId =
        existingUser?.id ??
        await into(users).insert(
          UsersCompanion.insert(
            username: username,
            fullName: fullName,
            passwordHash: password,
          ),
        );

    final existingAccount = await (select(accounts)..where((table) => table.userId.equals(userId))).getSingleOrNull();

    if (existingAccount == null) {
      await into(accounts).insert(
        AccountsCompanion.insert(
          userId: userId,
          accountNumber: accountNumber,
          balance: Value(balance),
        ),
      );
    }
  }
}
