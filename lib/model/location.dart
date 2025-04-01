class Location {
  final String id;
  final String capital_city;
  final String country;
  final int province;

  Location({required this.id, required this.capital_city, required this.country, required this.province});

  @override
  bool operator ==(Object other) {
    return other is Location && other.id == id ;
  }

  @override
  int get hashCode => super.hashCode ^ id.hashCode ;
}
