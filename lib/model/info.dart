class Info {
  final String id;
  final String pw;

  Info({required this.id, required this.pw});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pw': pw,
    };
  }

  @override
  String toString() {
    return 'Info{id: $id, pw: $pw}';
  }
}