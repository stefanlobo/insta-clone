import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_clone/state/auth/backend/authenticator.dart';
import 'package:insta_clone/state/auth/models/auth_result.dart';
import 'package:insta_clone/state/auth/models/auth_state.dart';
import 'package:insta_clone/state/posts/typedefs/user_id.dart';
import 'package:insta_clone/state/user_info/backend/user_info_storage.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Autenticator();
  final _userInfoStorage = const UserInfoStorage();

  AuthStateNotifier() : super(const AuthState.unknown()) {
    if (_authenticator.isAlreadyLoggIn) {
      state = AuthState(result: AuthResult.success, isLoading: false, userId: _authenticator.userId);
    }
  }

  Future<void> logOut() async {
    state = state.copiedWithIsLoading(true);
    await _authenticator.logOut();
    state = const AuthState.unknown();
  }

  Future<void> loginWithFacebook() async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.loginWithFacebook();
    final userId = _authenticator.userId;

    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(userId: userId);
    }
    state = AuthState(result: result, isLoading: false, userId: userId);
  }

  Future<void> loginWithGoogle() async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.loginWithGoogle();
    final userId = _authenticator.userId;

    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(userId: userId);
    }
    state = AuthState(result: result, isLoading: false, userId: userId);
  }

  Future<void> saveUserInfo({required UserId userId}) => _userInfoStorage.saveUserInfo(
    userId: userId,
    displayName: _authenticator.displayName,
    email: _authenticator.email,
  );
}
