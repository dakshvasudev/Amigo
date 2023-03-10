import 'package:flutter/material.dart';
import 'package:selller_amigo_app/constants.dart';

class SearchBox extends StatelessWidget {
  // final ValueChanged<String> onChanged;
  const SearchBox({
    Key? key,
    // required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: kSecondaryColor.withOpacity(0.32),
        ),
      ),
      child: TextField(
        // onChanged: onChanged,
        onChanged: (hello) {},
        decoration: const InputDecoration(
          border: InputBorder.none,
          icon: Icon(Icons.search),
          hintText: "Search Here",
          hintStyle: TextStyle(color: kSecondaryColor),
        ),
      ),
    );
  }
}
