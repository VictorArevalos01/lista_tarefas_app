class Todo{

  Todo({required this.title, required this.date});

  String title;
  DateTime date;

  Todo.fromJson(Map<String, dynamic> json)
    : title = json['title'],
    date = DateTime.parse(json['date']);


  Map<String,dynamic> toJson(){
    return{
      'title': title,
      'date': date.toIso8601String()
    };
  }

}