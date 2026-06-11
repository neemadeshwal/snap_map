import 'package:flutter/material.dart';
import 'package:snapmap/core/theme/app_colors.dart';
import 'package:snapmap/core/theme/app_text_styles.dart';
import 'package:snapmap/core/widgets/custom/custom_button.dart';
import 'package:snapmap/features/home/domain/entities/feed_entity.dart';
import 'package:snapmap/generated/app_localizations.dart'; // <-- Added import

class SingleFeed extends StatelessWidget {
  final FeedEntity feed;
  final AppLocalizations localizations; // <-- Added localizations parameter

  const SingleFeed({
    super.key,
    required this.feed,
    required this.localizations,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.cardColor),
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(99),
                      child: Image.network(
                        "https://mockmind-api.uifaces.co/content/human/219.jpg",
                        height: 40,
                        width: 40,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Cleaned up text alignment
                      children: [
                        Text(
                          feed.username,
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          feed.posted,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.grayTextColor,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.trendingborderColor,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Badge(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 3,
                        ),
                        label: Text(
                          '🔥 ${localizations.trending}', // <-- Localized
                          style: AppTextStyles.bodySmall.copyWith(fontSize: 11),
                        ),
                        textColor: AppColors.trendingTextColor,
                        backgroundColor: AppColors.trendingBgColor,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.hourLeftBorderColor,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Badge(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        label: Text(
                          feed.timeLeft,
                          style: AppTextStyles.bodySmall.copyWith(fontSize: 11),
                        ),
                        textColor: AppColors.hourLeftTextColor,
                        backgroundColor: AppColors.hourLeftBgColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 248, 230, 202),
                    Color.fromARGB(255, 254, 205, 190),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(feed.title),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '${feed.going} ${localizations.goingCountText}', // <-- Localized (e.g. "going")
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.borderDark,
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  '${feed.interested} ${localizations.interestedCountText}', // <-- Localized (e.g. "interested")
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.borderDark,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
            const Divider(color: AppColors.cardColor),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${feed.distance} ${localizations.awayText}', // <-- Localized (e.g. "away")
                  style: AppTextStyles.bodySmall,
                ),
                Row(
                  children: [
                    CustomButton.icon(
                      borderColor: AppColors.cardColor,
                      bgColor: Colors.white,
                      icon: const Icon(
                        Icons.favorite_outline,
                        color: AppColors.primarySoft,
                      ),
                      onPressed: () {},
                    ),
                    const SizedBox(width: 10),
                    CustomButton(
                      bgColor: AppColors.primary,
                      text: localizations.goingBtn, // <-- Localized
                      textColor: Colors.white,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
