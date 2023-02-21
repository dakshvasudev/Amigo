import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  Future<void> _getImage() async{
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  onTap: () {
                    _getImage();
                  },
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
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
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
                        controller: passwordController,
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
                        controller: confirmPasswordController,
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
                        controller: phoneNumberController,
                        hintText: 'Enter your phone number',
                        keyboardType: TextInputType.phone,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 55,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: kColorRed,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Register",
                            style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900)),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
