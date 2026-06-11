import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:snapmap/core/constants/assets_constants.dart';
import 'package:snapmap/core/widgets/custom/custom_input.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _Search();
}

class _Search extends State<Search> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomInput(
      label: "",
      hint: "search moments, people, places...",
      controller: searchController,
      bgColor: Colors.white,

      iconLeft: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 8.0),
        child: SvgPicture.asset(
          IconsConstants.searchIcon,
          width: 24,
          height: 24,
          color: Colors.grey,
        ),
      ),
    );
  }
}
