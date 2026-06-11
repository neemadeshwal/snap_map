import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:snapmap/generated/app_localizations.dart'; // <-- Added import

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void _handleForgotPassword() {
    final email = emailController.text.trim();
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(ForgotPassRequested(email: email));
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(
      context,
    )!; // <-- Grab localized instance

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is ForgotPassLinkSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                localizations.passwordResetEmailSent,
              ), // <-- Localized message
              backgroundColor: Colors.green,
            ),
          );
          await Future.delayed(const Duration(seconds: 1));
          if (context.mounted) Navigator.of(context).pop();
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
                          localizations.forgotPassword
                              .capitalize(), // <-- Localized
                          style: AppTextStyles.titleLarge.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: AppDimensions.height4),
                        Text(
                          localizations.forgotPasswordContent
                              .capitalize(), // <-- Localized
                          style: AppTextStyles.titleMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        SizedBox(height: AppDimensions.height24),
                        CustomInput(
                          label: localizations.emailAddress, // <-- Localized
                          hint:
                              localizations.enterEmailAddress, // <-- Localized
                          controller: emailController,
                          validator: Validators.email,
                        ),
                        SizedBox(height: AppDimensions.height32),
                        CustomButton(
                          text: localizations.continueBtn
                              .capitalize(), // <-- Localized
                          onPressed: _handleForgotPassword,
                          isFullWidth: true,
                          height: AppDimensions.buttonHeight2XL,
                          isLoading: loading,
                        ),
                        SizedBox(height: AppDimensions.height32),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
