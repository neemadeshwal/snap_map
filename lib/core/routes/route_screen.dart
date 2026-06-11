import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:snapmap/core/constants/assets_constants.dart';
import 'package:snapmap/core/constants/route_constants.dart';
import 'package:snapmap/core/theme/app_colors.dart';
import 'package:snapmap/core/widgets/common/common_header.dart';
import 'package:snapmap/core/widgets/custom/custom_button.dart';
import 'package:snapmap/core/widgets/new_post.dart';
import 'package:snapmap/generated/app_localizations.dart'; // <-- Added import

class RouteScreen extends StatefulWidget {
  final Widget child;
  final String currentPath;

  const RouteScreen({
    super.key,
    required this.child,
    required this.currentPath,
  });

  @override
  State<RouteScreen> createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  @override
  Widget build(BuildContext context) {
    final activeRoute = widget.currentPath;
    final localizations = AppLocalizations.of(
      context,
    )!; // <-- Initialized localizations

    return Scaffold(
      backgroundColor: Color(0XFFf5f3ef),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CommonHeader(localizations: localizations),
      ),
      body: widget.child,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => NewPost(),
        ),
        backgroundColor: AppColors.primary,
        shape: const CircleBorder(),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: const Icon(Icons.add, color: AppColors.primary),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 9.0,
        color: const Color.fromARGB(255, 246, 246, 246),
        elevation: 10,
        clipBehavior: Clip.antiAlias,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CustomButton.icon(
              bgColor: Colors.transparent,
              icon: SvgPicture.asset(
                activeRoute == RouteConstants.home
                    ? IconsConstants.homeColoredIcon
                    : IconsConstants.homeIcon,
                width: 24,
                height: 24,
                color: activeRoute == RouteConstants.home
                    ? AppColors.primary
                    : AppColors.textPlaceholderDark,
              ),
              onPressed: () => context.go(RouteConstants.home),
            ),
            CustomButton.icon(
              bgColor: Colors.transparent,
              icon: SvgPicture.asset(
                activeRoute == RouteConstants.explore
                    ? IconsConstants.searchColoredIcon
                    : IconsConstants.searchIcon,
                width: 24,
                height: 24,
                color: activeRoute == RouteConstants.explore
                    ? AppColors.primary
                    : AppColors.textPlaceholderDark,
              ),
              onPressed: () => context.go(RouteConstants.explore),
            ),
            const SizedBox(width: 20),
            CustomButton.icon(
              bgColor: Colors.transparent,
              icon: SvgPicture.asset(
                activeRoute == RouteConstants.chat
                    ? IconsConstants.sendColoredIcon
                    : IconsConstants.sendIcon,
                width: 24,
                height: 24,
                color: activeRoute == RouteConstants.chat
                    ? AppColors.primary
                    : AppColors.textPlaceholderDark,
              ),
              onPressed: () => context.go(RouteConstants.chat),
            ),
            CustomButton.icon(
              bgColor: Colors.transparent,
              icon: SvgPicture.asset(
                activeRoute == RouteConstants.profile
                    ? IconsConstants.profileColoredIcon
                    : IconsConstants.profileIcon,
                width: 24,
                height: 24,
                color: activeRoute == RouteConstants.profile
                    ? AppColors.primary
                    : AppColors.textPlaceholderDark,
              ),
              onPressed: () => context.go(RouteConstants.profile),
            ),
          ],
        ),
      ),
    );
  }
}
