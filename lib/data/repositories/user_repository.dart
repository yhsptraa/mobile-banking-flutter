import 'package:drift/drift.dart'; // Tambahkan import ini untuk InsertMode
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../local/app_database.dart';
import '../local/database_provider.dart';

class UserRepository {
  UserRepository(this.database);

  final AppDatabase database;

  Future<UserModel?> findByUsername(String username) {
    final query = database.select(database.users)..where((table) => table.username.equals(username));
    return query.getSingleOrNull();
  }

  Future<UserModel?> getUserById(int id) {
    final query = database.select(database.users)..where((table) => table.id.equals(id));
    return query.getSingleOrNull();
  }

  Future<void> upsertUser(UserModel user) async {
    await database.into(database.users).insert(user, mode: InsertMode.insertOrReplace);
  }
}

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(ref.watch(databaseProvider));
});