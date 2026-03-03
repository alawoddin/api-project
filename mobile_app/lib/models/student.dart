class Student {
  final int id;
  final String name;
  final String fname;

  Student({required this.id, required this.name, required this.fname});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(id: json['id'], name: json['name'], fname: json['fname']);
  }
}
