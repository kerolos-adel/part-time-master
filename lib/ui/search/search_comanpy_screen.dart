import 'package:flutter/material.dart';

import '../../Widgets/bootom_nav_bar_client.dart';
import '../../Widgets/bottom_nav_bar_for_company.dart';

class SearchComapnyScreen extends StatefulWidget {
  const SearchComapnyScreen({super.key});

  @override
  State<SearchComapnyScreen> createState() => _SearchComapnyScreenState();
}

class _SearchComapnyScreenState extends State<SearchComapnyScreen> {
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
      bottomNavigationBar: BottomNavigationBarForComapny(indexNum:1),

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
