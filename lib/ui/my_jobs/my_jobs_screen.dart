import 'package:flutter/material.dart';
import 'package:part_time/shared/styles/colors.dart';
import 'package:part_time/ui/add_job/add_job_screen.dart';

class MyJobsScreen extends StatelessWidget {
  const MyJobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      body: const Center(
        child: Text("My Jobs Screen"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddJobScreen()));
        },
        backgroundColor: AppColors.AppBarBackGround,
        splashColor: AppColors.backGround,
        child: const Icon(Icons.add),
      ),
    );
  }
}
