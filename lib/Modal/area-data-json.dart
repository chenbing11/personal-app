class AreaDataToJson {
  String? id;
  String? name;
  String? center;
  int? level;
  List<Children>? children;

  AreaDataToJson({this.id, this.name, this.center, this.level, this.children});

  AreaDataToJson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    center = json['center'];
    level = json['level'];
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(new Children.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['center'] = this.center;
    data['level'] = this.level;
    if (this.children != null) {
      data['children'] = this.children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Children {
  String? id;
  String? name;
  String? center;
  int? level;

  Children({this.id, this.name, this.center, this.level});

  Children.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    center = json['center'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['center'] = this.center;
    data['level'] = this.level;
    return data;
  }
}
