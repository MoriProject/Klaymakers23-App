import 'package:flutter/material.dart';

class EventMakingPage extends StatefulWidget {
  const EventMakingPage({Key? key}) : super(key: key);

  @override
  EventMakingPageHome createState() => EventMakingPageHome();
}

class EventMakingPageHome extends State<EventMakingPage> with TickerProviderStateMixin {
  static final GlobalKey<ScaffoldState> globalKey = GlobalKey();
  final PageController pageController = PageController(initialPage: 1);
  late final TabController tabController;
  bool _expanded = false;

  var value = 'Overview';

  var prizeNum = List.filled(1, '1', growable: true);
  var budget = List.filled(1, 0, growable: true);
  var numOfParti = List.filled(1, '0', growable: true);

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
        appBar: AppBar(
          leading: BackButton(),
          actions: <Widget>[
            IconButton(onPressed: () {}, icon: Icon(Icons.search))
          ],
        ),
        body: SingleChildScrollView(
            child: Padding(padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[


                  Text("Hackathon title"),
                  TextField(),


                  Text("Description of hackation"),
                  TextField(),

                  Text("Hackation Image"),

                  SizedBox(
                    //height: heights,
                    height: 200,
                    width: widths,
                    child:Card(
                        child:  IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {

                          },
                        )
                    ),
                  ),


                  Text('Prizes'),

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



                  SizedBox(
                    height: 200,

                    child: ListView.separated(
                      scrollDirection: Axis.vertical,

                      //shrinkWrap: true,
                      padding: const EdgeInsets.all(2.0),
                      itemCount: prizeNum.length,
                      itemBuilder: (BuildContext context, int i){
                        var widths = MediaQuery.of(context).size.width;
                        var heights = MediaQuery.of(context).size.height;

                        //(BuildContext context, widths, prizeNum, budget, NumOfParti)


                        return PrizeWidget(context, widths, i+1, budget[i], numOfParti[i]);

                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider();
                      },


                    ),

                  ),
                  SizedBox(
                      width: widths,
                      child: Card(
                        color: Colors.lightBlueAccent,
                        child: IconButton(onPressed: (){
                          setState(() {
                            prizeNum.add('0');
                            budget.add(0);
                            numOfParti.add('0');

                          });
                        }, icon:  Icon(Icons.add)),
                      )
                  ),


                  Text('Rules'),

                  TextField(
                    maxLines: 6,
                    minLines: 6,
                  ),


                  Text('Judging createria'),

                  TextField(
                    maxLines: 6,
                    minLines: 6,
                  ),


                  Row(
                    children: <Widget>[

                      Text('Need balance: '),
                      Text('')


                    ],
                  ),


                  SizedBox(
                    width: widths,


                    child: Card(
                      color: Colors.lightBlueAccent,
                      child: TextButton(onPressed: (){}, child: Text('Hackathon creation')),
                    ),
                  )








                ],
              ),















            )





        )
    );
  }
}




Widget PrizeWidget(BuildContext context, widths, prizeNum, budget, NumOfParti){

  return SizedBox(
      width: widths,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Text('Prize. $prizeNum'),

          Row(
            children: <Widget>[
              Text('A total of'),
              SizedBox(
                width: 60,
                child: TextField(),
              ),
              Text('＄ in prize money'),
            ],
          ),

          Text('will be equally distributed'),


          Row(
            children: <Widget>[
              Text('among'),
              SizedBox(
                width: 40,
                child: TextField(),
              ),

              Text('participants')

            ],
          ),





        ],

      )

  );

}
