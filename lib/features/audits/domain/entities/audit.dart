class Audit {
  final String id;
  final String siteName;
  final String title;
  final int totalItems;
  final int completedItems;
  final bool isSynced;

  const Audit({
    required this.id,
    required this.siteName,
    required this.title,
    required this.totalItems,
    required this.completedItems,
    required this.isSynced,
  });

  bool get isCompleted => completedItems == totalItems;
}
