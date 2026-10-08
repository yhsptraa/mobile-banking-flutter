import 'package:drift/drift.dart';
import './account.dart';

enum TransactionType {
  transferIn,
  transferOut,
  payment,
  withdrawal
}

@DataClassName('TransactionModel')
class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get accountId => integer().references(Accounts, #id, onDelete: KeyAction.cascade)();

  TextColumn get type => textEnum<TransactionType>()();

  TextColumn get title => text()();

  IntColumn get amount => integer()();

  TextColumn get qrData => text().nullable()();

  DateTimeColumn get createdAt => dateTime().clientDefault(DateTime.now)();
}