import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:part_time/cubit/settings/cubit.dart';
import 'package:part_time/cubit/settings/states.dart';
import 'package:part_time/shared/preferences/cache_helper.dart';
import 'package:part_time/shared/styles/colors.dart';
import 'package:part_time/ui/welcome/welcome_screen.dart';

class StartLanguageScreen extends StatelessWidget {
  const StartLanguageScreen({super.key});

  void submit(context, value){
    CacheHelper.saveData(key: "language", value: value).then((value){
      if(value){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const WelcomeScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsStates>(
        builder: (context, state) => Scaffold(
              backgroundColor: AppColors.backGround,
              appBar: AppBar(
                backgroundColor: AppColors.backGround,
              ),
              body: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        SettingsCubit.get(context).currentLanguage["selectYourLanguage"],
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20,),
                      Align(
                        alignment: AlignmentDirectional.center,
                        child: SegmentedButton(
                          segments: <ButtonSegment<String>>[
                            ButtonSegment(
                                value: "ar",
                                label: Text(SettingsCubit.get(context)
                                    .currentLanguage["arabic"])),
                            ButtonSegment(
                                value: "en",
                                label: Text(SettingsCubit.get(context)
                                    .currentLanguage["english"])),
                          ],
                          selected: SettingsCubit.get(context).selected,
                          onSelectionChanged: (value) {
                            SettingsCubit.get(context)
                                .ChangeCurrentLanguage(value);
                          },
                        ),
                      ),
                      const SizedBox(height: 20,),
                      ElevatedButton(
                        onPressed: () {
                          submit(context, SettingsCubit.get(context).selected.first);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.AppBarBackGround,
                        ),
                        child: Text(
                          SettingsCubit.get(context).currentLanguage["letsStart"],
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
