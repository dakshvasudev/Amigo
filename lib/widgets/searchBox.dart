import 'package:flutter/material.dart';
import 'package:user_amigo_app/constants.dart';


class SearchBox extends StatelessWidget {
  // final ValueChanged<String> onChanged;
  const SearchBox({
    Key? key,
    // required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: kSecondaryColor.withOpacity(0.32),
        ),
      ),
      child: TextField(
        // onChanged: onChanged,
        onChanged: (hello){},
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(Icons.search),
          hintText: "Search Here",
          hintStyle: TextStyle(color: kSecondaryColor),
        ),
      ),
    );
  }
}