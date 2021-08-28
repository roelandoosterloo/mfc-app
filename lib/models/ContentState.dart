enum ContentState {
  LIVE,
  DRAFT,
  PENDING,
  OFFLINE,
}

extension ContentStateExtension on ContentState {
  String get name {
    return this.toString().split(".").last;
  }

  static ContentState byString(String name) {
    return ContentState.values.firstWhere((element) => element.name == name);
  }
}
