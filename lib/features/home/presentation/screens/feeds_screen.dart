import 'package:flutter/material.dart';
import 'package:snapmap/core/data/mock_feeds.dart';
import 'package:snapmap/features/home/presentation/widgets/feeds/single_feed.dart';
import 'package:snapmap/generated/app_localizations.dart'; // <-- Added import

class FeedsScreen extends StatefulWidget {
  final AppLocalizations localizations; // <-- Added localizations parameter

  const FeedsScreen({super.key, required this.localizations});

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: mockFeeds.length,
      itemBuilder: (context, index) => SingleFeed(
        feed: mockFeeds[index],
        localizations:
            widget.localizations, // <-- Passed down to each feed item
      ),
      separatorBuilder: (context, index) => const SizedBox(height: 20),
    );
  }
}
