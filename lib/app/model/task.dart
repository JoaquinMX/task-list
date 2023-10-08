class Task {
  Task(this.title, {this.done = false, this.subtitle, this.description});

  Task.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    done = json["done"];
    subtitle = json["subtitle"];
    description = json["description"];
  }

  late final String title;
  late bool done;
  late String? subtitle;
  late String? description;

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "done": done,
      "subtitle": subtitle,
      "description": description
    };
  }
}