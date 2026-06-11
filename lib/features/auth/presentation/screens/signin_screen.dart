import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
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
import 'package:snapmap/generated/app_localizations.dart'; // <-- Added import

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
    final localizations = AppLocalizations.of(
      context,
    )!; // <-- Initialized localizations

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
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
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
                            localizations.welcomeBack
                                .capitalize(), // <-- Localized
                            style: AppTextStyles.titleLarge.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: AppDimensions.height4),
                          Text(
                            localizations.loginContent
                                .capitalize(), // <-- Localized
                            style: AppTextStyles.titleMedium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          SizedBox(height: AppDimensions.height24),
                          CustomButton(
                            text: localizations.signinWithFacebook
                                .capitalize(), // <-- Localized
                            iconLeft: SvgPicture.asset(IconsConstants.fbIcon),
                            isFullWidth: true,
                            height: AppDimensions.buttonHeight2XL,
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "comming soon", // <-- Localized
                                  ),
                                  backgroundColor: Colors.indigoAccent,
                                ),
                              );
                            },
                          ),
                          SizedBox(height: AppDimensions.height24),
                          CustomButton.outlined(
                            text: localizations.signinWithGoogle
                                .capitalize(), // <-- Localized
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
                              localizations.orSigninWithEmail
                                  .toUpperCase(), // <-- Localized
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.sidebarSubTitle,
                              ),
                            ),
                          ),
                          SizedBox(height: AppDimensions.height30),
                          CustomInput(
                            label: localizations.emailAddress, // <-- Localized
                            hint: localizations
                                .enterEmailAddress, // <-- Localized
                            controller: emailController,
                            validator: Validators.email,
                          ),
                          SizedBox(height: AppDimensions.height12),
                          CustomInput(
                            label: localizations.password, // <-- Localized
                            hint: localizations.enterPassword, // <-- Localized
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
                            text: localizations.forgotPassword, // <-- Localized
                            onPressed: () {
                              context.push(RouteConstants.forgotPassword);
                            },
                          ),
                          SizedBox(height: AppDimensions.height32),
                          CustomButton(
                            text: localizations.logIn
                                .capitalize(), // <-- Localized
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
                                    color:
                                        Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppColors.textPlaceholderDark
                                        : AppColors.textPrimary,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          '${localizations.dontHaveAnAccount.capitalize()} ', // <-- Localized
                                    ),
                                    TextSpan(
                                      text: localizations.create
                                          .capitalizeWords(), // <-- Localized
                                      style: const TextStyle(
                                        color: AppColors.primary,
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
