import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

loadingWidget(context){
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: StatefulBuilder(
            builder: (BuildContext context,
                StateSetter setState) {
              return const SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                        padding:
                        EdgeInsets.all(8.0),
                        child: Text(
                            'Uploading to the potato server...\nPlease wait a moment.\nNever close the screen!',
                          style: TextStyle(
                            overflow: TextOverflow.fade,
                          ),
                        ))
                  ],
                ),
              );
            },
          ),
        );
      });
}


NotiWidget(context){

  showDialog(
      context: context,
      builder: ((context) => AlertDialog(
        title: Text('warning'),
        content: Text("Are you sure you want to complete determining the winner?"),
        actions: [
          TextButton(
            onPressed: (){
              loadingWidget(context);
            },
            child: Text('Yes'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('No'),
          ),
        ],
      )));


}