import 'dart:io';

import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    // TODO: implement createState
    return _StateNewState();
  }
}

class _StateNewState extends State<NewExpense> {
  /*
  Cách 1
  var _enteredTitle = '';

  void _savetitleInput(String inputValue) {
    _enteredTitle = inputValue;
  }
  */

  // Cách 2
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialog() {

    if(Platform.isIOS) 
      showCupertinoDialog(
          context: context,
          builder: (ctx) {
            return CupertinoAlertDialog(
                title: Text('Invalid input'),
                content: Text("Please input again!"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: Text("OK"))
                ]);
          });
    else 
      showDialog(
          context: context,
          builder: ((ctx) => AlertDialog(
                title: Text('Invalid input'),
                content: Text("Please input again!"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: Text("OK"))
                ],
              )));
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountInvalid ||
        _selectedDate == null) {
      _showDialog();
      return;
    }

    widget.onAddExpense(Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory));

    Navigator.pop(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
    _amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          // Cách 1
                          // onChanged: _savetitleInput,

                          controller: _titleController,
                          maxLength: 50,
                          decoration: InputDecoration(
                            label: Text('Title'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: TextField(
                          // Cách 1
                          // onChanged: _savetitleInput,

                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixText: '\$ ',
                            label: Text('Amount'),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    // Cách 1
                    // onChanged: _savetitleInput,

                    controller: _titleController,
                    maxLength: 50,
                    decoration: InputDecoration(
                      label: Text('Title'),
                    ),
                  ),
                if (width >= 600)
                  Row(
                    children: [
                      DropdownButton(
                          value: _selectedCategory,
                          items: Category.values
                              .map((category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(
                                      category.name.toString().toUpperCase())))
                              .toList(),
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() {
                              _selectedCategory = value;
                            });
                          }),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(_selectedDate == null
                                ? "No date selected!"
                                : formatter.format(_selectedDate!)),
                            IconButton(
                                onPressed: _presentDatePicker,
                                icon: Icon(Icons.calendar_month))
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          // Cách 1
                          // onChanged: _savetitleInput,

                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            prefixText: '\$ ',
                            label: Text('Amount'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(_selectedDate == null
                                ? "No date selected!"
                                : formatter.format(_selectedDate!)),
                            IconButton(
                                onPressed: _presentDatePicker,
                                icon: Icon(Icons.calendar_month))
                          ],
                        ),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 16,
                ),
                if (width >= 600)
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancel")),
                      ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: Text("Save exchange"))
                    ],
                  )
                else
                  Row(
                    children: [
                      DropdownButton(
                          value: _selectedCategory,
                          items: Category.values
                              .map((category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(
                                      category.name.toString().toUpperCase())))
                              .toList(),
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() {
                              _selectedCategory = value;
                            });
                          }),
                      const Spacer(),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancel")),
                      ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: Text("Save exchange"))
                    ],
                  )
              ],
            ),
          ),
        ),
      );
    });
  }
}
