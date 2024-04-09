import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:part_time/cubit/layout/cubit.dart';
import 'package:part_time/cubit/layout/states.dart';
import 'package:part_time/cubit/settings/cubit.dart';
import 'package:part_time/cubit/settings/states.dart';
import 'package:part_time/ui/settings/settings_screen_for_client.dart';

class PersonLayoutScreen extends StatelessWidget {
  const PersonLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutStates>(
        builder: (context, state) => BlocBuilder<SettingsCubit, SettingsStates>(
              builder: (context, state) => Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  leading: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                  ),
                  title: Text("Username"),
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SettingsClientScreen()));
                        },
                        icon: const Icon(
                          Icons.settings,
                        )),
                  ],
                ),
                body: LayoutCubit.get(context)
                    .person_screens[LayoutCubit.get(context).currentIndex],
                bottomNavigationBar: BottomNavigationBar(
                  elevation: 20,
                  backgroundColor: Colors.white,
                  items: [
                    BottomNavigationBarItem(
                        icon: const Icon(Icons.explore,color: Colors.grey,),
                        label: SettingsCubit.get(context)
                            .currentLanguage["explore"]),
                    BottomNavigationBarItem(
                        icon: const Icon(Icons.save,color: Colors.grey),
                        label: SettingsCubit.get(context)
                            .currentLanguage["saved"]),
                  ],
                  currentIndex: LayoutCubit.get(context).currentIndex,
                  onTap: (index) {
                    LayoutCubit.get(context).ChangeCurrentIndex(index);
                  },
                  selectedItemColor: Colors.black87,
                  selectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  unselectedItemColor: Colors.grey,
                  unselectedLabelStyle: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ));
  }
}
