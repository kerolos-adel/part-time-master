import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:part_time/models/job/job_model.dart';

Widget ExploreJobsItemBuilder(Job job){
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            job.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          Text("${job.companyName}, ${job.location}", style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),),
          Row(
            children: [
              Text("2 days ago"),
              Spacer(),
            ],
          ),
        ],
      ),
    ),
  );
}

Future myToast({
  String msg = "",
  Color backgroundColor = Colors.red,
  int timeInSec = 4,
}){
  return Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: backgroundColor,
    timeInSecForIosWeb: timeInSec,
    fontSize: 16,
  );
}