import 'package:flutter/material.dart';
import 'package:mager/app/settings/viewmodel/category_vm.dart';
import 'package:mager/shared/font_style.dart';
import 'package:mager/shared/size_helper.dart';
import 'package:mager/shared/widgets/custom_button.dart';
import 'package:mager/shared/widgets/status_bar_widget.dart';
import 'package:stacked/stacked.dart';

class CategoryPage extends StatelessWidget {
  final bool isPicker;
  const CategoryPage({super.key, this.isPicker = false});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CategoryVM>.reactive(viewModelBuilder: () {
      return CategoryVM();
    }, onViewModelReady: (model) {
      model.onLoadDataCategory(context);
    }, builder: (context, model, child) {
      return StatusbarWidget(
          customBrightness: Brightness.light,
          child: Scaffold(
            body: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + margin16,
                    bottom: margin16,
                  ),
                  decoration: const BoxDecoration(
                      color: Color(0xff436edb),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          bottomRight: Radius.circular(50))),
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Center(
                        child: Text(
                          'Category',
                          style: mainBody1.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Positioned(
                        left: margin32,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: model.isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                        : model.data.isEmpty
                            ? Center(
                                child: Text(
                                  'Data is Empty',
                                  style: mainBody4,
                                ),
                              )
                            : RefreshIndicator(
                                onRefresh: () async {
                                  model.onLoadDataCategory(context);
                                },
                                child: ListView(
                                  padding: EdgeInsets.zero,
                                  children:
                                      List.generate(model.data.length, (index) {
                                    return GestureDetector(
                                      onTap: () {
                                        if (isPicker) {
                                          Navigator.pop(context,
                                              model.data[index].category);
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: margin16,
                                            horizontal: margin16),
                                        decoration: const BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.black26))),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child: Text(
                                              model.data[index].category,
                                              style: mainBodyFont(context)
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            )),
                                            SizedBox(
                                              width: margin8,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                model.onDeleteCategory(
                                                    context, model.data[index]);
                                              },
                                              child: Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color: Colors.red),
                                                child: const Icon(
                                                  Icons.delete,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              )),
                Container(
                  padding: EdgeInsets.all(margin16),
                  child: CustomButton(
                    onTap: () {
                      model.onCategoryAdd(context);
                    },
                    title: 'Add Category',
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).padding.bottom,
                )
              ],
            ),
          ));
    });
  }
}
