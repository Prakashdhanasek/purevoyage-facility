// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';
import 'package:facility_management/app/theme/app_colors.dart';
import 'package:facility_management/app/theme/app_text_styles.dart';
import 'package:facility_management/core/constants/assets_paths.dart';
import 'package:facility_management/core/utils/common_utils.dart';
import 'package:facility_management/services/connectivity_service.dart';
import 'package:facility_management/widgets/fm_button.dart';
import 'package:facility_management/widgets/fm_textfiled.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with WidgetsBindingObserver {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool rememberMe = false;
  bool isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
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

  String selected = 'Staff';

  @override
  Widget build(BuildContext context) {
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
                                padding: EdgeInsets.symmetric(
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
                                        'Sign Up',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.fmBlue950,
                                        ),
                                      ),
                                      SizedBox(height: 20),
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
                                      ),
                                      SizedBox(height: 16),
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
                                      ),
                                      SizedBox(height: 16),

                                      FMTextField(
                                        label: 'Confirm Password',
                                        placeholder: 'Enter Password Again',
                                        showFloatingLabel: true,
                                        controller: _confirmPasswordController,
                                        fieldType: TextFieldType.password,
                                        isOptional: false,
                                        validator: (String? value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Confirm password is required';
                                          }
                                          if (value !=
                                              _passwordController.text) {
                                            return 'Passwords do not match';
                                          }
                                          return null;
                                        },
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 12),
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
                                                  style: captionsMetadata.copyWith(
                                                    color:
                                                        AppColors
                                                            .blackKindFontColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 24),
                                      SizedBox(
                                        width: double.infinity,
                                        child: FMButton(
                                          label: 'Sign Up',
                                          bgColor: AppColors.fmBlue950,
                                          labelStyle: appBarTitle.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          onPressed: () async {
                                            if (!_formKey.currentState!
                                                .validate()) {
                                              return;
                                            }
                                          },
                                          height:
                                              constraints.maxWidth < 600
                                                  ? 48
                                                  : 52,
                                        ),
                                      ),

                                      SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "Do you have an account?",
                                            style: captionsMetadata.copyWith(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              Navigator.of(
                                                context,
                                              ).pushReplacementNamed(
                                                '/loginPage',
                                              );
                                            },
                                            child: Text(
                                              'Log in',
                                              style: captionsMetadata.copyWith(
                                                color: AppColors.fmBlue550,
                                                fontWeight: FontWeight.w600,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
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
                          SizedBox(height: 32),
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
