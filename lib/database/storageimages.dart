import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class Uploadimage {
  getimage() async {
    var imagepicker = ImagePicker();
    XFile? imagepicked =
        await imagepicker.pickImage(source: ImageSource.gallery);
    if (imagepicked != null) {
      return imagepicked;
    } else
      return null;
  }

  Future<dynamic> uploadimage(XFile imagepicked, String folder) async {
    File file;
    file = File(imagepicked.path);
    var nameimage = basename(imagepicked.path);
    var rand = Random().nextInt(10000000);
    var refstorage =
        await FirebaseStorage.instance.ref('$folder/$rand$nameimage');
    await refstorage.putFile(file);
    var url = await refstorage.getDownloadURL();
    return url;
  }

  DeleteImage(String url) async {
    Reference storageref = await FirebaseStorage.instance.refFromURL(url);
    await storageref.delete();
  }
}
