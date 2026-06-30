// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:facility_management/app/theme/app_colors.dart';
import 'package:facility_management/core/constants/assets_paths.dart';
import 'package:facility_management/core/utils/common_utils.dart';
import 'package:facility_management/data/providers/global_provider.dart';
import 'package:facility_management/services/connectivity_service.dart';
import 'package:facility_management/widgets/fm_button.dart';
import 'package:facility_management/widgets/fm_textfiled.dart';
import 'package:facility_management/widgets/login_with_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'landing_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with WidgetsBindingObserver {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool rememberMe = false;
  bool isLoading = false;

  final TextEditingController _emailController = TextEditingController(
    text: 'test@example.com',
  );
  final TextEditingController _passwordController = TextEditingController(
    text: 'password',
  );

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (!mounted) return;
      ConnectivityService().checkConnection(context);
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    if (!mounted) return;
    ConnectivityService().checkConnection(context);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalProvider globalProvider = Provider.of<GlobalProvider>(context);
    Widget buildToggle(String label, bool isSelected) {
      return GestureDetector(
        onTap: () {
          globalProvider.setSelectedRole(label);
        },
        child: Container(
          width: 150,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.fmBlue50 : Colors.white,
            border: Border.all(
              color: isSelected ? AppColors.fmBlue950 : Colors.grey.shade300,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(
                label == 'staff'
                    ? Icons.person_outline
                    : Icons.people_outline_outlined,
                color: isSelected ? AppColors.fmBlue950 : Colors.grey,
                size: 18,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.w600,
                  color:
                      isSelected ? AppColors.fmBlue950 : Colors.grey.shade800,
                ),
              ),
              if (!isSelected) ...[
                SizedBox(width: label == 'staff' ? 45 : 10),
                Icon(
                  Icons.circle_outlined,
                  color: Colors.grey.shade600,
                  size: 16,
                ),
              ],
              if (isSelected) ...[
                SizedBox(width: label == 'staff' ? 45 : 10),
                Icon(Icons.check_circle, color: AppColors.fmBlue950, size: 18),
              ],
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth:
                                    constraints.maxWidth < 600
                                        ? double.infinity
                                        : 450,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 32,
                                ),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Log in',
                                        style: GoogleFonts.lato(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.fmBlue950,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: AppColors.fmBlue950,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.sensors,
                                              color: AppColors.fmBlue950,
                                              size: 20,
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              "Scan with RFID Crew Card",
                                              style: GoogleFonts.lato(
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.fmBlue950,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        children: <Widget>[
                                          const Expanded(
                                            child: Divider(
                                              color: Colors.grey,
                                              thickness: 1,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                            ),
                                            child: Text(
                                              'Or login manually',
                                              style: GoogleFonts.lato(
                                                color: Colors.grey.shade600,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          const Expanded(
                                            child: Divider(
                                              color: Colors.grey,
                                              thickness: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),

                                      Center(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            buildToggle(
                                              "staff",
                                              globalProvider
                                                      .selectedRoleInLogin ==
                                                  "staff",
                                            ),
                                            const SizedBox(width: 12),
                                            buildToggle(
                                              "Supervisor",
                                              globalProvider
                                                      .selectedRoleInLogin ==
                                                  "Supervisor",
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      FMTextField(
                                        label: 'Email',
                                        placeholder: 'Enter your email',
                                        controller: _emailController,
                                        fieldType: TextFieldType.email,
                                        validator: (String? value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your email';
                                          }
                                          if (!RegExp(
                                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                                          ).hasMatch(value)) {
                                            return 'Enter a valid email';
                                          }
                                          return null;
                                        },
                                        onTap: () {
                                          _formKey.currentState!.validate();
                                        },
                                      ),
                                      const SizedBox(height: 16),
                                      FMTextField(
                                        label: 'Password',
                                        placeholder: 'Enter your password',
                                        controller: _passwordController,
                                        fieldType: TextFieldType.password,
                                        validator: (String? value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter your password';
                                          }
                                          if (value.length < 6) {
                                            return 'Password must be at least 6 characters';
                                          }
                                          return null;
                                        },
                                        onTap: () {
                                          _formKey.currentState!.validate();
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 12),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Checkbox(
                                                  value: rememberMe,
                                                  onChanged: (bool? val) {
                                                    setState(() {
                                                      rememberMe = val ?? false;
                                                    });
                                                  },
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          4,
                                                        ),
                                                  ),
                                                  side: const BorderSide(
                                                    color:
                                                        AppColors
                                                            .blackKindFontColor,
                                                    width: 1.5,
                                                  ),
                                                ),
                                                Text(
                                                  'Remember me',
                                                  style: GoogleFonts.lato(
                                                    color:
                                                        AppColors
                                                            .blackKindFontColor,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            TextButton(
                                              onPressed: () {},
                                              child: Text(
                                                'Forgot Password?',
                                                style: GoogleFonts.lato(
                                                  color: AppColors.fmBlue950,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      SizedBox(
                                        width: double.infinity,
                                        child: FMButton(
                                          label: 'Log In',
                                          bgColor: AppColors.fmBlue950,
                                          labelStyle: GoogleFonts.lato(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (context) =>
                                                          const FMLandingPage(),
                                                ),
                                              );
                                            }
                                          },
                                          height:
                                              constraints.maxWidth < 600
                                                  ? 48
                                                  : 52,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "Don't have an account?",
                                            style: GoogleFonts.lato(
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              Navigator.of(
                                                context,
                                              ).pushNamed('/signupPage');
                                            },
                                            child: Text(
                                              'Sign Up',
                                              style: GoogleFonts.lato(
                                                color: AppColors.fmBlue550,
                                                fontWeight: FontWeight.bold,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          const Expanded(
                                            child: Divider(
                                              color: Colors.grey,
                                              thickness: 1,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                            ),
                                            child: Text(
                                              'Or login with',
                                              style: GoogleFonts.lato(
                                                color: Colors.grey.shade600,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          const Expanded(
                                            child: Divider(
                                              color: Colors.grey,
                                              thickness: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: LoginWithButton(
                                              imgPath:
                                                  AssetsPathConstants
                                                      .googleImagePicPath,
                                              onClicked: () {},
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: AlignmentDirectional.bottomEnd,
            child: Image.asset(AssetsPathConstants.loginFlowImagePicPath),
          ),
        ],
      ),
    );
  }

  Future<void> checkInternetConnection(BuildContext context) async {
    try {
      List<NetworkInterface> deviceIp = await NetworkInterface.list(
        type: InternetAddressType.IPv4,
      );
      if (deviceIp.isEmpty) {
        throw const SocketException('No Internet Connection');
      }
      return;
    } on SocketException catch (_) {
      showErrorSnack(context, 'No internet connection');
    }
  }
}
