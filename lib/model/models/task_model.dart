class TaskModel {
  String? id;
  String? title;
  String? content;
  String? createAt;
  String? updateAt;

  TaskModel({
    required this.id,
    required this.title,
    required this.content,
    required this.createAt,
    required this.updateAt,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    content = json["content"];
    createAt = json["createAt"];
    updateAt = json["updateAt"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["title"] = title;
    data["content"] = content;
    data["createAt"] = createAt;
    data["updateAt"] = updateAt;
    return data;
  }
}
