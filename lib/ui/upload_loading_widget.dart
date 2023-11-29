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
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                        padding:
                        EdgeInsets.all(8.0),
                        child: Text(
                            'Uploading to the potato server...\nPlease wait a moment.\nNever close the screen!'))
                  ],
                ),
              );
            },
          ),
        );
      });
}