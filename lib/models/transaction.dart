class Transaction {
  final String id;
  final String title;
  final double value;
  final DateTime date;

  Transaction({ // as chaves indicam que estamos definindo os atributos nomeados
    this.id, 
    this.title,
    this.value,
    this.date
  });
}