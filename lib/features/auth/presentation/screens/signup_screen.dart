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

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State createState() => _SignupScreen();
}

class _SignupScreen extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  bool _showConfirmPassword = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleCreateAccount() {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (_formKey.currentState!.validate()) {
      print('name: $name, email:$email, password:$password');
      context.read<AuthBloc>().add(
        SignupRequested(email: email, password: password, name: name),
      );
    }
  }

  void _handleGoogleSignin() {
    context.read<AuthBloc>().add(SigninWithGoogleRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          current is Authenticated || current is AuthError,
      listener: (context, state) {
        if (state is Authenticated) {
          context.go(RouteConstants.userSetup);
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
                    padding: const EdgeInsets.all(4.0),
                    child: CommonBackButton(),
                  ),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimensions.paddingLG,
                        vertical: AppDimensions.paddingSM,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppConstants.welcome.capitalize(),
                            style: AppTextStyles.titleLarge.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: AppDimensions.height4),
                          Text(
                            AppConstants.signupContent.capitalize(),
                            style: AppTextStyles.titleMedium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          SizedBox(height: AppDimensions.height24),

                          CustomButton(
                            text: AppConstants.signupwithfacebook.capitalize(),
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
                            text: AppConstants.signupwithgoogle.capitalize(),
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
                              AppConstants.orsignupwithemail.toUpperCase(),
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.sidebarSubTitle,
                              ),
                            ),
                          ),
                          SizedBox(height: AppDimensions.height30),

                          CustomInput(
                            label: AppConstants.fullname,
                            hint: AppConstants.enterFullname,
                            controller: nameController,
                            validator: Validators.username,
                          ),
                          SizedBox(height: AppDimensions.height12),

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
                          SizedBox(height: AppDimensions.height12),
                          CustomInput(
                            label: AppConstants.confirmPassword,
                            hint: AppConstants.enterPassword,
                            controller: confirmPasswordController,
                            obscureText: !_showConfirmPassword,
                            validator: (value) => Validators.confirmPassword(
                              value,
                              passwordController.text.trim(),
                            ),
                            iconRight: Passwordtoggle(
                              showPassword: _showConfirmPassword,
                              onToggle: () {
                                setState(() {
                                  _showConfirmPassword = !_showConfirmPassword;
                                });
                              },
                            ),
                          ),
                          SizedBox(height: AppDimensions.height32),
                          CustomButton(
                            text: AppConstants.create.capitalize(),
                            onPressed: _handleCreateAccount,
                            isFullWidth: true,
                            height: AppDimensions.buttonHeight2XL,
                            isLoading: loading,
                          ),
                          SizedBox(height: AppDimensions.height32),

                          Center(
                            child: GestureDetector(
                              onTap: () => context.go(RouteConstants.signin),
                              child: RichText(
                                text: TextSpan(
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: AppColors.textPrimary,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          '${AppConstants.alreadyHaveAnAccount.capitalize()} ',
                                    ),
                                    TextSpan(
                                      text: AppConstants.logIn
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
