class WorkspaceInfo {
  final int id;
  final String name;

  WorkspaceInfo({required this.id, required this.name});

  factory WorkspaceInfo.fromJson(Map<String, dynamic> parsedJson) {
    return WorkspaceInfo(
      id: parsedJson['id'],
      name: parsedJson['workspaceName'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "workspaceName": name,
      };
}
