import 'package:flutter/material.dart';
import 'package:part_time/Persistent/Presistent.dart';

import '../../Widgets/bootom_nav_bar_client.dart';
import '../../Widgets/bottom_nav_bar_for_company.dart';

class AddJobScreen extends StatefulWidget {
  const AddJobScreen({super.key});

  @override
  State<AddJobScreen> createState() => _AddJobScreenState();
}

class _AddJobScreenState extends State<AddJobScreen> {
  final _formkey = GlobalKey<FormState>();
  DateTime? picked;
  DateTime? deadlineDateTimeStamp;
  final bool _isLoading = false;


  final TextEditingController _JobCategoryController = TextEditingController(
      text: 'Select Job Category');
  final TextEditingController _JobTitleController = TextEditingController();
  final TextEditingController _JobDescriptionController = TextEditingController();
  final TextEditingController _JobDeadlineController = TextEditingController(
      text: 'Job Deadline Date');

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
    required int maxLength,
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
            maxLength: maxLength,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
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

  _showTaskCategoriesDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: Colors.black54,
          title: const Text(
            'Job Category',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          content: Container(
            width: MediaQuery
                .of(context)
                .size
                .width * .8,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: Persistent.jobCategoryList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      _JobCategoryController.text = Persistent
                          .jobCategoryList[index];
                    });
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.arrow_right_alt_outlined, color: Colors.grey,),
                      Padding(padding: EdgeInsets.all(8),
                        child: Text(Persistent.jobCategoryList[index],
                          style: TextStyle(color: Colors.grey, fontSize: 16),),
                      )
                    ],
                  ),
                );
              },),
          ),
        );
      },
    );
  }

  void _pickDateDialog() async {
    picked = await showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(
          Duration(days: 0),
        ),
        lastDate: DateTime(2100)
    );
    if(picked!=null){
      setState(() {
        _JobDeadlineController.text = '${picked!.year} - ${picked!.month} - ${picked!.day}';
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.blueAccent],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [.2, .9])),
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBarForComapny(indexNum: 2),
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
                      const Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            'Please fill all fields',
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
                        padding: const EdgeInsets.all(8),
                        child: Form(
                            key: _formkey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _textTitles(lable: 'Job Category :'),
                                _textFormFields(
                                  valueKey: 'JobCategory',
                                  controller: _JobCategoryController,
                                  enabled: false,
                                  fan: () {
                                    _showTaskCategoriesDialog();
                                  },
                                  maxLength: 100,
                                ),
                                _textTitles(lable: 'Job Title :'),
                                _textFormFields(
                                  valueKey: 'JobTitle',
                                  controller: _JobTitleController,
                                  enabled: true,
                                  fan: () {},
                                  maxLength: 100,
                                ),
                                _textTitles(lable: 'Job Description :'),
                                _textFormFields(
                                  valueKey: 'JobDescription',
                                  controller: _JobDescriptionController,
                                  enabled: true,
                                  fan: () {},
                                  maxLength: 100,
                                ),
                                _textTitles(lable: 'Job Deadline Date :'),
                                _textFormFields(
                                  valueKey: 'Deadline',
                                  controller: _JobDeadlineController,
                                  enabled: false,
                                  fan: () {
                                    _pickDateDialog();
                                  },
                                  maxLength: 100,
                                ),
                              ],
                            )),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: _isLoading
                              ? const CircularProgressIndicator()
                              : MaterialButton(
                            onPressed: () {},
                            color: Colors.black,
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13)),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 14),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Post Now',
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
        ));
  }
}
