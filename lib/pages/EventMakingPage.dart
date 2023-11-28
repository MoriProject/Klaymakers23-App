import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:intl/intl.dart';

class EventMakingPage extends StatefulWidget {
  const EventMakingPage({Key? key}) : super(key: key);

  @override
  EventMakingPageHome createState() => EventMakingPageHome();
}

class EventMakingPageHome extends State<EventMakingPage> with TickerProviderStateMixin {
  static final GlobalKey<ScaffoldState> globalKey = GlobalKey();
  var value = 'Overview';
  //이미지 선택
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

  double totalPrizeAmount = 0;

  List<double> selectedBudgets = List.filled(1, 0, growable: true);
  List<int> selectedParticipants = List.filled(1, 0, growable: true);
  List<String> selectedDistributionMethod = List.filled(1, '', growable: true);
  TextEditingController budgetTextController = TextEditingController();
  TextEditingController titleTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  TextEditingController rulesTextController = TextEditingController();
  TextEditingController judgingTextController = TextEditingController();

  ///몇 등까지 수상을 할 것인지 저장하는 변수
  int numberOfPrizes = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    budgetTextController.dispose();
    titleTextController.dispose();
    descriptionTextController.dispose();
    rulesTextController.dispose();
    judgingTextController.dispose();
    super.dispose();
  }

  void _updateBudget(int index) async {
    TextEditingController controller = TextEditingController();
    final inputBudget = await showDialog<double>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter Budget'),
        content: TextField(
          controller: controller,
          autofocus: true,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(
            hintText: 'Enter new budget',
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text('Update'),
            onPressed: () {
              final double? enteredBudget = double.tryParse(controller.text);
              if (enteredBudget != null) {
                Navigator.of(context).pop(enteredBudget);
              }
            },
          ),
        ],
      ),
    );
    if (inputBudget != null) {
      setState(() {
        selectedBudgets[index] = inputBudget;
      });
      _updateTotalPrizeAmount();
      print(selectedBudgets);
    }
  }

  void _updateParticipants(int index) async {
    TextEditingController controller = TextEditingController();
    final inputParticipants = await showDialog<int>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter participant'),
        content: TextField(
          controller: controller,
          autofocus: true,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(
            hintText: 'Enter participant',
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text('Update'),
            onPressed: () {
              final int? enteredBudget = int.tryParse(controller.text);
              if (enteredBudget != null) {
                Navigator.of(context).pop(enteredBudget);
              }
            },
          ),
        ],
      ),
    );
    if (inputParticipants != null) {
      setState(() {
        selectedParticipants[index] = inputParticipants;
      });
      _updateTotalPrizeAmount();
      print(selectedParticipants);
    }
  }

  void _updateTotalPrizeAmount() {
    double amount = 0;
    print('_updateTotalPrizeAmount');
    for(int i = 0 ; i < numberOfPrizes ; i++) {
      amount += selectedParticipants[i] * selectedBudgets[i];
    }
    print('totalPrizeAmount : $amount');
    setState(() {
      totalPrizeAmount = amount;
    });
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
                  const Text(
                    "Hackathon title",
                    style: TextStyle(fontSize: 16),
                  ),
                  TextField(
                    controller: titleTextController,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Description of hacking",
                    style: TextStyle(fontSize: 16),
                  ),
                  TextField(
                    controller: descriptionTextController,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Hackathon Image",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  //버튼의 InkWell이 카드의 전체로 퍼집니다.
                  _pickedImages.isEmpty ?
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

                  ) :
                  GestureDetector(
                    onTap: () {
                      getImage(ImageSource.gallery);
                    },
                    child: SizedBox(
                      height: 200,
                      width: widths,
                      child: Image.file(
                        File(_pickedImages[0]!.path),
                        fit: BoxFit.cover,
                      ),
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
                  ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: numberOfPrizes,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Prize ${index + 1}.'),
                            Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Text('A total of'),
                                      const SizedBox(width: 10,),
                                      ElevatedButton(
                                        onPressed: () {
                                          _updateBudget(index);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.white70,
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(25.0),
                                          ),
                                          side: const BorderSide(color: Colors.blue),
                                        ),
                                        child: Text(
                                          '\$ ${NumberFormat('#,##0', 'en_US').format(selectedBudgets[index])}',
                                          style: const TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10,),
                                      const Text('in prize money'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text('will be'),
                                      const SizedBox(width: 10,),
                                      PopupMenuButton<String>(
                                        onSelected: (String value) {
                                          // Handle the selection
                                          print(value);
                                          selectedDistributionMethod[index] = value;
                                        },
                                        itemBuilder: (BuildContext context) =>
                                        <PopupMenuEntry<String>>[
                                          const PopupMenuItem<String>(
                                            value: 'Option 1',
                                            child: Text('Option 1'),
                                          ),
                                          const PopupMenuItem<String>(
                                            value: 'Option 2',
                                            child: Text('Option 2'),
                                          ),
                                          const PopupMenuItem<String>(
                                            value: 'Option 3',
                                            child: Text('Option 3'),
                                          ),
                                          // Add more PopupMenuItem widgets as needed
                                        ],
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.white70,
                                            // Replace with your desired color
                                            borderRadius: BorderRadius.circular(30),
                                            // boxShadow: [
                                            //   BoxShadow(
                                            //     color: Colors.black45,
                                            //     blurRadius: 4,
                                            //     offset: Offset(2, 2),
                                            //   ),
                                            // ],
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            // To minimize the container's size
                                            children: const [
                                              Text(
                                                'equally distributed',
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                  // Replace with your desired text color
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors
                                                    .grey, // Replace with your desired icon color
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('among'),
                                      SizedBox(width: 10,),
                                      ElevatedButton(
                                        onPressed: () {
                                          _updateParticipants(index);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.white70,
                                          padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(25.0),
                                          ),
                                          side: const BorderSide(color: Colors.blue),
                                        ),
                                        child: Text(
                                          '${selectedParticipants[index]}',
                                          style: const TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Text('participants.'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Divider(),
                          ],
                        );
                      }
                  ),
                  // SizedBox(
                  //   height: 200,
                  //
                  //   child: ListView.separated(
                  //     scrollDirection: Axis.vertical,
                  //
                  //     //shrinkWrap: true,
                  //     padding: const EdgeInsets.all(2.0),
                  //     itemCount: prizeNum.length,
                  //     itemBuilder: (BuildContext context, int i){
                  //       var widths = MediaQuery.of(context).size.width;
                  //       var heights = MediaQuery.of(context).size.height;
                  //
                  //       //(BuildContext context, widths, prizeNum, budget, NumOfParti)
                  //
                  //
                  //       return PrizeWidget(context, widths, i+1, budget[i], numOfParti[i]);
                  //
                  //     },
                  //     separatorBuilder: (BuildContext context, int index) {
                  //       return Divider();
                  //     },
                  //
                  //
                  //   ),
                  //
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                          child: Card(
                            color: Colors.lightBlueAccent,
                            child: IconButton(onPressed: (){
                              setState(() {
                                selectedBudgets.add(0);
                                selectedDistributionMethod.add('');
                                selectedParticipants.add(0);
                                numberOfPrizes++;
                              });
                            }, icon: const Icon(Icons.add)),
                          )
                      ),
                      SizedBox(
                          child: Card(
                            color: Colors.lightBlueAccent,
                            child: IconButton(onPressed: (){
                              setState(() {
                                numberOfPrizes--;
                              });
                            }, icon: const Icon(Icons.remove)),
                          )
                      ),
                    ],
                  ),


                  Text('Rules'),

                  TextField(
                    controller: rulesTextController,
                    maxLines: 6,
                    minLines: 6,
                  ),


                  Text('Judging createria'),
                  TextField(
                    controller: judgingTextController,
                    maxLines: 6,
                    minLines: 6,
                  ),
                  Row(
                    children: <Widget>[
                      Text('Need balance: \$ ${NumberFormat('#,##0', 'en_US').format(totalPrizeAmount)}'),
                    ],
                  ),
                  SizedBox(
                    width: widths,
                    child: Card(
                      color: Colors.lightBlueAccent,
                      child: TextButton(onPressed: (){}, child: Text('Hackathon creation')),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),

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
