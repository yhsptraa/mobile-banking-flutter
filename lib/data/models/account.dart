import 'package:drift/drift.dart';
import './user.dart';

@DataClassName('AccountModel')
class Accounts extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get userId => integer().references(Users, #id, onDelete: KeyAction.cascade)();

  TextColumn get accountNumber => text().withLength(min: 10, max: 10).unique()();

  IntColumn get balance => integer().withDefault(const Constant(0))();

  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
}
