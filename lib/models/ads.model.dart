class Ad {
  String? id;
  String? title;
  String? imageAssetPath;
  String? description;
  Ad();

  Ad.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imageAssetPath = json['imageAssetPath'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['imageAssetPath'] = imageAssetPath;
    data['description'] = description;
    return data;
  }
}
