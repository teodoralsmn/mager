import 'package:flutter/material.dart';
import 'package:mager/shared/font_style.dart';
import 'package:mager/shared/function/show_snackbar.dart';
import 'package:mager/shared/size_helper.dart';
import 'package:mager/shared/widgets/custom_textfield.dart';

class CategoryFormDialog extends StatefulWidget {
  final String? initData;
  const CategoryFormDialog({super.key, this.initData});

  @override
  State<CategoryFormDialog> createState() => _CategoryFormDialogState();
}

class _CategoryFormDialogState extends State<CategoryFormDialog> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    if (widget.initData != null) {
      setState(() {
        controller.text = widget.initData!;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          padding: EdgeInsets.all(margin16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).scaffoldBackgroundColor),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Category',
                style: mainBodyFont(context, type: FontBodyType.body3)
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: margin16,
              ),
              CustomTextfield(
                controller: controller,
                hintText: 'Enter Category..',
              ),
              SizedBox(
                height: margin24,
              ),
              Row(children: [
                Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: margin24 / 2),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Theme.of(context).primaryColor)),
                        child: Text(
                          'Cancel',
                          style: mainFont.copyWith(
                              fontSize: 13,
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
                        if (controller.text.isEmpty) {
                          showSnackbar(context,
                              message: 'Please enter category',
                              customColor: Colors.orange);
                        } else {
                          Navigator.pop(context, controller.text);
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: margin24 / 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).primaryColor),
                        alignment: Alignment.center,
                        child: Text(
                          'Save',
                          style: mainFont.copyWith(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
