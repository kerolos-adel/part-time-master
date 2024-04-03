import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:part_time/cubit/layout/cubit.dart';
import 'package:part_time/cubit/layout/states.dart';
import 'package:part_time/cubit/settings/cubit.dart';
import 'package:part_time/cubit/settings/states.dart';
import 'package:part_time/shared/styles/colors.dart';
import 'package:part_time/ui/settings/settings_screen_for_client.dart';

class CompanyLayoutScreen extends StatelessWidget {
  const CompanyLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LayoutCubit, LayoutStates>(
        builder: (context, state) => BlocBuilder<SettingsCubit, SettingsStates>(
              builder: (context, state) => Scaffold(
                appBar: AppBar(
                  backgroundColor: AppColors.AppBarBackGround,
                  leading: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: CircleAvatar(
                      child: Icon(Icons.factory),
                    ),
                  ),
                  title: const Text("Company"),
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
                      ),
                    ),
                  ],
                ),
                body: LayoutCubit.get(context)
                    .company_screens[LayoutCubit.get(context).currentIndex],
                bottomNavigationBar: BottomNavigationBar(
                  elevation: 20,
                  backgroundColor: AppColors.AppBarBackGround,
                  items: [
                    BottomNavigationBarItem(
                        icon: const Icon(Icons.my_library_books),
                        label: SettingsCubit.get(context)
                            .currentLanguage["myJobs"]),
                    BottomNavigationBarItem(
                        icon: const Icon(Icons.archive),
                        label: SettingsCubit.get(context)
                            .currentLanguage["archived"]),
                  ],
                  currentIndex: LayoutCubit.get(context).currentIndex,
                  onTap: (index) {
                    LayoutCubit.get(context).ChangeCurrentIndex(index);
                  },
                  selectedItemColor: Colors.white,
                  selectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  unselectedItemColor: Colors.black,
                  unselectedLabelStyle: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ));
  }
}
