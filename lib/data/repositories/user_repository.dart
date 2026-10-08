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
}

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(ref.watch(databaseProvider));
});