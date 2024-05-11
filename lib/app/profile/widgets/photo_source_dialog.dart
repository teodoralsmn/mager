import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mager/shared/font_style.dart';
import 'package:mager/shared/size_helper.dart';
import 'package:mager/shared/widgets/custom_button.dart';

class PhotoPickerSource extends StatelessWidget {
  final String? title;
  const PhotoPickerSource({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(margin16),
        margin: EdgeInsets.symmetric(horizontal: margin24),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: margin16),
              child: Text(
                'Pick Image Source',
                style: mainBody2.copyWith(
                    color: Colors.black87, fontWeight: FontWeight.bold),
              ),
            ),
            CustomButton(
              onTap: () {
                Navigator.pop(context, ImageSource.camera);
              },
              title: 'Camera',
            ),
            SizedBox(height: margin8),
            CustomButton(
              onTap: () {
                Navigator.pop(context, ImageSource.gallery);
              },
              title: 'Gallery',
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: margin16),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: mainBody4.copyWith(
                        color: Theme.of(context).primaryColor),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
