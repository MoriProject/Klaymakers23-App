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
        appBar: AppBar(
          leading: const BackButton(),
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
                 tabs : const [
                   Tab(icon: Text('2'), text: 'PROJECTS',),
                  Tab(icon: Text('2'), text: 'BADGES',),
                  Tab(icon: Text('2'), text: 'ACHIEVEMENTS'),
                   Tab(icon: Text('2'), text: 'HACKTHONS'),
                  ],
              ),
              SizedBox(
                height: heights - 400,
                  child : TabBarView(
                      controller: controller,
                      children: <Widget>[
                        listViewer1(),
                        listViewer(),
                        listViewer(),
                        listViewer(),
                      ])
              ),
            ],
          ),
        )
    );
  }
}

Widget listViewer1(){
  return ListView.builder(
    scrollDirection: Axis.vertical,
    padding: const EdgeInsets.all(2.0),
    itemCount:10,
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
                ///왕관 아이콘
                Positioned(
                  top: 10,
                  left: 10,
                  child: Image.asset('assets/icons/crown_icon.png', width: 40,),
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
  );
}

TabBar get _tabBar =>
    const TabBar(
      tabs: [
        Tab(icon: Icon(Icons.flight)),
        Tab(icon: Icon(Icons.directions_transit)),
        Tab(icon: Icon(Icons.directions_car)),
      ],
    );



