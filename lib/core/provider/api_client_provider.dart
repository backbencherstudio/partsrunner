import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partsrunner/core/services/api_service/api_client.dart';

final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());
