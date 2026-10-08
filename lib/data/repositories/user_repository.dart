import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../local/app_database.dart';
import '../local/database_provider.dart';

class UserRepository {
  UserRepository(this.database);

  final AppDatabase database;

  Future<UserModel?> findByUsername(String username) {
    final query = database.select(database.users)
      ..where((table) => table.username.equals(username));
    return query.getSingleOrNull();
  }

  Future<UserModel?> getUserById(int id) {
    final query = database.select(database.users)
      ..where((table) => table.id.equals(id));
    return query.getSingleOrNull();
  }

  Future<bool> changePassword({
    required int userId,
    required String oldPassword,
    required String newPassword,
  }) async {
    final query = database.update(database.users)
      ..where(
        (table) =>
            table.id.equals(userId) & table.passwordHash.equals(oldPassword),
      );
    return await query.write(
          UsersCompanion(passwordHash: Value(newPassword)),
        ) ==
        1;
  }

  Future<void> updateProfile({
    required int userId,
    required String username,
    required String phoneNumber,
    required String? profileImagePath,
  }) async {
    final query = database.update(database.users)
      ..where((table) => table.id.equals(userId));
    final count = await query.write(
      UsersCompanion(
        username: Value(username),
        phoneNumber: Value(phoneNumber),
        profileImagePath: Value(profileImagePath),
      ),
    );
    if (count != 1) throw StateError('User tidak ditemukan');
  }
}

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(ref.watch(databaseProvider));
});
