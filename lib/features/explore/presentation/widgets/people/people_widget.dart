import 'package:flutter/material.dart';
import 'package:snapmap/core/data/mock_people.dart';
import 'package:snapmap/core/theme/app_colors.dart';
import 'package:snapmap/core/utils/extensions.dart';
import 'package:snapmap/core/widgets/custom/custom_button.dart';
import 'package:snapmap/features/explore/domain/entities/person_entity.dart';

class PeopleWidget extends StatefulWidget {
  const PeopleWidget({super.key});

  @override
  State<PeopleWidget> createState() => _PeopleWidget();
}

class _PeopleWidget extends State<PeopleWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text("People to connect")),
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
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: mockPeople.map((item) => _singlePeople(item)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _singlePeople(PersonEntity person) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(person.avatarUrl),
            ),
            Text(person.name),
            Text('@${person.username}'),
            SizedBox(height: 7),

            Wrap(
              spacing: 4,
              children: person.interests
                  .map(
                    (interest) => Chip(
                      labelPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      backgroundColor: Colors.grey[100],
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 1,
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        side: BorderSide.none,

                        // REMOVES THE BORDER completely
                      ),
                      label: Text(
                        interest,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.black,
                        ),
                      ),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
