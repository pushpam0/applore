import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_demo/home/model/item_data_collect.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  bool loader = false;
  var image;
  File? file;
  File? filet;
  TextEditingController productEditingController = TextEditingController();
  TextEditingController priceEditingController = TextEditingController();
  TextEditingController discreptionEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: ListBody(
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          InkWell(
                              onTap: () {
                                _showChoiceDialogUpload(context);
                              },
                              child: file == null
                                  ? CircleAvatar(
                                      minRadius: 50, child: Icon(Icons.add))
                                  : Container(
                                      width: 100,
                                      height: 100,
                                      child: Image.file(
                                        file!,
                                        fit: BoxFit.scaleDown,
                                      ),
                                    )),
                          FittedBox(
                              child: filet == null
                                  ? const Text("original:")
                                  : Text(
                                      "original: ${filet!.lengthSync() / 1024} kb")),
                        ],
                      ),
                      Column(
                        children: [
                          Text("--->"),
                          Text(""),
                        ],
                      ),
                      Column(
                        children: [
                          file == null
                              ? CircleAvatar(
                                  minRadius: 50, child: Icon(Icons.add))
                              : Container(
                                  width: 100,
                                  height: 100,
                                  child: Image.file(
                                    file!,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                          FittedBox(
                              child: filet == null
                                  ? const Text("Compressed:")
                                  : Text(
                                      "Compressed: ${file!.lengthSync() / 1024} kb")),
                        ],
                      ),
                    ],
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  title: TextField(
                    controller: productEditingController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Product Name',
                      hintText: 'Enter Product name',
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {},
                  title: TextField(
                    controller: priceEditingController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'price',
                      hintText: 'Enter price',
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {},
                  title: Container(
                    // margin: EdgeInsets.all(12),
                    height: 5 * 24.0,
                    width: 6 * 24.0,
                    child: TextField(
                      controller: discreptionEditingController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Description',
                        hintText: 'Enter Description',
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(50, 10, 50, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      /* getEmergencyDetailsData(dataObject: DataObject(actionCode: "add",clientId: centralState.login.clientId.toString(),empId: centralState.login.empId,taskId: "112",userId: centralState.login.userId.toString(),firstName:firstnameController.text,lastName:  lastNameController.text,phoneNo: mobileNumberController.text,relation: _dropDownValue,city: cityController.text,state: stateController.text,)).then((value) {
                              Navigator.pop(context);
                            });*/
                      /*  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  EducationDetails()),
                    );*/

                      CollectUserItemData()
                          .productRequiedData(
                              disc: discreptionEditingController.text,
                              price: priceEditingController.text,
                              product: productEditingController.text,
                              url: file!)
                          .then((value) {
                        setState(() {
                          loader = false;
                          //  Navigator.pop(context);
                        });
                      });
                      setState(() {
                        loader = true;
                      });
                    },
                    child: loader == false
                        ? Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text("Save"),
                          )
                        : CircularProgressIndicator(color: Colors.white),
                    style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(50, 10, 50, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      /*  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  EducationDetails()),
                    );*/
                      // Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("Cancel"),
                    ),
                    style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showChoiceDialogUpload(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Upload From:",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      getFromGallery(context);
                      Navigator.pop(context);
                    },
                    title: Text("Gallery"),
                    leading: Icon(
                      Icons.account_box,
                      color: Colors.blue,
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      getFromCamera(context);
                    },
                    title: Text("Camera"),
                    leading: Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<File> customeCompressed(
      {required File imagePathToCompressed,
      quality = 100,
      percentage = 10}) async {
    var path = await FlutterNativeImage.compressImage(
        imagePathToCompressed.absolute.path,
        quality: 100,
        percentage: 10);
    return path;
  }

  Future getFromGallery(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      filet = File("${result.files.single.path}");
      print("before Compressed : ${filet!.lengthSync() / 1024}");
      final sizeInKb = await customeCompressed(
          imagePathToCompressed: File("${result.files.single.path}"));
      print("after Compressed : ${sizeInKb.lengthSync() / 1024}");

      setState(() {
        file = sizeInKb;
      });
    } else {
      // User canceled the picker
    }
  }

  ImagePicker imagePicker = ImagePicker();
  Future getFromCamera(BuildContext context) async {
    image = await imagePicker.pickImage(source: ImageSource.camera);
    filet = File("${image.files.single.path}");
    print("before Compressed : ${filet!.lengthSync() / 1024}");
    final sizeInKb = await customeCompressed(
        imagePathToCompressed: File("${image.files.single.path}"));
    print("after Compressed : ${sizeInKb.lengthSync() / 1024}");

    setState(() {
      file = sizeInKb;
    });
  }
}
