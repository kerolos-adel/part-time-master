import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:part_time/cubit/explore/cubit.dart';
import 'package:part_time/cubit/job/cubit.dart';
import 'package:part_time/cubit/layout/cubit.dart';
import 'package:part_time/cubit/login/cubit.dart';
import 'package:part_time/cubit/register/cubit.dart';
import 'package:part_time/cubit/settings/cubit.dart';
import 'package:part_time/shared/preferences/cache_helper.dart';
import 'package:part_time/ui/explore/explore_screen.dart';


void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (BuildContext context) => LoginCubit(),
        ),
        BlocProvider<RegisterCubit>(
          create: (BuildContext context) => RegisterCubit(),
        ),
        BlocProvider<LayoutCubit>(
          create: (BuildContext context) => LayoutCubit(),
        ),
        BlocProvider<ExploreCubit>(
          create: (BuildContext context) => ExploreCubit(),
        ),
        BlocProvider<SettingsCubit>(
          create: (BuildContext context) => SettingsCubit(),
        ),
        BlocProvider<JobCubit>(
          create: (BuildContext context) => JobCubit(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    if(CacheHelper.getData(key: "language") == "en"){
      SettingsCubit.get(context).ChangeCurrentLanguage({"en"});
    }
    else{
      SettingsCubit.get(context).ChangeCurrentLanguage({"ar"});
    }
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ExploreScreen(),
    );
  }
}
