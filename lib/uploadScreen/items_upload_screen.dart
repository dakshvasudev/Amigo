import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as storageRef;
import 'package:selller_amigo_app/constants.dart';
import 'package:selller_amigo_app/mainScreens/home_screen.dart';
import 'package:selller_amigo_app/model/menus.dart';
import 'package:selller_amigo_app/widgets/customTextField.dart';
import 'package:selller_amigo_app/widgets/error_dialog.dart';
import 'package:selller_amigo_app/widgets/progress_bar.dart';

class ItemsUploadScreen extends StatefulWidget {
  final Menus? model;
  const ItemsUploadScreen({super.key, this.model});

  @override
  _ItemsUploadScreenState createState() => _ItemsUploadScreenState();
}

class _ItemsUploadScreenState extends State<ItemsUploadScreen> {
  XFile? imageXFile;
  final ImagePicker _picker = ImagePicker();

  TextEditingController shortInfoController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  bool uploading = false;
  String uniqueIdName = DateTime.now().millisecondsSinceEpoch.toString();

  defaultScreen() {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: kColorGreen),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                const EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  'Add to cart',
                  style: GoogleFonts.lobster(
                      color: kColorGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 36),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              const Icon(
                Icons.shop_two,
                color: Colors.grey,
                size: 200.0,
              ),
              const SizedBox(
                height: 35,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(kColorGreen),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                onPressed: () {
                  takeImage(context);
                },
                child: const SizedBox(
                  height: 54,
                  width: 200,
                  child: Center(
                    child:  Text(
                      "Add New Item",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  takeImage(mContext) {
    return showDialog(
      context: mContext,
      builder: (context) {
        return SimpleDialog(
          title: const Text(
            "Menu Image",
            style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
          ),
          children: [
            SimpleDialogOption(
              onPressed: captureImageWithCamera,
              child: const Text(
                "Capture with Camera",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SimpleDialogOption(
              onPressed: pickImageFromGallery,
              child: const Text(
                "Select from Gallery",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SimpleDialogOption(
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  captureImageWithCamera() async {
    Navigator.pop(context);

    imageXFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 720,
      maxWidth: 1280,
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
      maxWidth: 1280,
    );

    setState(() {
      imageXFile;
    });
  }

  itemsUploadFormScreen() {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        flexibleSpace: Container(
          color: kColorGreen,
        ),
        title: const Text(
          "Uploading New Item",
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
            clearMenusUploadForm();
          },
        ),
        actions: [
          TextButton(
            onPressed: uploading ? null : () => validateUploadForm(),
            child: const Text(
              "Add",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
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
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
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
              CustomTextField(
                controller: shortInfoController,
                leadingIcon: const Icon(Icons.perm_device_information),
                hintText: 'Info',
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextField(
                controller: titleController,
                hintText: 'Title',
                leadingIcon: const Icon(Icons.title),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextField(
                controller: descriptionController,
                leadingIcon: const Icon(Icons.description),
                hintText: 'Description',
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextField(
                keyboardType: TextInputType.number,
                controller: priceController,
                hintText: 'Price',
                leadingIcon: const Icon(Icons.currency_rupee),
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
      priceController.clear();
      descriptionController.clear();

      imageXFile = null;
    });
  }

  validateUploadForm() async {
    if (imageXFile != null) {
      if (shortInfoController.text.isNotEmpty &&
          titleController.text.isNotEmpty &&
          descriptionController.text.isNotEmpty &&
          priceController.text.isNotEmpty) {
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
        .collection("menus")
        .doc(widget.model!.menuID)
        .collection("items");

    ref.doc(uniqueIdName).set({
      "itemID": uniqueIdName,
      "menuID": widget.model!.menuID,
      "sellerUID": sharedPreferences!.getString("uid"),
      "sellerName": sharedPreferences!.getString("name"),
      "shortInfo": shortInfoController.text.toString(),
      "longDescription": descriptionController.text.toString(),
      "price": int.parse(priceController.text),
      "title": titleController.text.toString(),
      "publishedDate": DateTime.now(),
      "status": "available",
      "thumbnailUrl": downloadUrl,
    }).then((value) {
      final itemsRef = FirebaseFirestore.instance.collection("items");

      itemsRef.doc(uniqueIdName).set({
        "itemID": uniqueIdName,
        "menuID": widget.model!.menuID,
        "sellerUID": sharedPreferences!.getString("uid"),
        "sellerName": sharedPreferences!.getString("name"),
        "shortInfo": shortInfoController.text.toString(),
        "longDescription": descriptionController.text.toString(),
        "price": int.parse(priceController.text),
        "title": titleController.text.toString(),
        "publishedDate": DateTime.now(),
        "status": "available",
        "thumbnailUrl": downloadUrl,
      });
    }).then((value) {
      clearMenusUploadForm();

      setState(() {
        uniqueIdName = DateTime.now().millisecondsSinceEpoch.toString();
        uploading = false;
      });
    });
  }

  uploadImage(mImageFile) async {
    storageRef.Reference reference =
        storageRef.FirebaseStorage.instance.ref().child("items");

    storageRef.UploadTask uploadTask =
        reference.child(uniqueIdName + ".jpg").putFile(mImageFile);

    storageRef.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

    String downloadURL = await taskSnapshot.ref.getDownloadURL();

    return downloadURL;
  }

  @override
  Widget build(BuildContext context) {
    return imageXFile == null ? defaultScreen() : itemsUploadFormScreen();
  }
}
