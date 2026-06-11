import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:snapmap/core/constants/assets_constants.dart';
import 'package:snapmap/core/theme/app_colors.dart';
import 'package:snapmap/core/theme/app_text_styles.dart';
import 'package:snapmap/core/utils/extensions.dart';
import 'package:snapmap/core/widgets/custom/custom_button.dart';
import 'package:snapmap/generated/app_localizations.dart'; // <-- Added import

class CommonHeader extends StatelessWidget implements PreferredSizeWidget {
  final AppLocalizations localizations; // <-- Added localizations parameter

  const CommonHeader({
    super.key,
    required this.localizations, // <-- Required in constructor
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              localizations.appName
                  .capitalize(), // <-- Localized via appName key (e.g., "SnapMap")
              style: AppTextStyles.bodyLarge.copyWith(fontSize: 22),
            ),
            Row(
              children: [
                CustomButton.icon(
                  icon: SvgPicture.asset(
                    IconsConstants.searchIcon,
                    width: 20,
                    height: 20,
                  ),
                  borderRadius: 99,
                  height: 40,
                  width: 40,
                  borderColor: AppColors.primaryLightDark,
                  bgColor: const Color.fromARGB(255, 241, 248, 249),
                  onPressed: () {},
                ),
                const SizedBox(width: 10),
                CustomButton.icon(
                  icon: SvgPicture.asset(
                    IconsConstants.notificationIcon,
                    width: 20,
                    height: 20,
                  ),
                  borderRadius: 99,
                  height: 40,
                  width: 40,
                  borderColor: AppColors.primaryLightDark,
                  bgColor: const Color.fromARGB(255, 241, 248, 249),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
