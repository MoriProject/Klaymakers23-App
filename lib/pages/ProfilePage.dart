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
                 tabs : [
                   Tab(icon: Text(numProjects.toString()), text: 'PROJECTS',),
                  Tab(icon: Text(numBadges.toString()), text: 'BADGES',),
                  Tab(icon: Text(numAchievements.toString()), text: 'ACHIEVEMENTS'),
                   Tab(icon: Text(numHackthons.toString()), text: 'HACKTHONS'),
                  ],
              ),
              SizedBox(
                height: heights - 400,
                  child : TabBarView(
                      controller: controller,
                      children: <Widget>[
                        eventItem(numProjects),
                        badgeItem(numBadges),
                        achievementItem(numAchievements),
                        eventItem(numHackthons),
                      ])
              ),
            ],
          ),
        )
    );
  }
}

Widget eventItem(int num){
  return ListView.builder(
    scrollDirection: Axis.vertical,
    padding: const EdgeInsets.all(2.0),
    itemCount: num,
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

Widget badgeItem(int num) {
  // return Text('a');
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3, // 3열로 설정
      crossAxisSpacing: 10, // 가로 간격
      mainAxisSpacing: 10, // 세로 간격
    ),
    itemCount: num, // 생성할 아이템의 수
    itemBuilder: (context, index) {
      return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.grey.withOpacity(0.6), // 하단은 더 뿌옇게
              Colors.grey.withOpacity(0.0), // 상단은 투명하게
            ],
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Image.asset('assets/icons/crown_icon.png',),
      );
    },
  );
}

Widget achievementItem(int num) {
  return ListView.builder(
      itemCount: num,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          alignment: Alignment.topLeft,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.grey.withOpacity(0.6), // 하단은 더 뿌옇게
                Colors.grey.withOpacity(0.0), // 상단은 투명하게
              ],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.asset('assets/icons/mdi_human-welcome.png'),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Welcome!',
                      style: TextStyle(
                        fontSize: 16, // 폰트 사이즈 16
                      ),
                    ),
                    SizedBox(height: 6,),
                    Text(
                      'Earned by signing up for our service',
                      style: TextStyle(
                        fontSize: 12, // 폰트 사이즈 12
                      ),
                    ),
                    SizedBox(height: 6,),
                    Text(
                      'Achieved October 16, 2023',
                      style: TextStyle(
                        fontSize: 12, // 폰트 사이즈 12
                        color: Colors.grey, // 텍스트 색상 회색
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
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



