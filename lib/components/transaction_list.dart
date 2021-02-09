import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300, // essa propriedade é muito importante, pois tendo altura "infinita" isso geraria um erro
      child: transactions.isEmpty ? Column(
        children: <Widget>[
          Text(
            'Nenhuma Transação Cadastrada!',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 20), // espaço entre o texto e o container da imagem
          Container(
            height: 200,
            child: Image.asset(
              'assets/images/waiting.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ) : ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, index) { // economizamos memória renderizando apenas alguns itens na tela conforme a mesma é scrollada
          final tr = transactions[index];
          return Card(
            child: Row(
              children: <Widget>[
                Container(
                  // usar Container permite usar estilos (margin, padding, etc)
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColor, // pegar cor padrão do tema definido no MaterialApp (main.dart)
                      width: 2,
                    )
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'R\$ ${tr.value.toStringAsFixed(2)}', // interpolação e casas decimais
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.purple),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      tr.title,
                      style: Theme.of(context).textTheme.headline6,
                        // style: TextStyle(
                        //     fontWeight: FontWeight.bold,
                        //     fontSize: 16)
                    ),
                    Text(
                        DateFormat('d MMM y')
                            .format(tr.date), // do pacote intl - externo
                        style: TextStyle(color: Colors.grey)),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
