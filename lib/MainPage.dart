import 'package:flutter/material.dart';


class MainPage extends StatefulWidget{

  const MainPage({Key? key}) : super(key: key);

  @override
  MainPageHome createState() => MainPageHome();
}


class MainPageHome extends State<MainPage>{

  static final GlobalKey<ScaffoldState> globalKey = GlobalKey();

  @override
  void initState(){

    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,

      drawer: MenuDrawer(context),

      appBar: AppBar(


        leading: GestureDetector(
          onTap: (){
            globalKey.currentState!.openDrawer();
          },
          child: Icon(Icons.menu),
        )
      ),



    );

  }



}


Widget MenuDrawer(BuildContext context){

  return Drawer(
    child: ListView(

      padding: EdgeInsets.zero,
      children: <Widget>[




        GestureDetector(
          onTap: () {
            Navigator.pop(context);

          },
          child: UserAccountsDrawerHeader(
            //Drawer 헤드부분 생성 후 설정부분

            otherAccountsPictures: const <Widget>[],
            accountName: Text('hello'),
            accountEmail: Text('hello'),
            // onDetailsPressed: () {
            //   print('arrow is clicked');
            // },
            // 지금 Drawer 헤드부분 안에 있으니 -> 헤드부분 디자인 변경
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff8AEBF2), Color(0xff9887FE)]),
              borderRadius: BorderRadius.only(
                //borderRadius -> 모서리 디자인 변경
                  bottomLeft: Radius.circular(16.0),
                  //Radius.circular -> 모서리 둥글게
                  bottomRight: Radius.circular(16.0)),
            ),
          ),
        ),





        ListTile(
          leading: Icon(
            Icons.account_circle_outlined,
          ),
          title: const Text('프로필'),
          onTap: () {
            Navigator.pop(context);

          },
        ),
      ],

    ),
  );

}