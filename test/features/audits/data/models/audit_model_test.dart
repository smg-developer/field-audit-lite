import 'package:field_audit_lite/features/audits/data/models/audit_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Create Audit model from json', () {
    const auditJSON = {
      'id': '1',
      'siteName': 'Site A',
      'title': 'Audit 1',
      'totalItems': 5,
      'isSynced': false,
      'checklist': [true, false, true, false, true],
    };

    AuditModel auditModel = AuditModel.fromJson(auditJSON);

    expect(auditModel, isA<AuditModel>());
    expect(auditModel.id, '1');
    expect(auditModel.siteName, 'Site A');
    expect(auditModel.title, 'Audit 1');
    expect(auditModel.totalItems, 5);
    expect(auditModel.isSynced, false);
    expect(auditModel.checklist, [true, false, true, false, true]);
  });

  test('convert AuditModel to json', () {
    AuditModel auditModel = AuditModel(
      id: '1',
      siteName: 'Site A',
      title: 'Audit 1',
      totalItems: 5,
      isSynced: false,
      checklist: [true, false, true, false, true],
    );

    final jsonResult = auditModel.toJson();

    expect(jsonResult, {
      'id': '1',
      'siteName': 'Site A',
      'title': 'Audit 1',
      'totalItems': 5,
      'isSynced': false,
      'checklist': [true, false, true, false, true],
    });
  });

  test('convert AuditModel to json and back to model', () {
    AuditModel auditModel = AuditModel(
      id: '1',
      siteName: 'Site A',
      title: 'Audit 1',
      totalItems: 5,
      isSynced: false,
      checklist: [true, false, true, false, true],
    );

    final jsonResult = auditModel.toJson();

    final convertedAuditModel = AuditModel.fromJson(jsonResult);

    expect(convertedAuditModel, isA<AuditModel>());
    expect(convertedAuditModel.id, '1');
    expect(convertedAuditModel.siteName, 'Site A');
    expect(convertedAuditModel.title, 'Audit 1');
    expect(convertedAuditModel.totalItems, 5);
    expect(convertedAuditModel.isSynced, false);
    expect(convertedAuditModel.checklist, [true, false, true, false, true]);
  });
}
