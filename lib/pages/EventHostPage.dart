import 'package:flutter/material.dart';
import 'package:morimori/pages/EventApply.dart';
import 'package:morimori/pages/SelectWinnerPage.dart';
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../ui/features/widgets/custom/need_login_dialog.dart';
import 'EventPage.dart';


class EventHostPage extends StatefulWidget{

  const EventHostPage({Key? key}) : super(key: key);

  @override
  EventHostPageHome createState() => EventHostPageHome();
}

class EventHostPageHome extends State<EventHostPage> with TickerProviderStateMixin{
  static final GlobalKey<ScaffoldState> globalKey = GlobalKey();
  final PageController pageController = PageController(initialPage: 1);
  final ScrollController _scrollController = ScrollController();
  late final TabController tabController;

  var value = 'Overview';
  //프로필에 보이는 페이지는, 내게 보이는 해커톤 페이지

  @override
  void initState(){

    tabController = TabController(length: 3, vsync: this);
    super.initState();

  }

  @override
  void dispose() {
    pageController.dispose();
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var widths = MediaQuery.of(context).size.width;
    var heights = MediaQuery.of(context).size.height;

    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        leading: const BackButton(),
        actions: <Widget>[
          IconButton(onPressed: (){}, icon: const Icon(Icons.search))
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Card(
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
                    Text('24 days left'),
                    //=> 시간 들어가는 부분(영국 표준 협정시 기준으로 로직을 계산해서 넣을것)
                  ],
                ),
                //서버에서 받아온 내용에서, 사진이 없으면, 따로 쳐내는 코드 넣을것.
                Container(),
                Padding(padding:  const EdgeInsets.all(5.0),

                  child:    ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child:  Image.asset('assets/shibuyaRinCity.png'),
                  ),

                ),
                Center(child: Text('Shibuya & Rin',style: TextStyle(fontSize: 20),),),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
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
                        ),

                        PopupMenuItem(
                          child: Text("Project gallery"),
                          value: 'Project gallery',
                          onTap: (){

                            setState(() {
                              value = 'Project';
                            });
                          },
                        )
                      ];
                    },
                  )
                ],
                ),
                Divider(),
                value == 'Overview' ? eventInfo(context) : value == 'Participants' ? participantsInfo(context) : value == 'Rules' ? RulesInfo(context) : value == 'Project' ? projectInfo(context): Container(child: Text('error'),)
              ],
            ),
          ),
        ),
      )
    );

  }
}

Widget projectInfo(BuildContext context){

  return ListView.separated(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    padding: const EdgeInsets.all(2.0),
    itemCount: 2,
    itemBuilder: (BuildContext context, int index){
      var widths = MediaQuery.of(context).size.width;
      var heights = MediaQuery.of(context).size.height;
      return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => EventPage()));
          },
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            child: Stack(
              children: <Widget>[
                ///배경 이미지
                Image.asset('assets/morilogo.png'),
                ///하단을 뿌옇게
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 90, // 뿌옇게 처리할 영역의 높이
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.grey.withOpacity(1), // 하단은 더 뿌옇게
                          Colors.grey.withOpacity(0.0), // 상단은 투명하게
                        ],
                      ),
                    ),
                  ),
                ),
                ///별 아이콘
                Positioned(
                  top: 10,
                  right: 10,
                  child: Image.asset('assets/icons/star1.png', width: 40,),
                ),
                ///대회 제목, 대회 내용, 어워드, 좋아요, 댓글
                Positioned(
                    bottom: 10,
                    left: 10,
                    right: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Screen Character',
                          style: TextStyle(
                            fontWeight: FontWeight.bold, // 볼드 처리
                            fontSize: 16, // 폰트 사이즈 12
                          ),
                        ),
                        SizedBox(
                          width: widths*0.84,
                          child: Text(
                            'By embodying characters on the screen and making them feel something, I empathize with ...',
                            maxLines: 2, // 최대 줄 수를 2로 설정
                            overflow: TextOverflow.ellipsis, // 오버플로우 발생 시 '...'로 처리
                            style: TextStyle(
                              color: Colors.grey, // 텍스트 색상을 회색으로 설정
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(fontSize: 14), // 기본 폰트 사이즈 14
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Road-IL 2023',
                                      style: TextStyle(fontWeight: FontWeight.bold), // 'Road-IL 2023' 볼드 처리
                                    ),
                                    TextSpan(
                                      text: ' Winner',
                                      style: TextStyle(fontWeight: FontWeight.normal), // ' Winner' 일반 체중
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Icon(Icons.favorite),
                            const SizedBox(width: 3,),
                            Text('2'),
                            const SizedBox(width: 6,),
                            const Icon(Icons.chat_bubble),
                            const SizedBox(width: 3,),
                            Text('2'),
                          ],
                        )
                      ],
                    ))
              ],
            ),
          )
      );



    },
    separatorBuilder: (BuildContext context, int index) {
      return Container();
    },


  );

}

Widget participantsInfo(BuildContext context){

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
                      (index == 0) ? const Text('Host', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),) : const Text(''),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5,5,5,5),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text('nickname',style: TextStyle(fontSize: 20),),

                        Row(children: <Widget>[

                          Padding( padding: const EdgeInsets.fromLTRB(0,5,10,2),
                            child:
                            Text('2 PROJECTS'),),

                          Padding(  padding: const EdgeInsets.fromLTRB(0,5,10,2),
                            child:
                            Text('2 ACHIEVEMENT'),),

                          Padding(  padding: const EdgeInsets.fromLTRB(0,5,10,2),
                            child:
                            Text('2 BADGES'),),


                        ],)

                      ],
                    )
                  ),

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


Widget RulesInfo(BuildContext context){

  return Column(

      crossAxisAlignment: CrossAxisAlignment.start,

      children: <Widget>[
        Padding(  padding: const EdgeInsets.all(20),
          child: Text('I want a picture of my monitor girlfriend. It is free form. Please refer to the ‘Prize’ section below for the prize list.'),),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Text('PRIZES',style: TextStyle(fontSize: 20),),
        ),

        Padding(padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              Text('First place'),
              Text('\$ 10,000'),
            ],)),

        Padding(padding: const EdgeInsets.fromLTRB(20,5,5,5),
            child: Column(children: <Widget>[

              Text('2nd place'),
              Text('\$ 50,000'),
            ],)),

        Padding(padding: const EdgeInsets.fromLTRB(20,5,5,5),
            child: Column(children: <Widget>[
              Text('3rd place'),
              Text('\$ 30,000'),
            ],)),

        Padding(
          padding: const EdgeInsets.all(12),
          child: Text('JUDGIND CRITERIA',style: TextStyle(fontSize: 20)),
        ),

        Padding(padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              Text('Beautifully'),
              Text('Soundly'),
              Text('Doing the best'),
            ],)),

      ]

  );
}


Widget eventInfo(BuildContext context){
  
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,

    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('OCT 30 - DEC1, 2023',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 16.0, color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(text: '\$ '),
                      TextSpan(text: '10,000', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: ' in prizes'),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 16.0, color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(text: '1001', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: ' participants'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      Divider(),

      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text('I want a picture of my monitor girlfriend. It is free form. Please refer to the ‘Prize’ section below for the prize list.'),
      ),
      Divider(),

      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text('PRIZES',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
      ),


      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('First place'),
            Text('＄10,000'),
            SizedBox(height: 8,),
            Text('2nd place'),
            Text('＄50,000'),
            SizedBox(height: 8,),
            Text('3rd place'),
            Text('＄30,000'),
            SizedBox(height: 8,),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[

                TextButton(onPressed: (){

                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SelectWinnerPage()));

                }, style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.lightBlueAccent)), child: const Text('Select Winners',style: TextStyle(color: Colors.white),) )
              ],
            )
          ],
        ),
      ),



    ]
  );
}


Widget projectGallery(BuildContext context){
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('OCT 30 - DEC1, 2023',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 16.0, color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(text: '\$ '),
                        TextSpan(text: '10,000', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: ' in prizes'),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 16.0, color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(text: '1001', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: ' participants'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        Divider(),

        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text('I want a picture of my monitor girlfriend. It is free form. Please refer to the ‘Prize’ section below for the prize list.'),
        ),
        Divider(),

        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text('PRIZES',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        ),


        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('First place'),
              Text('＄10,000'),
              SizedBox(height: 8,),
              Text('2nd place'),
              Text('＄50,000'),
              SizedBox(height: 8,),
              Text('3rd place'),
              Text('＄30,000'),
              SizedBox(height: 8,),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[

                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  const EventApplyPage()));

                  }, style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.lightBlueAccent)), child: Text('Apply Now',style: TextStyle(color: Colors.white),) )
                ],
              )
            ],
          ),
        ),



      ]
  );
}

TabBar get _tabBar => const TabBar(
  tabs: [
    Tab(icon: Icon(Icons.flight)),
    Tab(icon: Icon(Icons.directions_transit)),
    Tab(icon: Icon(Icons.directions_car)),
  ],
);


Widget EventlistViewer(){


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