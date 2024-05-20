import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pree/Api_call/apiCall.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pree/provider/loginuid.dart';
import 'package:provider/provider.dart';

class AddFood extends StatefulWidget {
  const AddFood({Key? key}) : super(key: key);

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
    final TextEditingController foodNameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  // late File _image;

  // Future<void> _uploadImage() async {
  //   final url = 'http://192.168.56.1/upload';
  //   final request = http.MultipartRequest('POST', Uri.parse(url))
  //     ..files.add(await http.MultipartFile('image', 
  //     _image.readAsBytes().asStream(),
  //     _image.lengthSync(),
  //     filename: 'image.jpg',
  //     // contentType:new MediaType('image', 'jpg'),
  //   ));

  //   final response = await http.Response.fromStream(await request.send());

  //   if (response.statusCode == 200) {
  //     print('Image uploaded successfully!');
  //     print(response.body);
  //   } else {
  //     print('Failed to upload image.');
  //   }
  // }

  // Future<void> _getImage(ImageSource source) async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: source);
  //   // .getImage(source: source);

  //   if (pickedFile != null) {
  //     setState(() {
  //       _image = File(pickedFile.path);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<loginuid>(
      builder: (context, val, child) => SizedBox(
          child: Scaffold(
      appBar: AppBar(title: const Text("Add Food")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: foodNameController,
              decoration: const InputDecoration(
                labelText: "Food Name :",
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: quantityController,
              decoration: const InputDecoration(
                labelText: "Quantity :",
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: locationController,
              decoration: const InputDecoration(
                labelText: "Location :",
              ),
            ),
            // SizedBox(height: 16.0),
            // ElevatedButton(
            //   onPressed: () async {
            //     _getImage(ImageSource.gallery);
            //   },
            //   // _getImageFromGallery,
            //   child: Text('Pick Image from Gallery'),
            // ),
            // SizedBox(height: 16.0),
            // ElevatedButton(
            //   onPressed: () async {
            //     // selectedImage = await _getImageFromCamera();
            //     _getImage(ImageSource.camera);
            //   },
            //   child: Text('Capture Image from Camera'),
            // ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async{
                // if (_image != null) {
                  // File file = File(_image.path);
                  // await _uploadImage();
                  // print('Download URL: $downloadURL');
                // }

                int flag =await apiCall.postFood(val.email,foodNameController.text,quantityController.text,val.User_Org,locationController.text);
                if(flag==1){
                  final snackBar = SnackBar(
            content: Text('Food added Successfully'),
            action: SnackBarAction(
              label: 'Close',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );

          // Find the ScaffoldMessenger in the widget tree
          // and show a SnackBar.
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                else{
                  final snackBar = SnackBar(
            // content: Text('This is a SnackBar'),
            content: Text('Error while adding food'),
            action: SnackBarAction(
              label: 'Close',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );

          // Find the ScaffoldMessenger in the widget tree
          // and show a SnackBar.
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: Text("Post"),
            ),
            
          ],
        ),
      ),
    )));
  }
}
