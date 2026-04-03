import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partsrunner/core/ApiService/ApiClient.dart';
import 'package:partsrunner/core/constant/auth_method.dart';
import 'package:partsrunner/core/constant/user_role.dart';
import 'package:partsrunner/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:partsrunner/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:partsrunner/features/auth/domain/entities/user_entity.dart';
import 'package:partsrunner/features/auth/domain/repositories/auth_repository.dart';
import 'package:partsrunner/features/auth/domain/usecases/login_usecase.dart';
import 'package:partsrunner/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:partsrunner/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:partsrunner/features/auth/domain/usecases/signup_usecase.dart';
import 'package:partsrunner/features/auth/domain/usecases/verify_otp_usecase.dart';

// ---------------------------------------------------------------------------
// UI-only state providers (unchanged)
// ---------------------------------------------------------------------------

final authMethodProvider = StateProvider<AuthMethod?>(
  (ref) => AuthMethod.email,
);

final rememberMeProvider = StateProvider<bool>((ref) => false);

final selectedRoleProvider = StateProvider<UserRole?>((ref) => null);

// ---------------------------------------------------------------------------
// Dependency providers
// ---------------------------------------------------------------------------
final _apiClientProvider = Provider<ApiClient>((ref) => ApiClient());

final _authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>(
  (ref) => AuthRemoteDataSourceImpl(apiClient: ref.watch(_apiClientProvider)),
);

final _authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(ref.watch(_authRemoteDataSourceProvider)),
);

final _loginUseCaseProvider = Provider<LoginUseCase>(
  (ref) => LoginUseCase(ref.watch(_authRepositoryProvider)),
);

final _signupUseCaseProvider = Provider<SignupUseCase>(
  (ref) => SignupUseCase(ref.watch(_authRepositoryProvider)),
);

final _sendOtpUseCaseProvider = Provider<SendOtpUseCase>(
  (ref) => SendOtpUseCase(ref.watch(_authRepositoryProvider)),
);

final _resetPasswordUseCaseProvider = Provider<ResetPasswordUseCase>(
  (ref) => ResetPasswordUseCase(ref.watch(_authRepositoryProvider)),
);

final _verifyOtpUseCaseProvider = Provider<VerifyOtpUseCase>(
  (ref) => VerifyOtpUseCase(ref.watch(_authRepositoryProvider)),
);

// ---------------------------------------------------------------------------
// Auth state
// ---------------------------------------------------------------------------

sealed class AuthState {
  const AuthState();
}

/// No operation has been triggered yet.
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Auth operation succeeded.
/// [user] is populated after login/signup; null for OTP/password-reset operations.
class AuthSuccess extends AuthState {
  const AuthSuccess({required this.message, this.user});
  final String message;
  final UserEntity? user;
}

/// An auth operation failed.
class AuthError extends AuthState {
  const AuthError({required this.message});
  final String message;
}

// ---------------------------------------------------------------------------
// Auth notifier
// ---------------------------------------------------------------------------

class AuthNotifier extends AsyncNotifier<AuthState> {
  late LoginUseCase _login;
  late SignupUseCase _signup;
  late SendOtpUseCase _sendOtp;
  late ResetPasswordUseCase _resetPassword;
  late VerifyOtpUseCase _verifyOtp;

  @override
  Future<AuthState> build() async {
    _login = ref.watch(_loginUseCaseProvider);
    _signup = ref.watch(_signupUseCaseProvider);
    _sendOtp = ref.watch(_sendOtpUseCaseProvider);
    _resetPassword = ref.watch(_resetPasswordUseCaseProvider);
    _verifyOtp = ref.watch(_verifyOtpUseCaseProvider);
    return const AuthInitial();
  }

  /// Log in with [identifier] (email or phone) and [password].
  Future<void> login({
    required String identifier,
    required String password,
  }) async {
    state = const AsyncLoading();
    state =
        await AsyncValue.guard(() async {
          final user = await _login(identifier: identifier, password: password);
          return AuthSuccess(message: 'Login successful', user: user);
        }).then(
          (asyncValue) => asyncValue.when(
            data: (s) => AsyncData(s),
            loading: () => const AsyncLoading(),
            error: (e, st) => AsyncData(AuthError(message: _friendly(e))),
          ),
        );
  }

  /// Sign up a new user.
  Future<void> signup({
    required String name,
    required String email,
    required String countryCode,
    required String phone,
    required String password,
    required String role,
  }) async {
    state = const AsyncLoading();
    state =
        await AsyncValue.guard(() async {
          await _signup(
            name: name,
            email: email,
            countryCode: countryCode,
            phone: phone,
            password: password,
            role: role,
          );
          return const AuthSuccess(message: 'Account created');
        }).then(
          (asyncValue) => asyncValue.when(
            data: (s) => AsyncData(s),
            loading: () => const AsyncLoading(),
            error: (e, st) => AsyncData(AuthError(message: _friendly(e))),
          ),
        );
  }

  /// Send OTP to [identifier] (email or phone).
  Future<void> sendOtp({required String identifier}) async {
    state = const AsyncLoading();
    state =
        await AsyncValue.guard(() async {
          await _sendOtp(identifier: identifier);
          return const AuthSuccess(message: 'OTP sent');
        }).then(
          (asyncValue) => asyncValue.when(
            data: (s) => AsyncData(s),
            loading: () => const AsyncLoading(),
            error: (e, st) => AsyncData(AuthError(message: _friendly(e))),
          ),
        );
  }

  /// Verify OTP code.
  Future<void> verifyOtp({
    required String identifier,
    required String otp,
  }) async {
    state = const AsyncLoading();
    state =
        await AsyncValue.guard(() async {
          final user = await _verifyOtp(identifier: identifier, otp: otp);
          return AuthSuccess(message: 'OTP verified successfully', user: user);
        }).then(
          (asyncValue) => asyncValue.when(
            data: (s) => AsyncData(s),
            loading: () => const AsyncLoading(),
            error: (e, st) => AsyncData(AuthError(message: _friendly(e))),
          ),
        );
  }

  /// Reset password for [identifier].
  Future<void> resetPassword({
    required String identifier,
    required String newPassword,
  }) async {
    state = const AsyncLoading();
    state =
        await AsyncValue.guard(() async {
          await _resetPassword(
            identifier: identifier,
            newPassword: newPassword,
          );
          return const AuthSuccess(message: 'Password reset');
        }).then(
          (asyncValue) => asyncValue.when(
            data: (s) => AsyncData(s),
            loading: () => const AsyncLoading(),
            error: (e, st) => AsyncData(AuthError(message: _friendly(e))),
          ),
        );
  }

  /// Reset back to initial so screens don't see a stale success/error state.
  void resetState() {
    state = const AsyncData(AuthInitial());
  }

  String _friendly(Object e) {
    if (e is Exception) {
      return e.toString().replaceAll('Exception: ', '');
    }
    return e.toString();
  }
}

final authNotifierProvider = AsyncNotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);
