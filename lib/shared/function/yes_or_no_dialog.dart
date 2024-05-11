import 'package:flutter/material.dart';
import 'package:mager/shared/font_style.dart';
import 'package:mager/shared/size_helper.dart';

Future<bool> yesOrNoDialog(BuildContext context,
    {required String title,
    required String desc,
    String? customYes,
    double? customSizeYes,
    double? customSizeNo,
    String? customNo}) async {
  bool? result = await showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black12,
              alignment: Alignment.center,
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: EdgeInsets.all(margin16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: mainFont.copyWith(
                            fontSize: 15,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: margin24 / 2),
                      Text(
                        desc,
                        textAlign: TextAlign.center,
                        style: mainFont.copyWith(
                          fontSize: 13,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: margin24 / 2),
                      Row(children: [
                        Flexible(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    vertical: margin24 / 2),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Theme.of(context).primaryColor)),
                                child: Text(
                                  customNo ?? 'No',
                                  style: mainFont.copyWith(
                                      fontSize: customSizeNo ?? 13,
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                        SizedBox(width: margin8),
                        Flexible(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context, true);
                              },
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    vertical: margin24 / 2),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Theme.of(context).primaryColor),
                                alignment: Alignment.center,
                                child: Text(
                                  customYes ?? 'Yes',
                                  style: mainFont.copyWith(
                                      fontSize: customSizeYes ?? 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                      ])
                    ],
                  ))),
        );
      });

  return result != null;
}
