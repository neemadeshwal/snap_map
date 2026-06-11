import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:snapmap/core/data/mock_interest.dart';
import 'package:snapmap/core/theme/app_colors.dart';
import 'package:snapmap/core/utils/extensions.dart';
import 'package:snapmap/core/widgets/custom/custom_button.dart';
import 'package:snapmap/features/explore/domain/entities/interest_enitity.dart';

class InterestWidget extends StatefulWidget {
  const InterestWidget({super.key});

  @override
  State<InterestWidget> createState() => _Interest();
}

class _Interest extends State<InterestWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text("Browse by interest")),
            CustomButton.text(
              text: "see all".capitalize(),
              width: 90,
              onPressed: () {},
              textColor: AppColors.primary,
            ),
          ],
        ),
        SizedBox(height: 7),
        GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // The magic number for 3 in a row
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio:
                1.2, // Tweak this decimal to make cards taller or shorter
          ),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: Math.min(6, mockInterest.length),
          itemBuilder: (context, index) {
            final item = mockInterest[index];
            return _singleInterest(item);
          },
        ),
      ],
    );
  }

  Widget _singleInterest(Interest interest) {
    return Card(
      margin: EdgeInsets.zero,
      color: interest.color.withValues(alpha: 0.4),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(interest.emoji, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 4),
            Text(
              interest.name.capitalize(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                overflow: TextOverflow.ellipsis,
              ),
              maxLines: 1,
            ),
            Text(
              '${interest.moments} moments',
              style: const TextStyle(
                fontSize: 11,
                color: Color.fromARGB(255, 111, 110, 110),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
