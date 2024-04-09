import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:part_time/cubit/job/states.dart';
import 'package:part_time/cubit/settings/cubit.dart';
import 'package:part_time/cubit/user/cubit.dart';
import 'package:part_time/models/company/company_model.dart';
import 'package:part_time/models/job/job_model.dart';
import 'package:part_time/network/database.dart';
import 'package:part_time/shared/components/components.dart';

class JobCubit extends Cubit<JobStates> {
  JobCubit() : super(JobInitialState());

  static JobCubit get(context) => BlocProvider.of(context);

  List<Job> myJobs = [];

  TextEditingController JobCategoryController = TextEditingController();
  TextEditingController JobTitleController = TextEditingController();
  TextEditingController JobDescriptionController = TextEditingController();
  TextEditingController JobAgeFromController = TextEditingController();
  TextEditingController JobAgeToController = TextEditingController();
  TextEditingController JobRequirementsController = TextEditingController();
  TextEditingController JobApplyLinkController = TextEditingController();
  DateTime? picked;
  TextEditingController JobDeadlineController =
      TextEditingController(text: 'Deadline Date');

  void pickDateDialog(context) async {
    picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(
          Duration(days: 0),
        ),
        lastDate: DateTime(2100));
    if (picked != null) {
      JobDeadlineController.text =
          '${picked!.year} - ${picked!.month} - ${picked!.day}';
    }
    emit(PickDeadlineState());
  }

  void ClearControllers() {
    JobTitleController = TextEditingController();
    JobDescriptionController = TextEditingController();
    JobAgeFromController = TextEditingController();
    JobAgeToController = TextEditingController();
    JobRequirementsController = TextEditingController();
    JobApplyLinkController = TextEditingController();
    emit(JobInitialState());
  }

  Future PostJob(context) async {
    emit(PostJobOnProgressState());

    if (int.tryParse(JobAgeFromController.text) == null) {
      myToast(
        msg: SettingsCubit.get(context).currentLanguage["ageInvalid"],
        backgroundColor: Colors.redAccent,
      );
      return;
    }
    if (int.tryParse(JobAgeToController.text) == null) {
      myToast(
        msg: SettingsCubit.get(context).currentLanguage["ageInvalid"],
        backgroundColor: Colors.redAccent,
      );
      return;
    }
    dynamic response = await NetworkDatabase.PostJob(
        context: context,
        title: JobTitleController.text,
        location: UserCubit.get(context).myUserFullData.location,
        description: JobDescriptionController.text,
        requirements: JobRequirementsController.text,
        applyLink: JobApplyLinkController.text,
        companyId: UserCubit.get(context).myUser.id,
        ageFrom: JobAgeFromController.text,
        ageTo: JobAgeToController.text);
    if (response.statusCode == 200) {
      myJobs.add(Job.FromJson(json.decode(response.body), UserCubit.get(context).myUserFullData));
      myToast(
        msg: SettingsCubit.get(context).currentLanguage["jobPublished"],
        backgroundColor: Colors.green,
      );
      // Add it to your list
    } else {
      myToast(
        msg: SettingsCubit.get(context).currentLanguage["unknownError"],
        backgroundColor: Colors.green,
      );
    }
    emit(PostJobFinishedState());
  }

  Future GetMyJobs(context) async {
    emit(GetMyJobsOnProgressState());
    myJobs.clear();
    var result = await NetworkDatabase.GetMyJobs(context: context);
    List<dynamic> jobsJson = result["_embedded"]["jobs"] as List<dynamic>;
    for (int i = 0; i < jobsJson.length; i++) {
      dynamic element = jobsJson[i];
      await GetJobCompanyData(context, element["id"]).then((value) {
        myJobs.add(Job.FromJson(element, value));
      });
    }
    emit(GetMyJobsFinishedState());
  }

  Future GetAllJobs(context) async {
    emit(GetAllJobsOnProgressState());
    myJobs.clear();
    var result = await NetworkDatabase.GetAllJobs(context: context);
    List<dynamic> jobsJson = result["_embedded"]["jobs"] as List<dynamic>;
    for (int i = 0; i < jobsJson.length; i++) {
      dynamic element = jobsJson[i];
      await GetJobCompanyData(context, element["id"]).then((value) {
        myJobs.add(Job.FromJson(element, value));
      });
    }
    emit(GetAllJobsFinishedState());
  }

  Future GetJobCompanyData(context, jobID) async {
    var result =
        await NetworkDatabase.GetJobCompany(context: context, id: jobID);

    return Company.FromJson(result);
  }

  Future UpdateJob(context, index) async {
    emit(UpdateJobOnProgressState());
    if (JobTitleController.text.isEmpty) {
      JobTitleController = TextEditingController(text: myJobs[index].title);
    }
    if (JobDescriptionController.text.isEmpty) {
      JobDescriptionController =
          TextEditingController(text: myJobs[index].description);
    }
    if (JobAgeFromController.text.isEmpty) {
      JobAgeFromController =
          TextEditingController(text: myJobs[index].ageFrom.toString());
    }
    if (JobAgeToController.text.isEmpty) {
      JobAgeToController =
          TextEditingController(text: myJobs[index].ageTo.toString());
    }
    if (JobRequirementsController.text.isEmpty) {
      JobRequirementsController =
          TextEditingController(text: myJobs[index].requirements);
    }
    if (JobApplyLinkController.text.isEmpty) {
      JobApplyLinkController =
          TextEditingController(text: myJobs[index].applyLink);
    }
    if (int.tryParse(JobAgeFromController.text) == null) {
      myToast(
        msg: SettingsCubit.get(context).currentLanguage["ageInvalid"],
        backgroundColor: Colors.redAccent,
      );
      return;
    }
    if (int.tryParse(JobAgeToController.text) == null) {
      myToast(
        msg: SettingsCubit.get(context).currentLanguage["ageInvalid"],
        backgroundColor: Colors.redAccent,
      );
      return;
    }

    dynamic statusCode = await NetworkDatabase.UpdateJob(
        jobId: myJobs[index].id,
        context: context,
        title: JobTitleController.text,
        location: myJobs[index].location,
        description: JobDescriptionController.text,
        requirements: JobRequirementsController.text,
        applyLink: JobApplyLinkController.text,
        ageFrom: JobAgeFromController.text,
        ageTo: JobAgeToController.text);

    if (statusCode == 200 || statusCode == 204) {
      myJobs[index].title = JobTitleController.text;
      myJobs[index].description = JobDescriptionController.text;
      myJobs[index].requirements = JobRequirementsController.text;
      myJobs[index].applyLink = JobApplyLinkController.text;
      myJobs[index].ageFrom = int.parse(JobAgeFromController.text);
      myJobs[index].ageTo = int.parse(JobAgeToController.text);

      myToast(
        msg: SettingsCubit.get(context).currentLanguage["jobUpdated"],
        backgroundColor: Colors.green,
      );
      emit(UpdateJobFinishedState());
      Navigator.pop(context);
    } else {
      myToast(
        msg: SettingsCubit.get(context).currentLanguage["unknownError"],
        backgroundColor: Colors.redAccent,
      );
      emit(UpdateJobFinishedState());
    }
  }

  Future DeleteJob(context, jobId, jobIndex) async {
    emit(DeleteJobOnProgressState());
    dynamic statusCode =
        await NetworkDatabase.DeleteJob(jobId: jobId, context: context);
    if (statusCode == 200 || statusCode == 204) {
      myToast(
        msg: SettingsCubit.get(context).currentLanguage["jobDeleted"],
        backgroundColor: Colors.green,
      );
      Navigator.pop(context);
      myJobs.removeAt(jobIndex);
    } else {
      myToast(
        msg: SettingsCubit.get(context).currentLanguage["unknownError"],
        backgroundColor: Colors.redAccent,
      );
    }
    emit(DeleteJobFinishedState());
  }
}
