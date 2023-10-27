import 'package:flutter/material.dart';


class EventPage extends StatefulWidget{

  const EventPage({Key? key}) : super(key: key);

  @override
  EventPageHome createState() => EventPageHome();
}


class EventPageHome extends State<EventPage> with TickerProviderStateMixin{

  static final GlobalKey<ScaffoldState> globalKey = GlobalKey();
  final PageController pageController = PageController(initialPage: 1);
  late final TabController tabController;
  bool _expanded = false;

  var value = 'Overview';

  @override
  void initState(){

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

      drawer: MenuDrawer(context),

      appBar: AppBar(
        leading: BackButton(),
        actions: <Widget>[
          IconButton(onPressed: (){}, icon: Icon(Icons.search))
        ],
      ),
      body: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child:  Padding(
          padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[




              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[



                  //여기다가



                  SizedBox(
                    width: widths - 300,
                  ),
                  Text(
                      '30 days left'),
                  //=> 시간 들어가는 부분(영국 표준 협정시 기준으로 로직을 계산해서 넣을것)
                ],
              ),







              //서버에서 받아온 내용에서, 사진이 없으면, 따로 쳐내는 코드 넣을것.

              Container(),

              Padding(padding:  const EdgeInsets.all(5.0),

                child:    ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child:  Image.network('https://hidamarirhodonite.kirara.ca/spread/200297.png'),
                ),

              ),

              Center(child: Text('Monitor GirlFreind 2023',style: TextStyle(fontSize: 30),),),


              Divider(),




              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                Text(value),

                PopupMenuButton(

                  icon: const Icon(Icons.expand_more_outlined),
                  onSelected: (value) {
                    // your logic
                  },
                  itemBuilder: (BuildContext bc) {
                    return  [
                      PopupMenuItem(
                        child: Text("Overview"),
                        value: 'Overview',
                        onTap: (){


                          setState(() {
                            value = 'Overview';
                          });

                        },
                      ),
                      PopupMenuItem(
                        child: Text("Participants(346)"),
                        value: 'Participants(346)',
                        onTap: (){

                          setState(() {
                            value = 'Participants';
                          });
                        },
                      ),
                      PopupMenuItem(
                        child: Text("Rules"),
                        value: 'Rules',
                        onTap: (){

                          setState(() {
                            value = 'Rules';
                          });
                        },
                      )
                    ];
                  },
                )
              ],
              ),

              Divider(),


              value == 'Overview' ? eventInfo(context) : value == 'Participants' ? participantsInfo(context) : value == 'Rules' ? RulesInfo(context) : Container(child: Text('error'),)





              











            ],
          ),
        ),
      )




    );

  }



}


Widget participantsInfo(BuildContext context){

  return Expanded(
    child:  ListView.separated(
      scrollDirection: Axis.vertical,

      //shrinkWrap: true,
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

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        SizedBox(
                          height: 75,
                          width: 75,

                          child:   Padding(

                            padding:  const EdgeInsets.all(5.0),

                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(180),
                              child:  Image.network('https://dcjnmis8jxmbl.cloudfront.net/upload/image/member/thumbnail/2022/01/12/3Dwra57Bjvhcqsuy.webp'),
                            ),

                          ),
                        ),


                        Text('Host'),


                      ],
                    ),




                    Text('nickname'),

                    Row(children: <Widget>[
                      Text('2 PROJECTS'),
                      Text('2 ACHIEVEMENT'),
                      Text('2 BADGES'),

                    ],)








                  ],
                ),
              ),
            )
        );



      },
      separatorBuilder: (BuildContext context, int index) {
        return Container();
      },


    ),
  );




}





Widget RulesInfo(BuildContext context){

  return Column(

      crossAxisAlignment: CrossAxisAlignment.start,

      children: <Widget>[
        Divider(),
        Text('I want a picture of my monitor girlfriend. It is free form. Please refer to the ‘Prize’ section below for the prize list.'),



        Divider(),




        Text('PRIZES',style: TextStyle(fontSize: 20),),

        Text('First place'),
        Text('＄10,000'),
        Text('2nd place'),
        Text('＄50,000'),
        Text('3rd place'),
        Text('＄30,000'),



        Text('JUDGIND CRITERIA'),

        Text('Beautifully'),
        Text('Soundly'),
        Text('Doing the best'),



      ]




  );
}


Widget eventInfo(BuildContext context){
  
  return Column(

    crossAxisAlignment: CrossAxisAlignment.start,

    children: <Widget>[
      Divider(),
      Text('OCT 30 - DEC1, 2023'),

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[




        Text('＄10,000 in prizes'),
        Text('1001 participants')
      ],
      ),

      Divider(),


      Text('I want a picture of my monitor girlfriend. It is free form. Please refer to the ‘Prize’ section below for the prize list.'),
      Divider(),

      Text('PRIZES',style: TextStyle(fontSize: 20),),

      Text('First place'),
      Text('＄10,000'),
      Text('2nd place'),
      Text('＄50,000'),
      Text('3rd place'),
      Text('＄30,000'),


    ]
    

    
    
  );
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

            currentAccountPicture: Row(

              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(180),
                  child:  Image.network('https://dcjnmis8jxmbl.cloudfront.net/upload/image/member/thumbnail/2022/01/12/3Dwra57Bjvhcqsuy.webp'),
                ),


              ],
            ),




            accountName: Text('hello'),
            accountEmail: Text('@helloMail'),
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
          title: const Text('Profile'),
          onTap: () {
            Navigator.pop(context);
          },
        ),

        ListTile(
          leading: Icon(
              Icons.settings
          ),
          title: const Text('setting'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );

}





TabBar get _tabBar => const TabBar(
  tabs: [
    Tab(icon: Icon(Icons.flight)),
    Tab(icon: Icon(Icons.directions_transit)),
    Tab(icon: Icon(Icons.directions_car)),
  ],
);


Widget listViewer(){


  return ListView.separated(
    scrollDirection: Axis.vertical,

    //shrinkWrap: true,
    padding: const EdgeInsets.all(2.0),
    itemCount:10,
    itemBuilder: (BuildContext context, int index){
      var widths = MediaQuery.of(context).size.width;
      var heights = MediaQuery.of(context).size.height;

      return GestureDetector(
          onTap: () {
            print('hello');
          },
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            child:  Padding(
              padding: const EdgeInsets.fromLTRB(2, 2, 2, 2),

              child: Text('hello'),
            ),
          )
      );



    },
    separatorBuilder: (BuildContext context, int index) {
      return Container();
    },


  );
}