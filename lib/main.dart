import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/routes/app_routes.dart';
import 'core/routes/app_route_names.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(375, 812),
      builder: (_, _) => MaterialApp.router(
        routerConfig: AppRoutes.router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        // onUnknownRoute: (settings) {
        // return MaterialPageRoute(
        //   builder: (context) => Scaffold(
        //     appBar: AppBar(title: const Text('Route Error')),
        //     body: Center(
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Text('No route defined for: ${settings.name}'),
        //           const SizedBox(height: 20),
        //           ElevatedButton(
        //             onPressed: () {
        //               Navigator.of(context).pushNamedAndRemoveUntil(
        //                 AppRouteNames.splashScreen,
        //                 (route) => false,
        //               );
        //             },
        //             child: const Text('Go Home'),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // );
        // },
      ),
    );
  }
}
