import 'package:flutter_riverpod/flutter_riverpod.dart';

class SessionState {
  const SessionState({
    this.userId,
    this.accountId,
  });

  final int? userId;
  final int? accountId;

  bool get isLoggedIn => userId != null && accountId != null;
}

class SessionController extends Notifier<SessionState> {
  @override
  SessionState build() {
    return const SessionState();
  }

  void startSession({
    required int userId,
    required int accountId,
  }) {
    state = SessionState(
      userId: userId,
      accountId: accountId,
    );
  }

  void logout() {
    state = const SessionState();
  }
}

final sessionControllerProvider =
    NotifierProvider<SessionController, SessionState>(
  SessionController.new,
);