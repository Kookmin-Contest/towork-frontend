class MemberWorkspace {
  final int id;
  final String name;

  MemberWorkspace({required this.id, required this.name});

  factory MemberWorkspace.fromJson(Map<String, dynamic> parsedJson) {
    return MemberWorkspace(
      id: parsedJson['id'],
      name: parsedJson['workspaceName'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "workspaceName": name,
      };
}
