import 'package:flutter/material.dart';
import 'package:snapmap/core/data/mock_feeds.dart';
import 'package:snapmap/core/theme/app_colors.dart';
import 'package:snapmap/core/theme/app_text_styles.dart';
import 'package:snapmap/core/utils/extensions.dart';
import 'package:snapmap/core/widgets/custom/custom_button.dart';
import 'package:snapmap/features/home/domain/entities/feed_entity.dart';

class TrendingWidget extends StatefulWidget {
  const TrendingWidget({super.key});

  @override
  State<TrendingWidget> createState() => _TrendingWidget();
}

class _TrendingWidget extends State<TrendingWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Trending now"),
            CustomButton.text(
              text: "see all".capitalize(),
              width: 90,
              onPressed: () {},
              textColor: AppColors.primary,
            ),
          ],
        ),
        SizedBox(height: 4),
        ListView(
          shrinkWrap: true,

          physics: const NeverScrollableScrollPhysics(),
          children: mockFeeds
              .sublist(0, 4)
              .map((item) => _singleFeed(item))
              .toList(),
        ),
      ],
    );
  }

  Widget _singleFeed(FeedEntity feed) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 12),
      child: Padding(
        padding: EdgeInsets.all(20),
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
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Badge(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 3,
                        ),
                        label: Text(
                          feed.category, // <-- Localized
                          style: AppTextStyles.bodySmall.copyWith(fontSize: 11),
                        ),
                        textColor: AppColors.trendingTextColor,
                        backgroundColor: AppColors.trendingBgColor,
                      ),
                    ),
                    const SizedBox(width: 8),

                    Text(
                      feed.posted.replaceAll(' ago', ''),
                      style: AppTextStyles.bodySmall.copyWith(fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(feed.title),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '${feed.going} going', // <-- Localized (e.g. "going")
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.borderDark,
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  '${feed.interested} ', // <-- Localized (e.g. "interested")
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.borderDark,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
