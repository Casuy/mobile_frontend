import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
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
            )
          ],
        ),
      ),
    );
  }
}