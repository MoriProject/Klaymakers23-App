import 'package:flutter/material.dart';
import 'package:morimori/pages/WorkInfoPage.dart';




class SearchPage extends StatefulWidget {

  final String searchData;

  SearchPage( {required this.searchData, Key? key}) : super(key: key);


  @override
  SearchPageHome createState() => SearchPageHome();


}

class SearchPageHome extends State<SearchPage> with TickerProviderStateMixin {
  static final GlobalKey<ScaffoldState> globalKey = GlobalKey();
  final PageController pageController = PageController(initialPage: 1);



  late final TabController controller;



  var value = 'Overview';


  int numProjects = 2;
  int numBadges = 2;
  int numAchievements = 1;
  int numHackthons = 2;




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
    var widths = MediaQuery.of(context).size.width;
    var heights = MediaQuery.of(context).size.height;

    return Scaffold(
        key: globalKey,
        appBar: AppBar(
          title: Text(''),
          leading: const BackButton(),
          actions: <Widget>[
            IconButton(onPressed: () {}, icon: Icon(Icons.search))
          ],
        ),
        body: Padding(padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: Column(
            children: <Widget>[


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



