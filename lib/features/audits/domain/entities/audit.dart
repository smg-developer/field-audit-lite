class Audit {
  final String id;
  final String siteName;
  final String title;
  final int totalItems;
  final int completedItems;
  final bool isSynced;
  final List<bool> checklist;

  const Audit({
    required this.id,
    required this.siteName,
    required this.title,
    required this.totalItems,
    required this.completedItems,
    required this.isSynced,
    required this.checklist,
  });

  bool get isCompleted => completedItems == totalItems;
}
