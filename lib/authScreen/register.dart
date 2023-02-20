import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:selller_amigo_app/authScreen/customTextField.dart';
import 'package:selller_amigo_app/constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorYellow,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(75 * 0.36, 0, 75 * 0.36, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {},
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.18,
                    backgroundColor: kColorRed,
                    backgroundImage: imageXFile == null
                        ? null
                        : FileImage(
                            File(imageXFile!.path),
                          ),
                    child: imageXFile == null
                        ? Icon(
                            Icons.add_photo_alternate_rounded,
                            color: Colors.white38,
                            size: MediaQuery.of(context).size.width * 0.15,
                          )
                        : null,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextField(
                    leadingIcon: Icon(
                      Icons.drive_file_rename_outline_sharp,
                      color: kColorRed,
                      size: 22,
                    ),
                    controller: nameController,
                    hintText: 'Enter your name',
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  leadingIcon: Icon(
                    Icons.email,
                    color: kColorRed,
                    size: 22,
                  ),
                  controller: emailController,
                  hintText: 'Enter your email',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  leadingIcon: Icon(
                    Icons.password_rounded,
                    color: kColorRed,
                    size: 22,
                  ),
                  controller: TextEditingController(),
                  hintText: 'Enter password',
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  leadingIcon: Icon(
                    Icons.password_rounded,
                    color: kColorRed,
                    size: 22,
                  ),
                  controller: TextEditingController(),
                  hintText: 'Enter confirm password',
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  leadingIcon: Icon(
                    Icons.phone,
                    color: kColorRed,
                    size: 22,
                  ),
                  controller: TextEditingController(),
                  hintText: 'Enter your phone number',
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  leadingIcon: Icon(
                    Icons.my_location,
                    color: kColorRed,
                    size: 22,
                  ),
                  controller: TextEditingController(),
                  hintText: 'Enter your address',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
