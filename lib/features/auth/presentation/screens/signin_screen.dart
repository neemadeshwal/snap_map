import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:snapmap/core/constants/app_constants.dart';
import 'package:snapmap/core/constants/assets_constants.dart';
import 'package:snapmap/core/constants/route_constants.dart';
import 'package:snapmap/core/theme/app_colors.dart';
import 'package:snapmap/core/theme/app_dimensions.dart';
import 'package:snapmap/core/theme/app_text_styles.dart';
import 'package:snapmap/core/utils/extensions.dart';
import 'package:snapmap/core/utils/validators.dart';
import 'package:snapmap/core/widgets/common/back_button.dart';
import 'package:snapmap/core/widgets/custom/custom_button.dart';
import 'package:snapmap/core/widgets/custom/custom_input.dart';
import 'package:snapmap/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:snapmap/features/auth/presentation/bloc/auth_event.dart';
import 'package:snapmap/features/auth/presentation/bloc/auth_state.dart';
import 'package:snapmap/features/auth/presentation/widgets/passwordToggle.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State createState() => _SigninScreen();
}

class _SigninScreen extends State<SigninScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _handleSignIn() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (_formKey.currentState!.validate()) {
      print(', email:$email, password:$password');
      context.read<AuthBloc>().add(
        SigninRequested(email: email, password: password),
      );
    }
  }

  void _handleGoogleSignin() {
    context.read<AuthBloc>().add(SigninWithGoogleRequested());
  }

  Future<void> _navigateAfterSignin(BuildContext context) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      if (context.mounted) context.go(RouteConstants.userSetup);
      return;
    }
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      final onboardingComplete =
          doc.data()?['onboardingComplete'] as bool? ?? false;
      if (!context.mounted) return;
      if (onboardingComplete) {
        context.go(RouteConstants.home);
      } else {
        context.go(RouteConstants.userSetup);
      }
    } catch (_) {
      if (context.mounted) context.go(RouteConstants.userSetup);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          current is Authenticated || current is AuthError,
      listener: (context, state) {
        if (state is Authenticated) {
          _navigateAfterSignin(context);
        }
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },

      builder: (context, state) {
        final loading = state is AuthLoading;
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: CommonBackButton(),
                  ),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimensions.paddingLG,
                        vertical: AppDimensions.paddingXS,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppConstants.welcomeBack.capitalize(),
                            style: AppTextStyles.titleLarge.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: AppDimensions.height4),
                          Text(
                            AppConstants.loginContent.capitalize(),
                            style: AppTextStyles.titleMedium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          SizedBox(height: AppDimensions.height24),

                          CustomButton(
                            text: AppConstants.signinwithfacebook.capitalize(),
                            iconLeft: SvgPicture.asset(IconsConstants.fbIcon),
                            isFullWidth: true,
                            height: AppDimensions.buttonHeight2XL,
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "This feature will be added later.",
                                  ),
                                  backgroundColor: Colors.indigoAccent,
                                ),
                              );
                            },
                          ),
                          SizedBox(height: AppDimensions.height24),
                          CustomButton.outlined(
                            text: AppConstants.signinwithgoogle.capitalize(),
                            iconLeft: SvgPicture.asset(
                              IconsConstants.googleIcon,
                            ),

                            textColor: AppColors.primary,
                            isFullWidth: true,
                            height: AppDimensions.buttonHeight2XL,
                            onPressed: _handleGoogleSignin,
                          ),
                          SizedBox(height: AppDimensions.height30),
                          Center(
                            child: Text(
                              AppConstants.orsigninwithemail.toUpperCase(),
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.sidebarSubTitle,
                              ),
                            ),
                          ),
                          SizedBox(height: AppDimensions.height30),

                          CustomInput(
                            label: AppConstants.emailAddress,
                            hint: AppConstants.enterEmailaddress,
                            controller: emailController,
                            validator: Validators.email,
                          ),
                          SizedBox(height: AppDimensions.height12),
                          CustomInput(
                            label: AppConstants.password,
                            hint: AppConstants.enterPassword,
                            obscureText: !_showPassword,
                            validator: Validators.password,
                            iconRight: Passwordtoggle(
                              showPassword: _showPassword,
                              onToggle: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                            ),
                            controller: passwordController,
                          ),
                          CustomButton.text(
                            textColor: AppColors.primary,
                            width: 150,
                            size: ButtonSize.extrasmall,
                            text: AppConstants.forgotPassword,
                            onPressed: () {
                              context.push(RouteConstants.forgotPassword);
                            },
                          ),
                          SizedBox(height: AppDimensions.height32),
                          CustomButton(
                            text: AppConstants.logIn.capitalize(),
                            onPressed: _handleSignIn,
                            isFullWidth: true,
                            height: AppDimensions.buttonHeight2XL,
                            isLoading: loading,
                          ),
                          SizedBox(height: AppDimensions.height32),

                          Center(
                            child: GestureDetector(
                              onTap: () => context.go(RouteConstants.signup),
                              child: RichText(
                                text: TextSpan(
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: AppColors.textPrimary,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          '${AppConstants.dontHaveAnAccount.capitalize()} ',
                                    ),
                                    TextSpan(
                                      text: AppConstants.create
                                          .capitalizeWords(),
                                      style: TextStyle(
                                        color: AppColors
                                            .primary, // ✅ Different color
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
