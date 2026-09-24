import 'dart:convert';

import 'package:field_audit_lite/features/audits/data/models/audit_model.dart';
import 'package:field_audit_lite/features/audits/domain/entities/audit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuditLocalDataSource {
  static const String _auditsKey = 'audits';

  Future<List<Audit>> getAudits() async {
    // Implement the logic to retrieve audits from local storage
    final prefs = await SharedPreferences.getInstance();

    final auditJson = prefs.getString(_auditsKey);

    if (auditJson == null) {
      return [];
    }

    final List<dynamic> auditList = jsonDecode(auditJson);
    return auditList.map((json) {
      return AuditModel.fromJson(json as Map<String, dynamic>);
    }).toList();
  }

  Future<void> saveAudit(Audit audit) async {
    // Implement the logic to save the audit to local storage

    final audits = await getAudits();

    audits.removeWhere((auditItem) => auditItem.id == audit.id);

    audits.add(audit);

    final jsonList = audits.map((audit) {
      return (audit as AuditModel).toJson();
    }).toList();

    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_auditsKey, jsonEncode(jsonList));
  }
}
