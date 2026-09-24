import 'package:field_audit_lite/features/audits/domain/entities/audit.dart';

class AuditModel extends Audit {
  const AuditModel({
    required super.id,
    required super.siteName,
    required super.title,
    required super.totalItems,
    required super.completedItems,
    required super.isSynced,
  });

  factory AuditModel.fromJson(Map<String, dynamic> json) {
    return AuditModel(
      id: json['id'] as String,
      title: json['title'] as String,
      siteName: json['siteName'] as String,
      totalItems: json['totalItems'] as int,
      completedItems: json['completedItems'] as int,
      isSynced: json['isSynced'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'siteName': siteName,
      'totalItems': totalItems,
      'completedItems': completedItems,
      'isSynced': isSynced,
    };
  }
}
