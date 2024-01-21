class ModelsModel {
  final String id;
  final int created;

  ModelsModel({required this.id, required this.created});

  factory ModelsModel.fromJson(Map<String, dynamic> json) =>
      ModelsModel(id: json['id'], created: json['created']);

  static List<ModelsModel> modelsFromSnapshot(List modelSnapshot) {
    return modelSnapshot.map((data) => ModelsModel.fromJson(data)).toList();
  }
}
