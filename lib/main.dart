// ignore_for_file: always_specify_types, use_build_context_synchronously

import 'package:facility_management/app/theme/app_colors.dart';
import 'package:facility_management/core/constants/assets_paths.dart';
import 'package:facility_management/data/providers/global_provider.dart';
import 'package:facility_management/presentation/Screens/landing_page.dart';
import 'package:facility_management/presentation/Screens/login_screen.dart';
import 'package:facility_management/presentation/Screens/signup_screen.dart';
import 'package:facility_management/widgets/restart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void mainInit() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: AppColors.backgroundPrimary),
  );
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(
      RestartWidget(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<GlobalProvider>(
              create: (BuildContext context) => GlobalProvider(),
            ),
          ],
          child: const MyApp(),
        ),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
      color: AppColors.fmBackground,
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(
          ThemeData.light().textTheme,
        ),
      ),
      builder:
          (context, child) => MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: TextScaler.linear(1)),
            child: BackgroundBlure(child: child!),
          ),
      routes: <String, WidgetBuilder>{
        '/loginPage': (BuildContext context) => const LoginScreen(),
        '/signupPage': (BuildContext context) => const SignUpScreen(),
        '/landingpage': (BuildContext context) => const FMLandingPage(),
      },
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();

    _navigateToLoginPage();
  }

  void _navigateToLoginPage() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/loginPage');
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fmBackground,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Image.asset(
              AssetsPathConstants.fmLogoPath,
              fit: BoxFit.contain,
              width: 220,
              height: 220,
            ),
          ),
        ),
      ),
    );
  }
}

class BackgroundBlure extends StatefulWidget {
  final Widget child;
  const BackgroundBlure({super.key, required this.child});

  @override
  State<BackgroundBlure> createState() => _BackgroundBlureState();
}

class _BackgroundBlureState extends State<BackgroundBlure>
    with WidgetsBindingObserver {
  bool appisBackground = false;
  int widgetIndex = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!mounted) return;
    setState(() {
      appisBackground =
          (state == AppLifecycleState.paused ||
              state == AppLifecycleState.inactive);
      widgetIndex = appisBackground ? 0 : 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: widgetIndex,
      children: [
        Container(
          color: AppColors.backgroundPrimary,
          child: Center(
            child: Image.asset(
              AssetsPathConstants.fmLogoPath,
              height: 200,
              width: 200,
            ),
          ),
        ),
        widget.child,
      ],
    );
  }
}

class PlaceholderProvider extends ChangeNotifier {
  // Placeholder for future provider logic
}
