import 'package:flutter/material.dart';
import 'package:snapmap/core/constants/app_constants.dart';
import 'package:snapmap/core/constants/interest_constants.dart';
import 'package:snapmap/core/theme/app_colors.dart';
import 'package:snapmap/core/theme/app_dimensions.dart';
import 'package:snapmap/core/theme/app_text_styles.dart';
import 'package:snapmap/core/utils/extensions.dart';
import 'package:snapmap/core/widgets/custom/custom_button.dart';
import 'package:snapmap/core/widgets/custom/custom_input.dart';
import 'package:snapmap/features/onboarding/presentation/widgets/interest_chip.dart';

class NewPost extends StatefulWidget {
  const NewPost({super.key});

  @override
  State<NewPost> createState() => _NewPost();
}

class _NewPost extends State<NewPost> {
  TextEditingController postController = TextEditingController();
  final Set<String> _selectedInterestIds = {};

  void _onChipTap(String id) {
    setState(() {
      if (_selectedInterestIds.contains(id)) {
        _selectedInterestIds.remove(id);
      } else {
        _selectedInterestIds.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(vertical: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 20),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButton(),
                  Text("New event", style: AppTextStyles.appBarTitle),
                  CustomButton(
                    text: "post".capitalize(),
                    onPressed: () {},
                    borderRadius: 12,
                    width: 100,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              color: Color(0XFFf5f3ef),
              height: 300,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: Colors.grey.withValues(alpha: 0.4),
                        ),
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: CircleAvatar(
                        radius: 36,

                        backgroundColor: AppColors.grayTextColor.withValues(
                          alpha: 0.1,
                        ),
                        child: Icon(
                          Icons.camera_alt_outlined,
                          size: 32,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(height: 14),
                    Text(
                      "Tap to add photo or video",
                      style: AppTextStyles.buttonLarge.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CustomInput(
                label: "Caption",

                hint: "what's happening? Add #hashtags..",
                controller: postController,
                maxLines: 3,
              ),
            ),
            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text("Category", style: AppTextStyles.bodyMedium),
            ),
            SizedBox(height: 14),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                height: 35,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: InterestConstants.all.map((interest) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: InterestChip(
                        interest: interest,
                        isSelected: _selectedInterestIds.contains(interest.id),
                        onTap: _onChipTap,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                AppConstants.yourLocation.capitalize(),
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey[300]!
                      : AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: AppDimensions.height12),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.2),
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
                      'bengaluru',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
