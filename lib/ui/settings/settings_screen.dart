import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:part_time/cubit/settings/cubit.dart';
import 'package:part_time/cubit/settings/states.dart';
import 'package:part_time/shared/preferences/cache_helper.dart';
import 'package:part_time/shared/styles/colors.dart';

import '../../Widgets/bottom_nav_bar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  void submit(context, value){
    CacheHelper.saveData(key: "language", value: value).then((value){
      if(value){
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsStates>(
        builder: (context, state){
          return Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.deepPurple,
                    Colors.blueAccent
                  ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      stops: [.2,.9]
                  )
              ),
              child:Scaffold(
                bottomNavigationBar: BottomNavigationBarForApp(indexNum:3),

                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  flexibleSpace: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Colors.deepPurple,
                          Colors.blueAccent
                        ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            stops: [.2,.9]
                        )
                    ),),

                  centerTitle: true,
                ),
                body:  Padding(
                    padding: const EdgeInsets.all(12),
                    child: SizedBox(
                      width: double.infinity,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              SettingsCubit.get(context).currentLanguage["language"],
                              style: const TextStyle(
                                fontSize: 25,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SegmentedButton(
                              segments: <ButtonSegment<String>>[
                                ButtonSegment(value: "ar", label: Text(SettingsCubit.get(context).currentLanguage["arabic"])),
                                ButtonSegment(value: "en", label: Text(SettingsCubit.get(context).currentLanguage["english"])),
                              ],
                              selected: SettingsCubit.get(context).selected,
                              onSelectionChanged: (value){
                                SettingsCubit.get(context).ChangeCurrentLanguage(value);
                              },
                            ),
                            const SizedBox(height: 50,),
                            ElevatedButton(
                              onPressed: (){
                                SettingsCubit.get(context).ChangeCurrentLanguage(SettingsCubit.get(context).selected);
                                submit(context, SettingsCubit.get(context).selected.first);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.AppBarBackGround,
                              ),
                              child: Text(
                                SettingsCubit.get(context).currentLanguage["save"],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

              ));



        }
    );
  }
}
