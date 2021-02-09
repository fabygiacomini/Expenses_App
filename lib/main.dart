import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'models/transaction.dart';
import 'components/transaction_form.dart';
import 'components/transaction_list.dart';
import 'components/chart.dart';


main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple, // espectro de cores
        accentColor: Colors.amber[300], // cor de realce
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle( // title está depreciado (devemos usar headline no lugar)
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold
            )
          )
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold
          )
        )
      )
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> _transactions = [
    Transaction(
      id: 't0',
      title: 'Conta antiga',
      value: 400.76,
      date: DateTime.now().subtract(Duration(days: 33))
    ),
    Transaction(
      id: 't1',
      title: 'Novo Tênis de Corrida',
      value: 310.76,
      date: DateTime.now().subtract(Duration(days: 3))
    ),
    Transaction(
      id: 't2',
      title: 'Conta de Luz',
      value: 211.30,
      date: DateTime.now().subtract(Duration(days: 4))
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((transaction) {
      return transaction.date.isAfter(DateTime.now().subtract(
        Duration(days: 7) // pegaremos apenas as transações da última semana
      ));
    }).toList();
  }

  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );
  
    setState(() {
      _transactions.add(newTransaction);
    });
  
    Navigator.of(context).pop(); // fechar o primeiro elemento da pilha de telas (modal/tela)
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas Pessoais'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openTransactionFormModal(context),
          )
        ]
      ),
      body: SingleChildScrollView( // permite scroll na tela toda (se for em um componente, precisa de um tamanho definido)
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_transactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}