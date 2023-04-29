class TransactionDto {
  final String name;
  final String date;
  final String sum;
  final String type;
  const TransactionDto(this.name, this.date, this.sum, this.type);

  TransactionDto.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        date = json['date'],
        sum = json['sum'],
        type = json['type'];
}
