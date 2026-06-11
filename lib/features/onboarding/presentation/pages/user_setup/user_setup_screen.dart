import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:snapmap/core/constants/app_constants.dart';
import 'package:snapmap/core/constants/interest_constants.dart';
import 'package:snapmap/core/constants/route_constants.dart';
import 'package:snapmap/core/theme/app_colors.dart';
import 'package:snapmap/core/theme/app_dimensions.dart';
import 'package:snapmap/core/theme/app_text_styles.dart';
import 'package:snapmap/core/utils/extensions.dart';
import 'package:snapmap/core/utils/validators.dart';
import 'package:snapmap/core/widgets/custom/custom_button.dart';
import 'package:snapmap/core/widgets/custom/custom_input.dart';
import 'package:snapmap/features/onboarding/domain/entity/location_entity.dart';
import 'package:snapmap/features/onboarding/presentation/bloc/user_setup_bloc.dart';
import 'package:snapmap/features/onboarding/presentation/bloc/user_setup_event.dart';
import 'package:snapmap/features/onboarding/presentation/bloc/user_setup_state.dart';
import 'package:snapmap/features/onboarding/presentation/widgets/avatar_picker.dart';
import 'package:snapmap/features/onboarding/presentation/widgets/interest_chip.dart';

class UserSetupScreen extends StatefulWidget {
  const UserSetupScreen({super.key});

  @override
  State createState() => _UserSetupScreen();
}

class _UserSetupScreen extends State<UserSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final Set<String> _selectedInterestIds = {};

  TextEditingController usernameController = TextEditingController();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    displayNameController.text = user?.displayName ?? "";
    context.read<UserSetupBloc>().add(GetLocationRequested());
  }

  @override
  void dispose() {
    usernameController.dispose();
    displayNameController.dispose();
    bioController.dispose();
    super.dispose();
  }

  void _onChipTap(String id) {
    setState(() {
      if (_selectedInterestIds.contains(id)) {
        _selectedInterestIds.remove(id);
      } else {
        _selectedInterestIds.add(id);
      }
    });
  }

  void _handleUserSetup() {
    print("user");
    final userName = usernameController.text.trim().replaceAll('@', '');
    final displayName = displayNameController.text.trim();
    final bio = bioController.text.trim();
    final currentState = context.read<UserSetupBloc>().state;
    if (currentState.location == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please wait for location to be detected'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    // in _handleUserSetup before dispatch
    if (_selectedInterestIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select at least one interest'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (_formKey.currentState!.validate()) {
      final profileLocalPath = currentState.avatar?.imagePath;
      context.read<UserSetupBloc>().add(
        SaveUserRequested(
          bio: bio,
          username: userName,
          displayName: displayName,
          interests: _selectedInterestIds.toList(),
          profileLocalPath: profileLocalPath,
          location: currentState.location!,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserSetupBloc, UserSetupState>(
      listenWhen: (previous, current) =>
          previous.isSaved != current.isSaved ||
          previous.errorMessage != current.errorMessage,
      listener: (context, state) {
        if (state.isSaved) {
          context.go(RouteConstants.home);
        }
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        final userSaving = state.isSaving;
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimensions.paddingLG,
                        vertical: AppDimensions.paddingLG,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppConstants.createYourProfile.capitalize(),
                            style: AppTextStyles.titleLarge.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: AppDimensions.height4),
                          Text(
                            AppConstants.userSetupContent.capitalize(),
                            style: AppTextStyles.titleMedium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          SizedBox(height: AppDimensions.height24),
                          Center(
                            child: AvatarPicker(
                              size: 90,
                              accentColor: AppColors.primary,
                            ),
                          ),
                          SizedBox(height: AppDimensions.height24),

                          CustomInput(
                            label: AppConstants.userName,
                            hint: AppConstants.yourhandle,
                            controller: usernameController,
                            prefixText: '@',
                            onChanged: (value) {
                              final clean = value.replaceAll('@', '');
                              if (clean.isEmpty) return;
                              context.read<UserSetupBloc>().add(
                                UsernameChanged(clean),
                              );
                            },
                            validator: Validators.username,
                          ),
                          BlocBuilder<UserSetupBloc, UserSetupState>(
                            buildWhen: (prev, curr) =>
                                prev.usernameStatus != curr.usernameStatus,
                            builder: (context, state) {
                              switch (state.usernameStatus) {
                                case UsernameStatus.checking:
                                  return Row(
                                    children: [
                                      SizedBox(
                                        width: 12,
                                        height: 12,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 1.5,
                                        ),
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        'Checking...',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  );

                                case UsernameStatus.available:
                                  return Text(
                                    'username is available',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 12,
                                    ),
                                  );

                                case UsernameStatus.taken:
                                  return Text(
                                    'already taken',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 12,
                                    ),
                                  );
                                case UsernameStatus.idle:
                                  return const SizedBox.shrink();
                              }
                            },
                          ),

                          SizedBox(height: AppDimensions.height12),
                          CustomInput(
                            label: AppConstants.displayName,
                            hint: AppConstants.howYourNameAppears,
                            controller: displayNameController,
                          ),
                          SizedBox(height: AppDimensions.height12),
                          CustomInput(
                            label: AppConstants.bio,
                            hint: AppConstants.bioHint,
                            controller: bioController,
                            maxLines: 3,
                            height: null,
                          ),
                          SizedBox(height: AppDimensions.height12),
                          Text(AppConstants.yourInterests.capitalize()),
                          SizedBox(height: AppDimensions.height12),

                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: InterestConstants.all.map((interest) {
                              return InterestChip(
                                interest: interest,
                                isSelected: _selectedInterestIds.contains(
                                  interest.id,
                                ),
                                onTap: _onChipTap,
                              );
                            }).toList(),
                          ),
                          SizedBox(height: AppDimensions.height12),
                          Text(
                            AppConstants.yourLocation.capitalize(),
                            style: TextStyle(
                              color:
                                  Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.grey[300]!
                                  : AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: AppDimensions.height12),

                          BlocBuilder<UserSetupBloc, UserSetupState>(
                            buildWhen: (prev, curr) =>
                                prev.location != curr.location ||
                                prev.isLocationLoading !=
                                    curr.isLocationLoading, // ← remove !
                            builder: (context, state) {
                              if (state.isLocationLoading) {
                                return Row(
                                  children: [
                                    SizedBox(
                                      width: 12,
                                      height: 12,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 1.5,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Detecting location...',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.06,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: AppColors.primary.withValues(
                                      alpha: 0.2,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_rounded,
                                      color: AppColors.primary,
                                      size: 16,
                                    ),
                                    SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        state.location?.cityName ??
                                            'Location not detected',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }, // ← close builder
                          ), // ← close BlocBuilder

                          SizedBox(height: AppDimensions.height12),
                          CustomButton.primary(
                            isFullWidth: true,
                            text: AppConstants.save.capitalize(),
                            onPressed: _handleUserSetup,
                            isLoading: userSaving,
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
