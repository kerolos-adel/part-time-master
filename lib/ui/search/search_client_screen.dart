import 'package:flutter/material.dart';
import 'package:part_time/cubit/settings/cubit.dart';

import '../../Widgets/bootom_nav_bar_client.dart';
import '../../Widgets/bottom_nav_bar_for_company.dart';

class SearchClientScreen extends StatefulWidget {
  const SearchClientScreen({super.key});

  @override
  State<SearchClientScreen> createState() => _SearchClientScreenState();
}

class _SearchClientScreenState extends State<SearchClientScreen> {

  var SearchController = TextEditingController();
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
      bottomNavigationBar: BottomNavigationBarForClient(indexNum:1),

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
        title: Text(
          SettingsCubit.get(context).currentLanguage["jobSearch"],
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextFormField(
              controller: SearchController,
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
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
                hintText: SettingsCubit.get(context).currentLanguage["searchHintText"],
                hintStyle: TextStyle(
                  color: Colors.grey,
                )
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){}, child: Text(SettingsCubit.get(context).currentLanguage["search"])),
          ],
        ),
      ),
    ));
  }
}
