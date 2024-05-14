import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mager/app/home/home_main_vm.dart';
import 'package:mager/app/home/money_management_form_page.dart';
import 'package:mager/shared/font_style.dart';
import 'package:mager/shared/function/money_changer.dart';
import 'package:mager/shared/models/transaction_model.dart';
import 'package:mager/shared/size_helper.dart';
import 'package:mager/shared/theme_style.dart';
import 'package:stacked/stacked.dart';

class HomeMainPage extends StatelessWidget {
  const HomeMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeMainVM>.reactive(viewModelBuilder: () {
      return HomeMainVM();
    }, onViewModelReady: (model) {
      model.onLoadDataDaily(context);
    }, builder: (context, model, child) {
      return Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    vertical: margin16, horizontal: margin16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        model.onPrevAction(context);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).primaryColor),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                    Expanded(
                        child: Text(
                      model.getLabelDate(),
                      textAlign: TextAlign.center,
                      style: mainBodyFont(context, type: FontBodyType.body2)
                          .copyWith(fontWeight: FontWeight.bold),
                    )),
                    GestureDetector(
                      onTap: () {
                        model.onNextAction(context);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).primaryColor),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: isDarkTheme(context)
                                ? Colors.white30
                                : Colors.black38))),
                child: Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        model.onChangeIndex(context, 0);
                      },
                      child: Container(
                        padding: EdgeInsets.only(bottom: margin16),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 3,
                                    color: model.selectedIndex == 0
                                        ? Theme.of(context).primaryColor
                                        : Colors.transparent))),
                        child: Text('Daily',
                            style: mainBodyFont(context)
                                .copyWith(fontWeight: FontWeight.bold)),
                      ),
                    )),
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        model.onChangeIndex(context, 1);
                      },
                      child: Container(
                        padding: EdgeInsets.only(bottom: margin16),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 3,
                                    color: model.selectedIndex == 1
                                        ? Theme.of(context).primaryColor
                                        : Colors.transparent))),
                        child: Text('Monthly',
                            style: mainBodyFont(context)
                                .copyWith(fontWeight: FontWeight.bold)),
                      ),
                    )),
                  ],
                ),
              ),
              model.selectedIndex == 0
                  ? Expanded(
                      child: model.loadingDaily
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Theme.of(context).primaryColor,
                              ),
                            )
                          : model.dataDaily.isEmpty
                              ? Center(
                                  child: Text(
                                    'Data is not found',
                                    style: mainBodyFont(context),
                                  ),
                                )
                              : Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          bottom: margin16,
                                          top: margin16,
                                          left: margin16,
                                          right: margin16),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: margin16),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.green),
                                            child: Column(
                                              children: [
                                                Text(
                                                  'Income',
                                                  style: mainBody4.copyWith(
                                                      color: Colors.white),
                                                      
                                                ),
                                                Text(
                                                  model.getIncomeTotal(),
                                                  style: mainBody3.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          )),
                                          SizedBox(
                                            width: margin16,
                                          ),
                                          Expanded(
                                              child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: margin16),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.red),
                                            child: Column(
                                              children: [
                                                Text(
                                                  'Expenses',
                                                  style: mainBody4.copyWith(
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  model.getExpensesTotal(),
                                                  style: mainBody3.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ))
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        child: ListView(
                                      padding: EdgeInsets.zero,
                                      children: [
                                        Column(
                                          children: List.generate(
                                              model.dataDaily.length, (index) {
                                            TransactionModel data =
                                                model.dataDaily[index];
                                            return Container(
                                              padding: EdgeInsets.only(
                                                  left: margin16,
                                                  right: margin16,
                                                  top:
                                                      index == 0 ? 0 : margin16,
                                                  bottom: margin16),
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: isDarkTheme(
                                                                  context)
                                                              ? Colors.white24
                                                              : Colors
                                                                  .black26))),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 40,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: data.type == 0
                                                            ? Colors.green
                                                            : Colors.red),
                                                    alignment: Alignment.center,
                                                    child: Icon(
                                                      data.type == 0
                                                          ? Icons.download
                                                          : Icons.upload,
                                                      color: Colors.white,
                                                      size: 24,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: margin16,
                                                  ),
                                                  Expanded(
                                                      child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical:
                                                                    margin4,
                                                                horizontal:
                                                                    margin16),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor),
                                                        child: Text(
                                                          data.category,
                                                          style: mainBody5
                                                              .copyWith(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: margin4,
                                                      ),
                                                      Text(
                                                        moneyChanger(data.amount
                                                            .toDouble()),
                                                        style: mainBody3.copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: data.type ==
                                                                    0
                                                                ? Colors.green
                                                                : Colors.red),
                                                      ),
                                                      SizedBox(
                                                        height: margin4,
                                                      ),
                                                      Text(
                                                        data.notes ??
                                                            'No Notes',
                                                        style: mainBodyFont(
                                                                context,
                                                                type: FontBodyType
                                                                    .body5,
                                                                textOpacity:
                                                                    0.5)
                                                            .copyWith(
                                                                fontStyle: data
                                                                            .notes ==
                                                                        null
                                                                    ? FontStyle
                                                                        .italic
                                                                    : FontStyle
                                                                        .normal),
                                                      )
                                                    ],
                                                  ))
                                                ],
                                              ),
                                            );
                                          }),
                                        ),
                                        const SizedBox(
                                          height: 100,
                                        )
                                      ],
                                    ))
                                  ],
                                ))
                  : Expanded(
                      child: model.loadingMonthly
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Theme.of(context).primaryColor,
                              ),
                            )
                          : model.dataMonthly.isEmpty
                              ? Center(
                                  child: Text(
                                    'Data is not found',
                                    style: mainBodyFont(context),
                                  ),
                                )
                              : Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          bottom: margin16,
                                          top: margin16,
                                          left: margin16,
                                          right: margin16),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: margin16),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.green),
                                            child: Column(
                                              children: [
                                                Text(
                                                  'Income',
                                                  style: mainBody4.copyWith(
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  model.getIncomeTotal(),
                                                  style: mainBody3.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          )),
                                          SizedBox(
                                            width: margin16,
                                          ),
                                          Expanded(
                                              child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: margin16),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.red),
                                            child: Column(
                                              children: [
                                                Text(
                                                  'Expenses',
                                                  style: mainBody4.copyWith(
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  model.getExpensesTotal(),
                                                  style: mainBody3.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ))
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        child: ListView(
                                      padding: EdgeInsets.zero,
                                      children: [
                                        Column(
                                          children: List.generate(
                                              model.dataMonthly.length,
                                              (index) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: isDarkTheme(
                                                                  context)
                                                              ? Colors.white24
                                                              : Colors
                                                                  .black26))),
                                              child: ExpansionTile(
                                                title: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      model.dataMonthly[index]
                                                          .date,
                                                      style: mainBodyFont(
                                                              context)
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                    SizedBox(
                                                      height: margin4,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                            child: Column(
                                                          children: [
                                                            Text(
                                                              'Income',
                                                              style: mainBody4
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .green),
                                                            ),
                                                            Text(
                                                                model.getIncomeByListTransaction(model
                                                                    .dataMonthly[
                                                                        index]
                                                                    .data),
                                                                style: mainBody4.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .green))
                                                          ],
                                                        )),
                                                        Expanded(
                                                            child: Column(
                                                          children: [
                                                            Text(
                                                              'Expenses',
                                                              style: mainBody4
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .red),
                                                            ),
                                                            Text(
                                                                model.getExpensesByListTransaction(model
                                                                    .dataMonthly[
                                                                        index]
                                                                    .data),
                                                                style: mainBody4.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .red))
                                                          ],
                                                        ))
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                children: [
                                                  Column(
                                                    children: List.generate(
                                                        model
                                                            .dataMonthly[index]
                                                            .data
                                                            .length, (index2) {
                                                      TransactionModel data =
                                                          model
                                                              .dataMonthly[
                                                                  index]
                                                              .data[index2];
                                                      return Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: margin16,
                                                                right: margin16,
                                                                top: index == 0
                                                                    ? 0
                                                                    : margin16,
                                                                bottom:
                                                                    margin16),
                                                        decoration: BoxDecoration(
                                                            border: Border(
                                                                bottom: BorderSide(
                                                                    color: isDarkTheme(
                                                                            context)
                                                                        ? Colors
                                                                            .white24
                                                                        : Colors
                                                                            .black26))),
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              width: 40,
                                                              height: 40,
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  color: data.type ==
                                                                          0
                                                                      ? Colors
                                                                          .green
                                                                      : Colors
                                                                          .red),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Icon(
                                                                data.type == 0
                                                                    ? Icons
                                                                        .download
                                                                    : Icons
                                                                        .upload,
                                                                color: Colors
                                                                    .white,
                                                                size: 24,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: margin16,
                                                            ),
                                                            Expanded(
                                                                child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  padding: EdgeInsets.symmetric(
                                                                      vertical:
                                                                          margin4,
                                                                      horizontal:
                                                                          margin16),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColor),
                                                                  child: Text(
                                                                    data.category,
                                                                    style: mainBody5
                                                                        .copyWith(
                                                                            color:
                                                                                Colors.white),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      margin4,
                                                                ),
                                                                Text(
                                                                  moneyChanger(data
                                                                      .amount
                                                                      .toDouble()),
                                                                  style: mainBody3.copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: data.type == 0
                                                                          ? Colors
                                                                              .green
                                                                          : Colors
                                                                              .red),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      margin4,
                                                                ),
                                                                Text(
                                                                  data.notes ??
                                                                      'No Notes',
                                                                  style: mainBodyFont(
                                                                          context,
                                                                          type: FontBodyType
                                                                              .body5,
                                                                          textOpacity:
                                                                              0.5)
                                                                      .copyWith(
                                                                          fontStyle: data.notes == null
                                                                              ? FontStyle.italic
                                                                              : FontStyle.normal),
                                                                )
                                                              ],
                                                            ))
                                                          ],
                                                        ),
                                                      );
                                                    }),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                        ),
                                        const SizedBox(
                                          height: 100,
                                        )
                                      ],
                                    ))
                                  ],
                                )),
            ],
          ),
          Positioned(
            bottom: 100,
            right: margin16,
            child: GestureDetector(
              onTap: () async {
                bool? result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const MoneyManagementFormPage()));

                if (result != null && context.mounted) {
                  if (model.selectedIndex == 0) {
                    model.onLoadDataDaily(context);
                  } else {
                    model.onLoadDataMonthly(context);
                  }
                }
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      );
    });
  }
}
