import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:part_time/Widgets/bootom_nav_bar_client.dart';
import 'package:part_time/Widgets/bottom_nav_bar_for_company.dart';
import 'package:part_time/Widgets/job_widget.dart';
import 'package:part_time/constants/values/values.dart';
import 'package:part_time/cubit/explore/cubit.dart';
import 'package:part_time/cubit/explore/states.dart';
import 'package:part_time/cubit/job/cubit.dart';
import 'package:part_time/cubit/job/states.dart';
import 'package:part_time/cubit/settings/cubit.dart';
import 'package:part_time/models/job/job_model.dart';
import 'package:part_time/shared/components/components.dart';
import 'package:part_time/shared/styles/colors.dart';
import 'package:part_time/ui/job_details/job_details_screen.dart';

import '../../Persistent/Presistent.dart';
import '../search/search_client_screen.dart';

class ExploreCompanyScreen extends StatefulWidget {
  const ExploreCompanyScreen({super.key});

  @override
  State<ExploreCompanyScreen> createState() => _ExploreCompanyScreenState();
}

class _ExploreCompanyScreenState extends State<ExploreCompanyScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobCubit, JobStates>(
        builder: (context, state) {
          return Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.deepPurple,
                  Colors.blueAccent
                ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [.2, .9]
                )
            ),
            child: Scaffold(
                bottomNavigationBar: BottomNavigationBarForComapny(indexNum: 0),
                appBar: AppBar(
                  flexibleSpace: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Colors.deepPurple,
                          Colors.blueAccent
                        ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            stops: [.2, .9]
                        )
                    ),),
                  title: Text(
                   SettingsCubit.get(context).currentLanguage["myJobs"],
                    style: TextStyle(color: Colors.white),),
                  centerTitle: true,
                  actions: [
                    IconButton(
                        onPressed: () async {
                          await JobCubit.get(context).GetMyJobs(context);
                        }, icon: Icon(Icons.refresh)
                    )
                  ],
                ),
                backgroundColor: Colors.transparent,
                body: ListView.builder(
                  itemCount: JobCubit.get(context).myJobs.length,
                  itemBuilder: (context, index) {
                    return JobsListBuilder(index, JobCubit.get(context).myJobs[index]);
                  },)
            ),
          );
        }
    );
  }
  Widget JobsListBuilder(int index, Job job){
    return Card(
      color: Colors.white24,
      elevation: 8,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: ListTile(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            uploadedBy:job.companyName;
            return JobDetailsScreen(index: index);
          },));
        },

        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Container(
          padding: EdgeInsets.only(right: 12),
          decoration:
          BoxDecoration(border: Border(right: BorderSide(width: 1))),
          child: Image.network("https://wallpaperaccess.com/full/643379.jpg"),
        ),
        title: Text(
          job.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.amber,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              job.companyName,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
            SizedBox(height: 8,),
            Text(
              job.location,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ],
        ),
        trailing: Icon(Icons.keyboard_arrow_right,size: 30,color: Colors.black,),
      ),
    );
  }
}