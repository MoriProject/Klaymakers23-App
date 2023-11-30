import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:morimori/pages/edit_event_screen.dart';

import '../ui/upload_loading_widget.dart';
import 'EventPage.dart';
import 'MainPage.dart';

class WorkInfoPage extends StatefulWidget {
  const WorkInfoPage({Key? key}) : super(key: key);

  @override
  WorkInfoPageHome createState() => WorkInfoPageHome();
}

class WorkInfoPageHome extends State<WorkInfoPage> with TickerProviderStateMixin {

  final ImagePicker _picker = ImagePicker();
  final List<XFile?> _pickedImages = [];

  //단일 이미지 선택
  void getImage(ImageSource source) async {
    _pickedImages.clear();
    final XFile? image = await _picker.pickImage(source: source);
    setState(() {
      _pickedImages.add(image);
    });
  }


  static final GlobalKey<ScaffoldState> globalKey = GlobalKey();
  final PageController pageController = PageController(initialPage: 1);

  late final TabController controller;
  bool _expanded = false;

  var value = 'Main Track';


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
        appBar: AppBar(
          leading: const BackButton(),
          actions: <Widget>[
            IconButton(onPressed: () {}, icon: Icon(Icons.search))
          ],
        ),
        body: Padding(padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[


                SizedBox(
                  child : ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network('https://hidamarirhodonite.kirara.ca/spread/200297.png'),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(180),
                          child:  Image.network('https://dcjnmis8jxmbl.cloudfront.net/upload/image/member/thumbnail/2022/01/12/3Dwra57Bjvhcqsuy.webp'),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5.0),
                        child: Text('Logan'),
                      ),

                      Expanded(child: Container()),

                      TextButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(Colors.blue),
                        ),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (BuildContext context) {
                                  return const EditEventScreen();
                                }));
                          },
                        child: Text(
                            'Edit',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),

                      ),
                    ],
                  ),
                ),


                Text('My girlfriend in monitor', style: TextStyle(fontSize: 20),),


                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0),
                  child: Row(
                    children: <Widget>[
                     Icon(Icons.workspace_premium),



                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5.0),
                        child: Text('Applied for Monitor Girlfriend 2023'),
                      )


                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.emoji_events),



                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5.0),
                        child: Text('First Place(winner)'),
                      )


                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0),
                  child: Row(
                    children: <Widget>[

                      Icon(Icons.visibility),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5.0),
                        child: Text('1.2K'),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(20,0,0,0),
                        child: Icon(Icons.favorite),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5.0),
                        child: Text('34'),
                      )




                    ],
                  ),
                ),

                Divider(),


                Text('My girlfriend is trapped in the monitor, but as the Singularity arrives, she will apparently emerge from beyond the dimension. With that wish in mind, we submit a work depicting the future to the hackathon. I hope my work will remain forever and be passed down to future generations!'),

                Divider(),

                Text('Discussion' ,style: TextStyle(fontSize: 20),),

                TextField(minLines: 4, maxLines: 4,),

                TextButton(onPressed: (){}, child: const Text('Comment',style: TextStyle(color: Colors.white),), style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.lightBlueAccent)),),

                commentInfo(context),


              ],
            ),
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



Widget commentInfo(BuildContext context){

  return ListView.separated(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    padding: const EdgeInsets.all(2.0),
    itemCount:10,
    itemBuilder: (BuildContext context, int index){
      var widths = MediaQuery.of(context).size.width;
      var heights = MediaQuery.of(context).size.height;

      return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>EventPage()));
          },
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            child:  Padding(
              padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  //서버에서 받아온 내용에서, 사진이 없으면, 따로 쳐내는 코드 넣을것.

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: <Widget>[
                      SizedBox(
                        height: 75,
                        width: 75,

                        child: Padding(
                          padding:  const EdgeInsets.all(5.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(180),
                            child:  Image.network('https://dcjnmis8jxmbl.cloudfront.net/upload/image/member/thumbnail/2022/01/12/3Dwra57Bjvhcqsuy.webp'),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Text('Kimchi Warrior 76',style: TextStyle(fontSize: 15),),
                            Text('3min ago')

                          ],
                        ),
                      )



                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(5,5,5,5),

                     child: Text('I really like his art. However, I think there are some things you need to pay attention to in the process of creating a work. In particular, I think we need to think a little more about the values of the work.'),
                  ),

                  Row(
                    children: <Widget>[

                      IconButton(onPressed: (){}, icon: Icon(Icons.thumb_up_outlined)),
                      Text('12'),

                      IconButton(onPressed: (){}, icon: Icon(Icons.thumb_down_outlined)),
                      Text('2'),

                      TextButton(onPressed: (){

                      }, child: Text('reply'))
                    ],
                  )

                ],
              ),
            ),
          )
      );
    },
    separatorBuilder: (BuildContext context, int index) {
      return Container();
    },

  );

}



