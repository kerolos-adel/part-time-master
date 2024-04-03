import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:part_time/Widgets/bottom_nav_bar.dart';
import 'package:part_time/Widgets/job_widget.dart';
import 'package:part_time/constants/values/values.dart';
import 'package:part_time/cubit/explore/cubit.dart';
import 'package:part_time/cubit/explore/states.dart';
import 'package:part_time/cubit/settings/cubit.dart';
import 'package:part_time/shared/components/components.dart';
import 'package:part_time/shared/styles/colors.dart';
import 'package:part_time/ui/job_details/job_details_screen.dart';

import '../../Persistent/Presistent.dart';
import '../search/search_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String? jobCategoryFilter;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreCubit, ExploreStates>(builder: (context, state) {
      return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.blueAccent],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [.2, .9])),
        child: Scaffold(
            bottomNavigationBar: BottomNavigationBarForApp(indexNum: 0),
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.deepPurple, Colors.blueAccent],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        stops: [.2, .9])),
              ),
              title: const Text(
                "Jobs Screen",
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              leading: IconButton(
                  onPressed: () {
                    _showTaskCategoriesDialog(context);
                  },
                  icon: const Icon(
                    Icons.filter_list_rounded,
                    color: Colors.black,
                  )),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchScreen(),
                          ));
                    },
                    icon: const Icon(
                      Icons.search_outlined,
                      color: Colors.black,
                    ))
              ],
            ),
            backgroundColor: Colors.transparent,
            body: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return const JobWidget(
                  jobTitle: "jobTitle",
                  jobDescription: "jobDescription",
                  jobId: "1",
                  uploadedBy: "kerolosa adel",
                  userImage: "https://wallpaperaccess.com/full/643379.jpg",
                  name: "kerolos",
                  recruitment: "recruitment",
                  email: "kerolos@gmail.com",
                  location: "asyut",
                );
              },
            )),
      );
    });
  }

  _showTaskCategoriesDialog(context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: Colors.black54,
          title: Text(
            'Job Category',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          content: Container(
            width: MediaQuery.of(context).size.width * .8,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: Persistent.jobCategoryList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      jobCategoryFilter = Persistent.jobCategoryList[index];
                    });
                    Navigator.canPop(context) ? Navigator.pop(context) : null;
                    print(
                        'jobCategoryList[index],${Persistent.jobCategoryList[index]}');
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_right_alt_outlined,
                        color: Colors.grey,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          Persistent.jobCategoryList[index],
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                child: Text(
                  'Close',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )),
            TextButton(
                onPressed: () {
                  setState(() {
                    jobCategoryFilter = null;
                  });
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                child: Text(
                  'Cancel Filter',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )),
          ],
        );
      },
    );
  }
}
