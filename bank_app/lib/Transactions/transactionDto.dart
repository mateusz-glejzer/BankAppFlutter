class transaction_dto {
  final String name;
  final String date;
  final String sum;
  final String type;
  const transaction_dto(this.name, this.date, this.sum, this.type);

  transaction_dto.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        date = json['date'],
        sum = json['sum'],
        type = json['type'];
}
