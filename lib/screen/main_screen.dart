import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:news/bloc/bottom_nav_bloc.dart';
import 'package:news/screen/tabs/HomeScreen.dart';
import 'package:news/screen/tabs/search_screen.dart';
import 'package:news/screen/tabs/source_screen.dart';
import 'package:news/style/theme.dart' as Style;
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  BottomNavbarBloc _bottomNavbarBloc;
  @override
  void initState(){
    super.initState();
    _bottomNavbarBloc = BottomNavbarBloc();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            backgroundColor: Style.Colors.mainColor,
            title: Text('NewsApp' ,style: TextStyle(color: Colors.white),),
          ),
          preferredSize: Size.fromHeight(50.0)
      ),
    body: SafeArea(child: StreamBuilder<NavBarItem>(
    stream: _bottomNavbarBloc.itemStream,
    initialData: _bottomNavbarBloc.defualtItem,
    builder: (BuildContext context,AsyncSnapshot<NavBarItem> snapshot){
      switch(snapshot.data){
        case NavBarItem.HOME:
          return HomeScreen();
          case NavBarItem.SOURCES:
            return SourceScreen();
            case NavBarItem.SEARCH:
              return SearchScreen();
    }
    }
    )
    ),
    bottomNavigationBar: StreamBuilder(
    initialData: _bottomNavbarBloc.defualtItem,
    stream: _bottomNavbarBloc.itemStream,
    builder: (BuildContext context,AsyncSnapshot<NavBarItem> snapshot){
      return Container(
      decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
    topRight: Radius.circular(30),
    topLeft: Radius.circular(30)
    ),
    boxShadow: [
    BoxShadow(
    color: Colors.grey[100],spreadRadius: 0,blurRadius: 10,
    )
    ]
      ),
    child: ClipRRect(
    borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
    child: BottomNavigationBar(
    backgroundColor: Colors.white,
    iconSize: 20.0,
    unselectedItemColor: Style.Colors.grey,
    selectedFontSize: 9.5,
    type: BottomNavigationBarType .fixed,
    fixedColor: Style.Colors.mainColor,
    currentIndex: snapshot.data.index,
    onTap: _bottomNavbarBloc.pickItem,
    items: [
      BottomNavigationBarItem(title: Padding(padding: EdgeInsets.only(top: 5.0),child: Text("Home"),),icon: Icon(EvaIcons.homeOutline),activeIcon: Icon(EvaIcons.home)),
      BottomNavigationBarItem(title: Padding(padding: EdgeInsets.only(top: 5.0),child: Text("Source"),),icon: Icon(EvaIcons.gridOutline),activeIcon: Icon(EvaIcons.gridOutline)),
      BottomNavigationBarItem(title: Padding(padding: EdgeInsets.only(top: 5.0),child: Text("Search"),),icon: Icon(EvaIcons.searchOutline),activeIcon: Icon(EvaIcons.search))
    ]
    ),
    ),
      );
    },
    ),
    );
  }
  Widget testScreen(){
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Test Screen")
        ],
      ),
    );
  }
}
