import 'package:drift/drift.dart';

@DataClassName('UserModel')
class Users extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get username => text().withLength(min: 3, max: 50).unique()();

  TextColumn get fullName => text()();

  TextColumn get passwordHash => text()();

  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
}
