import 'package:flutter/material.dart';
import 'package:snapmap/features/explore/presentation/widgets/city/city_widget.dart';
import 'package:snapmap/features/explore/presentation/widgets/interest/interest_widget.dart';
import 'package:snapmap/features/explore/presentation/widgets/people/people_widget.dart';
import 'package:snapmap/features/explore/presentation/widgets/search/search.dart';
import 'package:snapmap/features/explore/presentation/widgets/trending/trending_widget.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State createState() => _ExploreScreen();
}

class _ExploreScreen extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Search(),
            SizedBox(height: 20),
            InterestWidget(),
            SizedBox(height: 20),
            TrendingWidget(),
            SizedBox(height: 20),
            PeopleWidget(),
            SizedBox(height: 20),
            CityWidget(),
          ],
        ),
      ),
    );
  }
}
