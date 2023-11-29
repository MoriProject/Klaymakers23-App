import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../ui/upload_loading_widget.dart';
import 'EventPage.dart';
import 'MainPage.dart';

class EventApplyPage extends StatefulWidget {
  const EventApplyPage({Key? key}) : super(key: key);

  @override
  EventApplyPageHome createState() => EventApplyPageHome();
}

class EventApplyPageHome extends State<EventApplyPage> with TickerProviderStateMixin {

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Text('Image of Work'),

              SizedBox(
                //height: heights,
                height: 200,
                width: widths,
                child: Card(
                  child: InkWell(
                    onTap: () {
                      getImage(ImageSource.gallery);
                    },
                    child: Container(
                      width: double.infinity, // Ensures the InkWell fills the Card
                      height: double.infinity, // Ensures the InkWell fills the Card
                      alignment: Alignment.center, // Centers the IconButton
                      child: Icon(Icons.add),
                    ),
                  ),
                ),

              ),

              Text('Title'),
              TextField(),

              Text('Description of work'),
              TextField(
                maxLines: 6,
                minLines: 6,
              ),

              Text('Submission track'),

              PopupMenuButton(
                icon: Row(
                  children: [
                    Text(value),
                    const Icon(Icons.expand_more_outlined),
                  ],
                ),
                onSelected: (value) {
                  // your logic
                },
                itemBuilder: (BuildContext bc) {
                  return  [
                    PopupMenuItem(
                      child: Text("Main Track"),
                      value: 'Main Track',
                      onTap: (){
                        setState(() {
                          value = 'Main Track';
                        });

                      },
                    ),
                    PopupMenuItem(
                      child: Text("Sub Track"),
                      value: 'Sub Track',
                      onTap: (){

                        setState(() {
                          value = 'Sub Track';
                        });
                      },
                    ),
                    PopupMenuItem(
                      child: Text("Practice Track"),
                      value: 'Practice Track',
                      onTap: (){

                        setState(() {
                          value = 'Practice Track';
                        });
                      },
                    ),

                  ];
                },
              ),

              Row(

                mainAxisAlignment: MainAxisAlignment.end,

                children: <Widget>[
                  TextButton(onPressed: (){

                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        //title: Text('Would you like to save your work?'),
                        content: Text('Would you like to save your work?'),
                        actions: [
                          ElevatedButton(
                              onPressed: (){
                                loadingWidget(context);


                              },
                              child: Text('YES!')),
                          ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text('NO!')),
                        ],
                      ),
                    );

                  }, style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.lightBlueAccent)), child: Text('Save',style: TextStyle(color: Colors.white),) )


                ],
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



