import 'package:flutter/material.dart';

Widget buildLoading(BuildContext context) {
  return const Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
    ),
  );
}
