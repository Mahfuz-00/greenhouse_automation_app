import 'package:flutter/material.dart';

class ImageHelper {
  static Widget loadProfilePicture(String? path) {
    return path != null
        ? Image.network(path, width: 100, height: 100, fit: BoxFit.cover)
        : const Icon(Icons.person, size: 100);
  }
}