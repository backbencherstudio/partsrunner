import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstant {
  
  static final bool _isLocal = true;

  // ─────────────────────────────────────────
  // BASE URL (loaded from .env)
  // ─────────────────────────────────────────
  static String get baseUrl => _isLocal
      ? 'https://opinion-certainly-cakes-champion.trycloudflare.com'
      : dotenv.env['BASE_URL'] ??
            'https://opinion-certainly-cakes-champion.trycloudflare.com';

}