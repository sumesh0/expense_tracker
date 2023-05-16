import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;
  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final textController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? selectDate;
  Category selectedCategory = Category.leisure;

  void submitExpense() {
    final enterAmount = double.tryParse(amountController.text);
    final amountIsInvalid = enterAmount == null || enterAmount < 0;
    if (textController.text.trim().isEmpty ||
        amountIsInvalid ||
        selectDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Padding(
            padding: EdgeInsets.only(left: 60),
            child: Text("Invalid Input",
                style: TextStyle(
                  color: Colors.red,
                )),
          ),
          content: const Text("Please try to enter valid information"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text("Okay"),
            )
          ],
        ),
      );
    }
    widget.onAddExpense(
      Expense(
          title: textController.text,
          amount: amountController.text,
          date: selectDate!,
          category: selectedCategory),
    );
    Navigator.pop(context);
  }

  void presentDate() async {
    final now = DateTime.now();
    final first = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
        context: context, initialDate: now, firstDate: first, lastDate: now);
    setState(() {
      selectDate = pickedDate;
    });
  }

  @override
  void dispose() {
    textController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        TextField(
          controller: textController,
          maxLength: 50,
          decoration: const InputDecoration(
            labelText: 'Title',
            hintText: 'Enter Expense',
          ),
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: amountController,
                maxLength: 50,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  prefixText: '₹ ',
                  hintText: 'Enter Expense Amount',
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 30,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: presentDate,
                        icon: const Icon(Icons.calendar_month)),
                    Text(selectDate == null
                        ? "Date not selected"
                        : formatter.format(selectDate!)),
                  ],
                ),
              ),
            )
          ],
        ),
        Row(
          children: [
            DropdownButton(
              value: selectedCategory,
              items: Category.values
                  .map(
                    (category) => DropdownMenuItem(
                      value: category,
                      child: Text(
                        category.name.toUpperCase(),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                setState(() {
                  selectedCategory = value;
                });
              },
            ),
            const SizedBox(
              width: 300,
            ),
            ElevatedButton(
              onPressed: submitExpense,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.withOpacity(.8),
              ),
              child: const Text("Save Expense"),
            ),
            const SizedBox(
              width: 440,
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
          ],
        )
      ]),
    );
  }
}
