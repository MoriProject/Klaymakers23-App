import 'package:flutter/material.dart';

import 'EventPage.dart';
import 'MainPage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ProfilePageHome createState() => ProfilePageHome();
}

class ProfilePageHome extends State<ProfilePage> with TickerProviderStateMixin {
  static final GlobalKey<ScaffoldState> globalKey = GlobalKey();
  final PageController pageController = PageController(initialPage: 1);

  late final TabController controller;
  bool _expanded = false;

  var value = 'Overview';

  @override
  void initState() {
    //tabController = TabController(length: 3, vsync: this);
    controller = TabController(vsync: this, length: 4);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var widths = MediaQuery
        .of(context)
        .size
        .width;
    var heights = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
        key: globalKey,
        drawer: BackButton(),
        appBar: AppBar(
          leading: BackButton(),
          actions: <Widget>[
            IconButton(onPressed: () {}, icon: Icon(Icons.search))
          ],
        ),
        body: Padding(padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),

          child: Column(

            children: <Widget>[


            SizedBox(
            height: 100,
            width: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(180),
              child: Image.network(
                  'https://dcjnmis8jxmbl.cloudfront.net/upload/image/member/thumbnail/2022/01/12/3Dwra57Bjvhcqsuy.webp'),
            ),
          ),


          Text('LOGAN?', style: TextStyle(fontSize: 20),),

          Icon(Icons.expand_more_outlined),

          Divider(),

          TabBar(
              controller: controller,
             tabs : [Tab(icon: Text('2'), text: 'PROJECTS',),
              Tab(icon: Text('2'), text: 'BADGES',),
              Tab(icon: Text('2'), text: 'ACHIEVEMENTS'),
               Tab(icon: Text('2'), text: 'HACKTHONS'),
              ]
          ),


              SizedBox(

                height: heights - 400,

                  child : TabBarView(
                      controller: controller,
                      children: <Widget>[

                        listViewer(),

                        listViewer(),

                        listViewer(),
                        listViewer(),







                      ])
              )





            ],
          ),

        )


    );
  }
}


TabBar get _tabBar =>
    const TabBar(
      tabs: [
        Tab(icon: Icon(Icons.flight)),
        Tab(icon: Icon(Icons.directions_transit)),
        Tab(icon: Icon(Icons.directions_car)),
      ],
    );



