class Audit {
  final String id;
  final String siteName;
  final String title;
  final int totalItems;
  final bool isSynced;
  final List<bool> checklist;

  const Audit({
    required this.id,
    required this.siteName,
    required this.title,
    required this.totalItems,
    required this.isSynced,
    required this.checklist,
  });

  int get completedItems => checklist.where((item) => item).length;

  bool get isCompleted => checklist.isNotEmpty && completedItems == totalItems;
}
