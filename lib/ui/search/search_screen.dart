import 'package:flutter/material.dart';

import '../../Widgets/bottom_nav_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
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
      bottomNavigationBar: BottomNavigationBarForApp(indexNum:1),

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
        title: const Text("All Works Screen",style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),

    ));
  }
}
