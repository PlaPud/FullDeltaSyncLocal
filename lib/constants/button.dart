import 'package:flutter/material.dart';

final ButtonStyle buttonStyleCustom = ElevatedButton.styleFrom(
    minimumSize: const Size(100, 38),
    elevation: 0,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50))));
