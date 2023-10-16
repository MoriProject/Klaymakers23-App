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