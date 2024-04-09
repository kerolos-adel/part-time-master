import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:part_time/cubit/job/cubit.dart';
import 'package:part_time/cubit/settings/cubit.dart';
import 'package:part_time/cubit/user/cubit.dart';
import 'package:part_time/ui/login/choose_login.dart';
import 'package:part_time/ui/settings/settings_screen_for_company.dart';

import '../ui/add_job/add_job_screen.dart';
import '../ui/explore/explore_client_screen.dart';
import '../ui/explore/explore_comany_screen.dart';
import '../ui/search/search_client_screen.dart';
import '../ui/settings/settings_screen_for_client.dart';

class BottomNavigationBarForComapny extends StatelessWidget {
  BottomNavigationBarForComapny({super.key, required this.indexNum});
  void _logout(context){
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.black54,
        title: Row(
          children: [
            Padding(padding: EdgeInsets.all(8),
              child: Icon(Icons.logout,color: Colors.white,size: 36,),
            ),
            Padding(padding: EdgeInsets.all(8),
              child: Text(SettingsCubit.get(context).currentLanguage["signOut"],style:TextStyle(color:Colors.white,fontSize: 28,)),
            ),
          ],
        ),
        content: Text(SettingsCubit.get(context).currentLanguage["signOutConfirmMessage"],style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),),
        actions: [
          TextButton(onPressed: () {
            Navigator.pop(context);
          }, child: Text(SettingsCubit.get(context).currentLanguage["no"],style:TextStyle(color: Colors.green,fontSize: 18) ,)),
          TextButton(onPressed: () {
            UserCubit.get(context).SignOut();
            while(Navigator.canPop(context)){
              Navigator.pop(context);
            }
            Navigator.push(context, MaterialPageRoute(builder: (context) => ChooseLogin()));
          }, child: Text(SettingsCubit.get(context).currentLanguage["yes"],style:TextStyle(color: Colors.green,fontSize: 18) ,)),
        ],
      );
    },);
  }
  int indexNum = 0;
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      color: Colors.deepPurple.shade400,
      backgroundColor: Colors.blueAccent,
      buttonBackgroundColor: Colors.deepPurple.shade300,
      height: 50,

      index: indexNum,
      items:
       [
        Icon(Icons.list,size: 19,color: Colors.black,),
        Icon(Icons.add,size: 19,color: Colors.black,),
        Icon(Icons.settings ,size: 19,color: Colors.black,),
        Icon(Icons.exit_to_app ,size: 19,color: Colors.black,),
      ],
      animationDuration: const Duration(
          milliseconds: 300
      ),
      animationCurve: Curves.bounceInOut,
      onTap: (index) async {
        if(index==0){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ExploreCompanyScreen(),));
        }
        else if(index==1){
          JobCubit.get(context).ClearControllers();
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AddJobScreen(),));
        }
        else if(index==2){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SettingsCompanyScreen(),));
        }
        else if(index==3){
          _logout(context);
        }
      },
    );
  }
}