import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../ui/add_job/add_job_screen.dart';
import '../ui/explore/explore_client_screen.dart';
import '../ui/search/search_client_screen.dart';
import '../ui/settings/settings_screen_for_client.dart';

class BottomNavigationBarForClient extends StatelessWidget {
  BottomNavigationBarForClient({super.key, required this.indexNum});
  void _logout(context){
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.black54,
        title: const Row(
          children: [
            Padding(padding: EdgeInsets.all(8),
              child: Icon(Icons.logout,color: Colors.white,size: 36,),
            ),
            Padding(padding: EdgeInsets.all(8),
              child: Text("Sign Out",style:TextStyle(color:Colors.white,fontSize: 28,)),
            ),
          ],
        ),
        content: const Text("Do you want to Log out?",style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),),
        actions: [
          TextButton(onPressed: () {

          }, child: const Text('No',style:TextStyle(color: Colors.green,fontSize: 18) ,)),
          TextButton(onPressed: () {

          }, child: const Text('Yes',style:TextStyle(color: Colors.green,fontSize: 18) ,)),
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
      const [
        Icon(Icons.list,size: 19,color: Colors.black,),
        Icon(Icons.search,size: 19,color: Colors.black,),
        Icon(Icons.settings ,size: 19,color: Colors.black,),
        Icon(Icons.exit_to_app ,size: 19,color: Colors.black,),

      ],
      animationDuration: const Duration(
          milliseconds: 300
      ),
      animationCurve: Curves.bounceInOut,
      onTap: (index) {
        if(index==0){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ExploreClientScreen(),));
        }
        else if(index==1){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SearchClientScreen(),));
        }
        else if(index==2){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SettingsClientScreen(),));
        }
        else if(index==3){
          _logout(context);
        }
      },
    );
  }
}
