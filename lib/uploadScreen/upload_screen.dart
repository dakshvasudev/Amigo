import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: library_prefixes
import 'package:firebase_storage/firebase_storage.dart' as storageRef;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:selller_amigo_app/constants.dart';
import 'package:selller_amigo_app/mainScreens/home_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:selller_amigo_app/widgets/customTextField.dart';
import 'package:selller_amigo_app/widgets/error_dialog.dart';
import 'package:selller_amigo_app/widgets/progress_bar.dart';

class MenuUploadScreen extends StatefulWidget {
  const MenuUploadScreen({Key? key}) : super(key: key);

  @override
  State<MenuUploadScreen> createState() => _MenuUploadScreenState();
}

class _MenuUploadScreenState extends State<MenuUploadScreen> {
  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();

  TextEditingController shortInfoController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  bool uploading = false;
  String uniqueIdName = DateTime.now().millisecondsSinceEpoch.toString();
  defaultScreen() {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: kColorYellow,
      //   scrolledUnderElevation: 15,
      //   shadowColor: kColorYellow,
      //   shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.vertical(
      //       bottom: Radius.circular(20),
      //     ),
      //   ),
      //   title: Center(
      //     child: Text(
      //       'Add Menu',
      //       style: GoogleFonts.workSans(
      //         textStyle: TextStyle(
      //           fontWeight: FontWeight.w700,
      //           fontSize: 26,
      //           color: kColorRed,
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned(
              top: 50,
              child: Container(
                height: 59,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: kColorGreen,
                  border: Border.all(color: kColorGreen),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        )),
                    const SizedBox(
                      width: 50,
                    ),
                    Center(
                      child: Text(
                        'Add Menu',
                        style: GoogleFonts.lemon(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Positioned(
              top: 260,
              left: 125,
              right: 125,
              child: Icon(
                Icons.menu_book,
                size: 120,
                color: Colors.grey,
              ),
            ),
            Positioned(
              top: 400,
              left: 120,
              right: 110,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(kColorGreen),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: kColorGreen)),
                    ),
                  ),
                  onPressed: () {
                    takeImage(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 9, 24, 9),
                    child: Text(
                      'Add',
                      style: GoogleFonts.lemon(
                          fontWeight: FontWeight.w400, fontSize: 21),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  takeImage(mContext) {
    return showDialog(
        context: mContext,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Menu Image'),
            children: [
              SimpleDialogOption(
                onPressed: captureImageWithCamera,
                child: const Text('Capture with camera'),
              ),
              SimpleDialogOption(
                onPressed: pickImageFromGallery,
                child: const Text('Select from gallery'),
              ),
              SimpleDialogOption(
                child: const Text('Cancel'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  captureImageWithCamera() async {
    Navigator.pop(context);
    imageXFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 720,
      maxWidth: 1200,
    );
    setState(() {
      imageXFile;
    });
  }

  pickImageFromGallery() async {
    Navigator.pop(context);
    imageXFile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 720,
      maxWidth: 1200,
    );
    setState(() {
      imageXFile;
    });
  }

  menusUploadFormScreen() {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        flexibleSpace: Container(
          color: kColorGreen,
        ),
        title: const Text(
          "Uploading New Menu",
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (c) => const HomeScreen()));
          },
        ),
        actions: [
          TextButton(
            onPressed: uploading ? null : () => validateUploadForm(),
            child: const Text(
              "Add",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 75 * 0.36, right: 85 * 0.36),
          child: Column(
            children: [
              uploading == true ? linearProgress() : const Text(""),
              SizedBox(
                height: 150,
                width: 150,
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(File(imageXFile!.path)),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextField(
                controller: titleController,
                leadingIcon: const Icon(Icons.perm_device_information),
                hintText: 'Menu Info',
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextField(
                controller: shortInfoController,
                leadingIcon: const Icon(Icons.title),
                hintText: 'Menu Title',
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  clearMenusUploadForm() {
    setState(() {
      shortInfoController.clear();
      titleController.clear();
      imageXFile = null;
    });
  }

  validateUploadForm() async {
    if (imageXFile != null) {
      if (shortInfoController.text.isNotEmpty &&
          titleController.text.isNotEmpty) {
        setState(() {
          uploading = true;
        });

        //upload image
        String downloadUrl = await uploadImage(File(imageXFile!.path));

        //save info to firestore
        saveInfo(downloadUrl);
      } else {
        showDialog(
            context: context,
            builder: (c) {
              return ErrorDialog(
                message: "Please write title and info for menu.",
              );
            });
      }
    } else {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorDialog(
              message: "Please pick an image for menu.",
            );
          });
    }
  }

  saveInfo(String downloadUrl) {
    final ref = FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("menus");

    ref.doc(uniqueIdName).set({
      "menuID": uniqueIdName,
      "sellerUID": sharedPreferences!.getString("uid"),
      "menuInfo": shortInfoController.text.toString(),
      "menuTitle": titleController.text.toString(),
      "publishedDate": DateTime.now(),
      "status": "available",
      "thumbnailUrl": downloadUrl,
    });

    clearMenusUploadForm();

    setState(() {
      uniqueIdName = DateTime.now().millisecondsSinceEpoch.toString();
      uploading = false;
    });
  }

  uploadImage(mImageFile) async {
    storageRef.Reference reference =
        storageRef.FirebaseStorage.instance.ref().child("menus");

    storageRef.UploadTask uploadTask =
        reference.child(uniqueIdName + ".jpg").putFile(mImageFile);

    storageRef.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

    String downloadURL = await taskSnapshot.ref.getDownloadURL();

    return downloadURL;
  }

  @override
  Widget build(BuildContext context) {
    return imageXFile == null ? defaultScreen() : menusUploadFormScreen();
  }
}