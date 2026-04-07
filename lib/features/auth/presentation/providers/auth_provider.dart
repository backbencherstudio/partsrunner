import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partsrunner/core/api_service/api_client.dart';
import 'package:partsrunner/core/constant/auth_method.dart';
import 'package:partsrunner/core/constant/user_role.dart';
import 'package:partsrunner/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:partsrunner/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:partsrunner/features/auth/domain/entities/user_entity.dart';
import 'package:partsrunner/features/auth/domain/repositories/auth_repository.dart';
import 'package:partsrunner/features/auth/domain/usecases/create_contractor_usecase.dart';
import 'package:partsrunner/features/auth/domain/usecases/create_runner_usecase.dart';
import 'package:partsrunner/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:partsrunner/features/auth/domain/usecases/login_usecase.dart';
import 'package:partsrunner/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:partsrunner/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:partsrunner/features/auth/domain/usecases/signup_usecase.dart';
import 'package:partsrunner/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ---------------------------------------------------------------------------
// UI-only state providers (unchanged)
// ---------------------------------------------------------------------------

final authMethodProvider = StateProvider<AuthMethod?>(
  (ref) => AuthMethod.email,
);

final rememberMeProvider = StateProvider<bool>((ref) => false);

final selectedRoleProvider = StateProvider<UserRole?>((ref) => null);

// ---------------------------------------------------------------------------
// Resend OTP state providers
// ---------------------------------------------------------------------------

final resendTimerProvider = StateProvider<int>((ref) => 0);
final canResendProvider = StateProvider<bool>((ref) => true);
final isResendingProvider = StateProvider<bool>((ref) => false);

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

final _forgotPasswordUseCaseProvider = Provider<ForgotPasswordUsecase>(
  (ref) => ForgotPasswordUsecase(ref.watch(_authRepositoryProvider)),
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

final _createContractorUseCaseProvider = Provider<CreateContractorUsecase>(
  (ref) => CreateContractorUsecase(ref.watch(_authRepositoryProvider)),
);

final _createRunnerUseCaseProvider = Provider<CreateRunnerUsecase>(
  (ref) => CreateRunnerUsecase(ref.watch(_authRepositoryProvider)),
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
  late ForgotPasswordUsecase _forgotPassword;
  late CreateContractorUsecase _createContractor;
  late CreateRunnerUsecase _createRunner;

  @override
  Future<AuthState> build() async {
    _login = ref.watch(_loginUseCaseProvider);
    _signup = ref.watch(_signupUseCaseProvider);
    _sendOtp = ref.watch(_sendOtpUseCaseProvider);
    _resetPassword = ref.watch(_resetPasswordUseCaseProvider);
    _verifyOtp = ref.watch(_verifyOtpUseCaseProvider);
    _forgotPassword = ref.watch(_forgotPasswordUseCaseProvider);
    _createContractor = ref.watch(_createContractorUseCaseProvider);
    _createRunner = ref.watch(_createRunnerUseCaseProvider);
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
    final pref = await SharedPreferences.getInstance();
    state = const AsyncLoading();
    state =
        await AsyncValue.guard(() async {
          final user = await _verifyOtp(identifier: identifier, otp: otp);
          pref.setString('userId', user.id.toString());
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
    required String? email,
    required String? phone,
    required String? countryCode,
    required String? otp,
    required String newPassword,
  }) async {
    state = const AsyncLoading();
    state =
        await AsyncValue.guard(() async {
          await _resetPassword(
            email: email,
            phone: phone,
            countryCode: countryCode,
            otp: otp,
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

  Future<void> forgotPassword({
    String? email,
    String? countryCode,
    String? phone,
  }) async {
    state = const AsyncLoading();
    state =
        await AsyncValue.guard(() async {
          await _forgotPassword(email: email, countryCode: countryCode, phone: phone);
          return const AuthSuccess(message: 'Password reset');
        }).then(
          (asyncValue) => asyncValue.when(
            data: (s) => AsyncData(s),
            loading: () => const AsyncLoading(),
            error: (e, st) => AsyncData(AuthError(message: _friendly(e))),
          ),
        );
  }

  Future<void> createContractor({
    required String companyName,
    required String businessAddress,
  }) async {
    final pref = await SharedPreferences.getInstance();
    final userId = pref.getString('userId');
    if (userId == null) {
      state = AsyncData(AuthError(message: 'User ID not found'));
      return;
    }
    state = const AsyncLoading();
    state =
        await AsyncValue.guard(() async {
          await _createContractor(
            userId: userId,
            companyName: companyName,
            businessAddress: businessAddress,
          );
          return const AuthSuccess(message: 'Contractor created');
        }).then(
          (asyncValue) => asyncValue.when(
            data: (s) => AsyncData(s),
            loading: () => const AsyncLoading(),
            error: (e, st) => AsyncData(AuthError(message: _friendly(e))),
          ),
        );
  }

  Future<void> createRunner({
    required String vehicleType,
    required String vehicleModel,
    required String vehicleIdentificationNumber,
  }) async {
    final pref = await SharedPreferences.getInstance();
    final userId = pref.getString('userId');
    if (userId == null) {
      state = AsyncData(AuthError(message: 'User ID not found'));
      return;
    }
    state = const AsyncLoading();
    state =
        await AsyncValue.guard(() async {
          await _createRunner(
            userId: userId,
            vehicleType: vehicleType,
            vehicleModel: vehicleModel,
            vehicleIdentificationNumber: vehicleIdentificationNumber,
          );
          return const AuthSuccess(message: 'Runner created');
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
