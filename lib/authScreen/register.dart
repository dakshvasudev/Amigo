import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:selller_amigo_app/mainScreens/home_screen.dart';
import 'package:selller_amigo_app/widgets/customTextField.dart';
import 'package:selller_amigo_app/constants.dart';
import 'package:selller_amigo_app/widgets/error_dialog.dart';
import 'package:selller_amigo_app/widgets/loading_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  String sellerImageUrl = '';

  Future<void> _getImage() async {
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageXFile;
    });
  }

  Future<void> registerFormValidation() async {
    if (imageXFile == null) {
      showDialog(
          context: context,
          builder: (context) {
            return ErrorDialog(message: 'Please add profile picture');
          });
    } else {
      if (passwordController.text == confirmPasswordController.text) {
        if (confirmPasswordController.text.isNotEmpty &&
            emailController.text.isNotEmpty &&
            nameController.text.isNotEmpty &&
            phoneNumberController.text.isNotEmpty) {
          //start uploading image
          showDialog(
              context: context,
              builder: (context) {
                return const LoadingDialog(
                  message: "Registering account",
                );
              });
          //start uploading image
          String fileName = DateTime.now().millisecondsSinceEpoch.toString();
          fStorage.Reference reference = fStorage.FirebaseStorage.instance
              .ref()
              .child("sellers")
              .child(fileName);
          fStorage.UploadTask uploadTask =
              reference.putFile(File(imageXFile!.path));

          fStorage.TaskSnapshot taskSnapshot =
              await uploadTask.whenComplete(() {});
          await taskSnapshot.ref.getDownloadURL().then((url) {
            sellerImageUrl = url;
            //save info to firestore database
            authenticateSellerAndSignUp();
          });
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return ErrorDialog(message: 'Please fill all the details');
              });
        }
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return ErrorDialog(message: 'Passwords do not match');
            });
      }
    }
  }

  void authenticateSellerAndSignUp() async {
    User? currentUser;

    await firebaseAuth
        .createUserWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    )
        .then((auth) {
      currentUser = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: error.message.toString(),
            );
          });
    });

    if (currentUser != null) {
      saveDataToFirestore(currentUser!).then((value) {
        Navigator.pop(context);
        //send user to homePage
        Route newRoute = MaterialPageRoute(builder: (c) => HomeScreen());
        Navigator.pushReplacement(context, newRoute);
      });
    }
  }

  Future saveDataToFirestore(User currentUser) async {
    FirebaseFirestore.instance.collection("sellers").doc(currentUser.uid).set({
      "sellerUID": currentUser.uid,
      "sellerEmail": currentUser.email,
      "sellerName": nameController.text.trim(),
      "sellerAvatarUrl": sellerImageUrl,
      "phone": phoneNumberController.text.trim(),
      "status": "approved",
      "earnings": 0.0,
    });

    //save data locally
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString("uid", currentUser.uid);
    await sharedPreferences!.setString("email", currentUser.email.toString());
    await sharedPreferences!.setString("name", nameController.text.trim());
    await sharedPreferences!.setString("photoUrl", sellerImageUrl);
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
                  onTap: () {
                    registerFormValidation();
                  },
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
