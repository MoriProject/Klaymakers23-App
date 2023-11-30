import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  SettingPageHome createState() => SettingPageHome();
}

class SettingPageHome extends State<SettingPage> with TickerProviderStateMixin {
  static final GlobalKey<ScaffoldState> globalKey = GlobalKey();
  final PageController pageController = PageController(initialPage: 1);
  late final TabController tabController;

  var value = 'Overview';

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
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
        drawer: BackButton(),
        appBar: AppBar(
          leading: BackButton(),
          actions: <Widget>[
            IconButton(onPressed: () {}, icon: Icon(Icons.search))
          ],
        ),
        body: Padding(padding:  const EdgeInsets.fromLTRB(20,5,20,5),

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            children: <Widget>[
              Text('Profile info',style: TextStyle(fontSize: 20),),
              Text('This information will appear on your public service profile.'),


              Divider(),

              Text('Photo',style: TextStyle(fontSize: 15),),


          Row(
            children: <Widget>[

              Padding(padding:  const EdgeInsets.fromLTRB(5,10,70,5),child:
              SizedBox(
                height: 100,
                width: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(180),
                  child:  Image.asset('assets/113495932_p0.png'),
                ),
              )

              ),

              const Column(children: <Widget>[
                Text(
                    'Upload Photo',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 35,),
                Text(
                    'Delete Photo',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ],),


            ],
          ),

              Text('Nickname'),
              TextField(),

              Text('Bio'),
              TextField(),


              Row(children: <Widget>[

                TextButton(onPressed: (){}, child: Text('save Changes')),

                TextButton(onPressed: (){}, child: Text('cancel'))

              ],),




              TextButton(onPressed: (){}, child: Text('Delete Account'))











            ],
          ),

        )












    );
  }
}



TabBar get _tabBar => const TabBar(
      tabs: [
        Tab(icon: Icon(Icons.flight)),
        Tab(icon: Icon(Icons.directions_transit)),
        Tab(icon: Icon(Icons.directions_car)),
      ],
    );

Widget listViewer() {
  return ListView.separated(
    scrollDirection: Axis.vertical,

    //shrinkWrap: true,
    padding: const EdgeInsets.all(2.0),
    itemCount: 10,
    itemBuilder: (BuildContext context, int index) {
      var widths = MediaQuery.of(context).size.width;
      var heights = MediaQuery.of(context).size.height;

      return GestureDetector(
          onTap: () {
            print('hello');
          },
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
              child: Text('hello'),
            ),
          ));
    },
    separatorBuilder: (BuildContext context, int index) {
      return Container();
    },
  );
}
