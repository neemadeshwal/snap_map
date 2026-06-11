import 'package:flutter/material.dart';
import 'package:snapmap/core/data/mock_city.dart';
import 'package:snapmap/core/theme/app_colors.dart';
import 'package:snapmap/core/utils/extensions.dart';
import 'package:snapmap/core/widgets/custom/custom_button.dart';
import 'package:snapmap/features/explore/domain/entities/city_entity.dart';

class CityWidget extends StatefulWidget {
  const CityWidget({super.key});

  @override
  State<CityWidget> createState() => _CityWidget();
}

class _CityWidget extends State<CityWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Explore other cities"),
            CustomButton.text(
              text: "see all".capitalize(),
              width: 90,
              onPressed: () {},
              textColor: AppColors.primary,
            ),
          ],
        ),

        SizedBox(height: 7),
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: mockCities.map((item) => _singleCity(item)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _singleCity(CityEntity city) {
    return SizedBox(
      width: 180,
      child: Card(
        color: city.themeColor.withValues(alpha: 0.2),

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(city.cityName),
              Text('${city.activeEvents.length} events'),
            ],
          ),
        ),
      ),
    );
  }
}
