import 'package:flutter/material.dart';
import 'package:part_time/constants/assets/assets.dart';
import 'package:part_time/cubit/settings/cubit.dart';
import 'package:part_time/models/boarding/boarding_model.dart';
import 'package:part_time/shared/preferences/cache_helper.dart';
import 'package:part_time/shared/styles/colors.dart';
import 'package:part_time/ui/register/register_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';



class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  var boardController = PageController();
  bool isLast = false;

  void submit(context){
    CacheHelper.saveData(key: "onboarding", value: true).then((value){
      if(value){
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const RegisterScreen()),
              (route) => false,
        );
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    List<BoardingModel> boarding = [
      BoardingModel(
        image: AppAssets.onBoarding1,
        title: SettingsCubit.get(context).currentLanguage["onboardingTitle1"],
        body: SettingsCubit.get(context).currentLanguage["onboardingBody1"],
      ),
      BoardingModel(
        image: AppAssets.onBoarding2,
        title: SettingsCubit.get(context).currentLanguage["onboardingTitle2"],
        body: SettingsCubit.get(context).currentLanguage["onboardingBody2"],
      ),
      BoardingModel(
        image: AppAssets.onBoarding4,
        title: SettingsCubit.get(context).currentLanguage["onboardingTitle3"],
        body: SettingsCubit.get(context).currentLanguage["onboardingBody3"],
      ),
    ];
    return Scaffold(
        backgroundColor: AppColors.backGround,
        appBar: AppBar(
          backgroundColor: AppColors.backGround,
          actions: [
            TextButton(
                onPressed: (){
                  submit(context);
                },
                child: Text(
                  SettingsCubit.get(context).currentLanguage["skip"],
                    style: const TextStyle(
                      color: AppColors.AppBarBackGround,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: boardController,
                  itemBuilder: (context, index) =>
                      buildBoardingItem(boarding[index]),
                  itemCount: boarding.length,
                  onPageChanged: (index){
                    if(index == boarding.length - 1){
                      setState(() {
                        isLast = true;
                      });
                    }
                    else{
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                      controller: boardController,
                      count: boarding.length,
                      effect: const ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        dotHeight: 10,
                        dotWidth: 10,
                        expansionFactor: 4,
                        spacing: 5,
                        activeDotColor: AppColors.AppBarBackGround,
                      ),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if(isLast){
                        submit(context);
                      }
                      else{
                        boardController.nextPage(
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.fastEaseInToSlowEaseOut,
                        );
                      }
                    },
                    backgroundColor: AppColors.AppBarBackGround,
                    child: const Icon(Icons.arrow_forward),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(model.image),
            ),
          ),
          Text(
            model.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            model.body,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 20),
        ],
      );
}
