import 'package:flutter/material.dart';
import 'package:part_time/shared/styles/colors.dart';

class ArchivedScreen extends StatelessWidget {
  const ArchivedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backGround,
      body: Center(
        child: Text("Archived Screen"),
      ),

    );
  }
}
