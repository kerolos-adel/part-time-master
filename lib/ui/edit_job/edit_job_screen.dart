import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:part_time/Widgets/bottom_nav_bar_for_company.dart';
import 'package:part_time/cubit/job/cubit.dart';
import 'package:part_time/cubit/job/states.dart';
import 'package:part_time/cubit/settings/cubit.dart';

class EditJobScreen extends StatefulWidget {
  int? index;
  EditJobScreen({this.index});

  @override
  State<EditJobScreen> createState() => _EditJobScreenState();
}

class _EditJobScreenState extends State<EditJobScreen> {
  final _formkey = GlobalKey<FormState>();
  DateTime? picked;
  DateTime? deadlineDateTimeStamp;

  Widget _textTitles({required String lable}) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Text(
        lable,
        style: const TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _textFormFields({
    required String valueKey,
    required TextEditingController controller,
    required bool enabled,
    required Function fan,
    String? hint,
  }) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: InkWell(
          onTap: () {
            fan();
          },
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return 'Value is missing';
              }
              return null;
            },
            controller: controller,
            enabled: enabled,
            key: ValueKey(valueKey),
            style: const TextStyle(color: Colors.white),
            maxLines: valueKey == 'JobDescription' ? 3 : 1,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
              filled: true,
              fillColor: Colors.black54,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobCubit, JobStates>(
        builder: (context, state){
          return Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.deepPurple, Colors.blueAccent],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      stops: [.2, .9])),
              child: Scaffold(
                bottomNavigationBar: BottomNavigationBarForComapny(indexNum: 1),
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  flexibleSpace: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.deepPurple, Colors.blueAccent],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            stops: [.2, .9])),
                  ),
                ),
                body: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(7),
                    child: Card(
                      color: Colors.white10,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  SettingsCubit.get(context).currentLanguage["editJobData"],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Signatra'),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              thickness: 1,
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Form(
                                  key: _formkey,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _textTitles(lable: SettingsCubit.get(context).currentLanguage["jobTitle"]),
                                      _textFormFields(
                                        valueKey: 'JobTitle',
                                        controller: JobCubit.get(context).JobTitleController,
                                        enabled: true,
                                        fan: () {},
                                      ),
                                      _textTitles(lable: SettingsCubit.get(context).currentLanguage["averageAge"]),
                                      _textFormFields(
                                        valueKey: 'Age',
                                        controller: JobCubit.get(context).JobAgeFromController,
                                        hint: SettingsCubit.get(context).currentLanguage["from"],
                                        enabled: true,
                                        fan: () {},
                                      ),
                                      _textFormFields(
                                        valueKey: 'Age',
                                        controller: JobCubit.get(context).JobAgeToController,
                                        hint: SettingsCubit.get(context).currentLanguage["to"],
                                        enabled: true,
                                        fan: () {},
                                      ),
                                      _textTitles(lable: SettingsCubit.get(context).currentLanguage["jobDescription"]),
                                      _textFormFields(
                                        valueKey: 'JobDescription',
                                        controller: JobCubit.get(context).JobDescriptionController,
                                        enabled: true,
                                        fan: () {},
                                      ),
                                      _textTitles(lable: SettingsCubit.get(context).currentLanguage["requirements"]),
                                      _textFormFields(
                                        valueKey: 'Requirements',
                                        controller: JobCubit.get(context).JobRequirementsController,
                                        enabled: true,
                                        fan: () {},
                                      ),
                                      _textTitles(lable: SettingsCubit.get(context).currentLanguage["applyLink"]),
                                      _textFormFields(
                                        valueKey: 'Apply Link',
                                        controller: JobCubit.get(context).JobApplyLinkController,
                                        enabled: true,
                                        fan: () {},
                                      ),
                                      Text(SettingsCubit.get(context).currentLanguage["applyLinkWarning"]),
                                    ],
                                  )),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 30),
                                child: state is PostJobOnProgressState
                                    ? CircularProgressIndicator()
                                    : MaterialButton(
                                  onPressed: () async {
                                    await JobCubit.get(context).UpdateJob(context, widget.index);
                                  },
                                  color: Colors.black,
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13)),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 14),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          SettingsCubit.get(context).currentLanguage["save"],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25,
                                              fontFamily: 'Signatra'),
                                        ),
                                        SizedBox(
                                          width: 9,
                                        ),
                                        Icon(
                                          Icons.upload_file,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
          );
        }
    );

  }
}
