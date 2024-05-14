import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:mager/app/home/money_form_vm.dart';
import 'package:mager/shared/font_style.dart';
import 'package:mager/shared/size_helper.dart';
import 'package:mager/shared/widgets/custom_button.dart';
import 'package:mager/shared/widgets/custom_textfield.dart';
import 'package:mager/shared/widgets/status_bar_widget.dart';
import 'package:stacked/stacked.dart';

class MoneyManagementFormPage extends StatelessWidget {
  const MoneyManagementFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MoneyFormVM>.reactive(viewModelBuilder: () {
      return MoneyFormVM();
    }, builder: (context, model, child) {
      return StatusbarWidget(
          child: Scaffold(
        backgroundColor: model.selectedType == 0
            ? Colors.green.withOpacity(0.1)
            : Colors.red.withOpacity(0.1),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: margin16,
                  right: margin16,
                  top: MediaQuery.of(context).padding.top + margin16,
                  bottom: margin16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(
                    width: margin16,
                  ),
                  Text(
                    model.selectedType == 0 ? 'Income' : 'Expenses',
                    style: mainBody3.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black87),
                  )
                ],
              ),
            ),
            Expanded(
                child: ListView(
              padding: EdgeInsets.symmetric(horizontal: margin16),
              children: [
                Text(
                  'Type',
                  style: mainBody4.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: margin8,
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          model.onChangeType(0);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: margin24 / 2),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: model.selectedType == 0
                                  ? Colors.green
                                  : Colors.transparent,
                              border: Border.all(color: Colors.green)),
                          alignment: Alignment.center,
                          child: Text(
                            'Income',
                            style: mainBody4.copyWith(
                                fontWeight: FontWeight.bold,
                                color: model.selectedType == 0
                                    ? Colors.white
                                    : Colors.green),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: margin16,
                    ),
                    Flexible(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          model.onChangeType(1);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: margin24 / 2),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: model.selectedType == 1
                                  ? Colors.red
                                  : Colors.transparent,
                              border: Border.all(color: Colors.red)),
                          alignment: Alignment.center,
                          child: Text(
                            'Expenses',
                            style: mainBody4.copyWith(
                                fontWeight: FontWeight.bold,
                                color: model.selectedType == 1
                                    ? Colors.white
                                    : Colors.red),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: margin16,
                ),
                Text(
                  'Dates',
                  style: mainBody4.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: margin4,
                ),
                GestureDetector(
                  onTap: () {
                    model.onChangeDate(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: margin8),
                    decoration: const BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Colors.black54))),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          DateFormat('dd/MM/yyyy').format(model.selectedDate),
                          style: mainBody4.copyWith(color: Colors.black87),
                        )),
                        SizedBox(
                          width: margin8,
                        ),
                        const Icon(
                          Icons.date_range,
                          color: Colors.black54,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: margin16,
                ),
                Text(
                  'Amount',
                  style: mainBody4.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: margin4,
                ),
                CustomTextfield(
                  controller: model.amountController,
                  customStyle: mainBody4,
                  customHintStyle: mainBody4.copyWith(color: Colors.black38),
                  keyboardType: TextInputType.number,
                  hintText:
                      'Enter ${model.selectedType == 0 ? 'Income' : 'Expenses'} Amount..',
                  inputFormatters: [
                    CurrencyTextInputFormatter.currency(
                        decimalDigits: 0, locale: 'id', symbol: '')
                  ],
                ),
                SizedBox(
                  height: margin16,
                ),
                Text(
                  'Category',
                  style: mainBody4.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: margin4,
                ),
                GestureDetector(
                  onTap: () {
                    model.onPickCategory(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: margin8),
                    decoration: const BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Colors.black54))),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          model.selecetedCategory ?? 'Pick Category..',
                          style: mainBody4.copyWith(
                              color: model.selecetedCategory == null
                                  ? Colors.black54
                                  : Colors.black87),
                        )),
                        SizedBox(
                          width: margin8,
                        ),
                        const Icon(
                          Icons.arrow_drop_down_rounded,
                          color: Colors.black54,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: margin16,
                ),
                Text(
                  'Notes',
                  style: mainBody4.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: margin4,
                ),
                CustomTextfield(
                  controller: model.notesController,
                  customStyle: mainBody4,
                  customHintStyle: mainBody4.copyWith(color: Colors.black38),
                  hintText: 'Enter Notes..',
                  maxLines: 4,
                ),
                SizedBox(
                  height: margin64,
                ),
                CustomButton(
                  onTap: () {
                    model.onSave(context);
                  },
                  title: 'Save',
                ),
                SizedBox(
                  height: margin32,
                ),
              ],
            ))
          ],
        ),
      ));
    });
  }
}
