import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:intl/intl.dart';

class EditEventScreen extends StatefulWidget {
  const EditEventScreen({Key? key}) : super(key: key);

  @override
  EventMakingPageHome createState() => EventMakingPageHome();
}

class EventMakingPageHome extends State<EditEventScreen> with TickerProviderStateMixin {
  static final GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();
  var value = 'Overview';
  //이미지 선택
  final ImagePicker _picker = ImagePicker();
  final List<XFile?> _pickedImages = [];

  //단일 이미지 선택
  void getImage(ImageSource source) async {
    _pickedImages.clear();
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _pickedImages.add(image);
      });
    }
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

  void _showHackathonConfirmationDialog() async {
    showDialog(
      context: context,
      builder: (contextDialog) => AlertDialog(
        title: const Text('Are you sure you want to edit your hackation?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text('Edit', style: TextStyle(color: Colors.blue),),
            onPressed: () {
              Navigator.pop(contextDialog);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var widths = MediaQuery.of(context).size.width;
    var heights = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                          child: Image.network('https://hidamarirhodonite.kirara.ca/spread/200297.png'),
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
                    Text('Rules'),

                    TextField(
                      controller: rulesTextController,
                      maxLines: 6,
                      minLines: 1,
                    ),


                    Text('Judging createria'),
                    TextField(
                      controller: judgingTextController,
                      maxLines: 6,
                      minLines: 1,
                    ),
                  ],
                ),
              )
          ),
        bottomNavigationBar:  BottomAppBar(
          height: 95,
          color: Colors.grey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  'Monitor Girlfriend 2023 - Main Track',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('CLOSE IN', style: TextStyle(fontSize: 15),),
                        Text('7d:10h:39m', style: TextStyle(fontSize: 15),),
                      ],
                    ),
                  ),
                  TextButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.blue),
                    ),
                      onPressed: () {
                        _showHackathonConfirmationDialog();
                      },
                      child: const Text('Save', style: TextStyle(color: Colors.white),),
                  )
                ],
              )
            ],
          ),
        ),
      ),
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
