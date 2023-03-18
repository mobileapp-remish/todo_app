class TaskModel {
  late String _id;
  late String _name;
  late String _description;
  late String _date;

  String get id => _id;

  String get name => _name;

  set setName(String name) => _name = name;

  String get description => _description;

  set setDescription(String description) => _description = description;

  String get date => _date;

  set setDate(String date) => _date = date;

  TaskModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _date = json['date'];
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': _id,
      'name': _name,
      'description': _description,
      'date': _date,
    };
  }
}
