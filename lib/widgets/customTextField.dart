import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      required this.leadingIcon,
      required this.controller,
      required this.hintText,
      this.obscureText = false,
      this.keyboardType = TextInputType.text})
      : super(key: key);
  final Icon leadingIcon;
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 20,
          ),
          leadingIcon,
          const SizedBox(
            width: 10,
            height: 20,
            child: VerticalDivider(),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              onChanged: (value) {},
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
              ),
              obscureText: obscureText,
            ),
          ),
        ],
      ),
    );
  }
}
