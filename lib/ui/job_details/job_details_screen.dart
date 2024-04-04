import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:part_time/cubit/job/cubit.dart';
import 'package:part_time/cubit/job/states.dart';
import 'package:part_time/cubit/settings/cubit.dart';
import 'package:part_time/cubit/settings/states.dart';

class JobDetailsScreen extends StatefulWidget {
  int? index;
  JobDetailsScreen({this.index});
  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  Widget dividerWidget() {
    return const Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Divider(
          thickness: 1,
          color: Colors.grey,
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobCubit, JobStates>(
      builder: (context, state){
        return Container(
          decoration:  BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.blueAccent],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [.2, .9])),
          child:
          BlocBuilder<SettingsCubit, SettingsStates>(builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                flexibleSpace: Container(
                  decoration:  BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.deepPurple, Colors.blueAccent],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: [.2, .9])),
                ),
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon:  Icon(
                      Icons.close,
                      size: 40,
                      color: Colors.white,
                    )),
              ),
              body: SingleChildScrollView(
                physics:  BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:  EdgeInsets.all(4.0),
                      child: Card(
                        color: Colors.black54,
                        child: Padding(
                          padding:  EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(left: 4.0),
                                child: Text(
                                  JobCubit.get(context).myJobs[widget.index!].title,
                                  style:  TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 3,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      border:
                                      Border.all(width: 3, color: Colors.grey),
                                      shape: BoxShape.rectangle,
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            "https://cdn1.iconfinder.com/data/icons/mix-color-3/502/Untitled-7-1024.png"),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          JobCubit.get(context).myJobs[widget.index!].companyName,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          JobCubit.get(context).myJobs[widget.index!].location,
                                          style: TextStyle(color: Colors.grey),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              dividerWidget(),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Text(
                                    SettingsCubit.get(context).currentLanguage["averageAge"],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "${JobCubit.get(context).myJobs[widget.index!].ageFrom} ~ ${JobCubit.get(context).myJobs[widget.index!].ageTo}",
                                    style: TextStyle(color: Colors.grey),
                                  ),

                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  dividerWidget(),
                                  Text(
                                    SettingsCubit.get(context).currentLanguage["requirements"],
                                    style:  TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    JobCubit.get(context).myJobs[widget.index!].requirements,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  )
                                ],
                              ),
                              dividerWidget(),
                              Text(
                                SettingsCubit.get(context).currentLanguage["description"],
                                style:  TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                JobCubit.get(context).myJobs[widget.index!].description,
                                textAlign: TextAlign.justify,
                                style:  TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              dividerWidget(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4),
                      child: Card(
                        color: Colors.black54,
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  SettingsCubit.get(context).currentLanguage["sendCV"],
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Center(
                                child: MaterialButton(
                                  onPressed: () {},
                                  color: Colors.blueAccent,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13)),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 18, horizontal: 14),
                                    child: Text(
                                      SettingsCubit.get(context).currentLanguage["applyNow"],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                     SizedBox(
                      height: 30,
                    ),


                  ],
                ),
              ),
            );
          }),
        );
      }
    );

  }
}
