import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_sample/dao/home_dao.dart';
import 'package:flutter_sample/model/home_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

const APPBAR_SCROLL_OFFSET = 100;

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  List _imageUrls = [
    'https://yurielkaim.com/wp-content/uploads/2011/06/4-Best-Core-Strengthening-Exercises-for-Beginners.jpg',
    'https://yurielkaim.com/wp-content/uploads/2016/10/19-Stretches-to-Improve-Flexibility-You-Can-Do-Right-Now.jpg',
    'https://yurielkaim.com/wp-content/uploads/2017/02/9-Important-Stretching-Exercises-for-Seniors-to-Do-Every-Day.jpg'
  ];
  double appBarOpacity = 0;
  String resultString = "";


  @override
  void initState() {
    super.initState();
    loadData();
  }

  _onScroll(offset){
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0){
      alpha = 0;
    }else if (alpha > 1){
      alpha = 1;
    }
    setState(() {
      appBarOpacity = alpha;
    });
    print(appBarOpacity);
  }

  loadData() async {
//    HomeDao.fetch().then((result) {
//      setState(() {
//        resultString = json.encode(result);
//      });
//    }).catchError((e) {
//      setState(() {
//        resultString = e.toString();
//      });
//    });

//    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        resultString = json.encode(model.config);
      });
//    } catch (e) {
//      setState(() {
//        resultString = e.toString();
//      });
//    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: NotificationListener(
              onNotification: (scrollNotification){
                if (scrollNotification is ScrollUpdateNotification &&
                    scrollNotification.depth == 0){
                  //when scroll and update listview
                  _onScroll(scrollNotification.metrics.pixels);
                }
              },
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 250,
                    child: Swiper(
                      itemCount: _imageUrls.length,
                      autoplay: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Image.network(
                            _imageUrls[index],
                            fit: BoxFit.fill
                        );
                      },
                      pagination: SwiperPagination(),
                    ),
                  ),
                  Container(
                    height: 800,
                    child: ListTile(title: Text(resultString)),
                  )
                ],
              ),
            ),
          ),
          Opacity(
            opacity: appBarOpacity,
            child: Container(
              height: 50,
              decoration: BoxDecoration(color: Colors.red),
              child: Center(
                child: Padding(padding: EdgeInsets.only(top: 20),
                  child: Text('Home', style: TextStyle(color: Colors.white),)),
              ),
            ),
          )
        ],
      ),
    );
  }
}