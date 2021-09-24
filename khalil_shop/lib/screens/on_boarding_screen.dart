import 'package:flutter/material.dart';
import 'package:khalil_shop/helper/cache_helper.dart';
import 'package:khalil_shop/models/themes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'login_screen.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({required this.image, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController boardController = PageController();

  List<BoardingModel> onBoaringList = [
    BoardingModel(
      image: 'assets/images/onboard_1.jpg',
      title: 'on Board 1 Title',
      body: 'on Board 1 BODY',
    ),
    BoardingModel(
      image: 'assets/images/onboard_1.jpg',
      title: 'on Board 2 Title',
      body: 'on Board 2 BODY',
    ),
    BoardingModel(
      image: 'assets/images/onboard_1.jpg',
      title: 'on Board 3 Title',
      body: 'on Board 3 BODY',
    ),
  ];

  bool isLast = false;

  void submit(){
    CacheHelper.saveData(key: 'OnBoarding', value: true).then((value) {
      if(value){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed:submit,
            child: Text('SKIP',style: TextStyle(fontSize: 20),),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index){
                  if(index == onBoaringList.length -1){
                    print('last');
                    setState(() {
                      isLast = true;
                    });
                  }
                },
                controller: boardController,
                physics: BouncingScrollPhysics(),
                itemCount: onBoaringList.length,
                itemBuilder: (context, index) =>
                    BuildBoardingItem(onBoaringList[index]),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: onBoaringList.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 6,
                    expansionFactor: 4,
                    activeDotColor:defaultColor,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                   if(isLast){
                    submit();
                   }else{
                     boardController.nextPage(
                       duration: Duration(
                         milliseconds: 700,
                       ),
                       curve: Curves.fastLinearToSlowEaseIn,
                     );
                   }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget BuildBoardingItem(BoardingModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image:  AssetImage(
            '${model.image}',
          ),
          fit: BoxFit.cover,
        ),
        Spacer(),
        Text(
          '${model.title}',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          '${model.body}',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }


}
