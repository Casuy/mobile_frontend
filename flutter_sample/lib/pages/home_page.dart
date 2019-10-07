import 'package:flutter/material.dart';
import 'package:flutter_sample/dao/home_dao.dart';
import 'package:flutter_sample/model/common_model.dart';
import 'package:flutter_sample/model/grid_nav_model.dart';
import 'package:flutter_sample/model/home_model.dart';
import 'package:flutter_sample/widget/grid_nav.dart';
import 'package:flutter_sample/widget/loading_container.dart';
import 'package:flutter_sample/widget/local_nav.dart';
import 'package:flutter_sample/widget/search_bar.dart';
import 'package:flutter_sample/widget/webview.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

const APPBAR_SCROLL_OFFSET = 100;
const SEARCH_BAR_DEFAULT_TEXT = 'popolar events';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double appBarOpacity = 0;
  List<CommonModel> localNavList = [];
  List<CommonModel> bannerList = [];
  GridNavModel gridNavModel;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarOpacity = alpha;
    });
  }

  Future<Null> _handleRefresh() async {
//    HomeDao.fetch().then((result) {
//      setState(() {
//        resultString = json.encode(result);
//      });
//    }).catchError((e) {
//      setState(() {
//        resultString = e.toString();
//      });
//    });

    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        localNavList = model.localNavList;
        gridNavModel = model.gridNav;
        bannerList = model.bannerList;
        _loading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _loading = false;
      });
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      //Loading progress indicator
      body: LoadingContainer(
          isLoading: _loading,
          child: Stack(
            children: <Widget>[
              MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: RefreshIndicator(
                  onRefresh: _handleRefresh,
                  child: NotificationListener(
                    onNotification: (scrollNotification) {
                      if (scrollNotification is ScrollUpdateNotification &&
                          scrollNotification.depth == 0) {
                        //when scroll and update listview
                        _onScroll(scrollNotification.metrics.pixels);
                      }
                    },
                    child: _listView,
                  ),
                ),
              ),
              _appBar
            ],
          )),
    );
  }

  Widget get _listView {
    return ListView(
      children: <Widget>[
        //top banner
        _banner,
        //local navigation
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 7),
          child: LocalNav(localNavList: localNavList),
        ),
        //grid navigation
        GridNav(gridNavModel: gridNavModel),
      ],
    );
  }

  Widget get _appBar {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              //AppBar gradual shade background
              colors: [Color(0x66000000), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 23, 0, 0),
            height: 75.0,
            decoration: BoxDecoration(
              color:
                  Color.fromARGB((appBarOpacity * 255).toInt(), 255, 255, 255),
            ),
            child: SearchBar(
              searchBarType: appBarOpacity > 0.2
                  ? SearchBarType.homeLight
                  : SearchBarType.home,
              inputBoxClick: _jumpToSearch,
              speakClick: _jumpToSpeak,
              defaultText: SEARCH_BAR_DEFAULT_TEXT,
              leftButtonClick: () {},
            ),
          ),
        ),
        Container(
            height: appBarOpacity > 0.2 ? 0.5 : 0,
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]))
      ],
    );
  }

  Widget get _banner {
    return Container(
      height: 250,
      child: Swiper(
        itemCount: bannerList.length,
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Image.network(bannerList[index].icon, fit: BoxFit.fill),
            onTap: () {
              //TODO： go to a specific event page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  CommonModel model = bannerList[index];
                  return WebView(
                    url: model.url,
                    title: model.title,
                    hideAppBar: model.hideAppBar,
                  );
                }),
              );
            },
          );
        },
        pagination: SwiperPagination(),
      ),
    );
  }

  _jumpToSearch() {}

  _jumpToSpeak() {}
}
