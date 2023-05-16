import 'package:expense_tracker/widgets/expense_list/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'flutter course',
        amount: '19.99',
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Cinema',
        amount: '15.69',
        date: DateTime.now(),
        category: Category.leisure)
  ];

  void openExpense() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => NewExpense(
        onAddExpense: addExpenses,
      ),
    );
  }

  void addExpenses(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    _registeredExpenses.remove(expense);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          duration: const Duration(seconds: 3),
          content: const Text("Expense Deleted"),
          action: SnackBarAction(label: 'Undo', onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          })
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent =
        const Center(child: Text("Enter expenses in the List"));

    if (_registeredExpenses.isNotEmpty) {
     mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            onPressed: openExpense,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: mainContent,
          )
        ],
      ),
    );
  }
}
