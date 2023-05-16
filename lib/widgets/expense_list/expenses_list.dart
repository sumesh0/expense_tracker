import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widgets/expense_list/expenses_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {required this.onRemoveExpense, required this.expenses, super.key});

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, i) => Dismissible(
        key: ValueKey(expenses[i]),
          onDismissed: (direction) {
            onRemoveExpense(expenses[i]);
          },
          child: ExpenseItem(expenses[i])),
    );
  }
}
