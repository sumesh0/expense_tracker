import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 16,),
      child: SizedBox(
        height: 70,
        //width: 35,
        child: Card(
          color: Colors.indigo.shade100,
          child: Column(
            children:[ 
              Text(expense.title,style: TextStyle(fontSize: 18),),
              const SizedBox(height: 4,),
              Row(
                children: [
                  Text('\$${expense.amount}',style: TextStyle(fontSize: 16,color: Colors.red.withOpacity(0.9),),),
                  const Spacer(),
                  Row(
                    children: [
                     Icon(categoryIcon[expense.category]),
                      const SizedBox(width: 8,),
                      Text(expense.dateFormatted),
                    ],
                  )
                ],
              ),
          ],),
        ),
      ),
    );
  }
} 