import 'package:field_audit_lite/features/audits/data/repositories/audit_repo_impl.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:field_audit_lite/features/audits/data/datasources/audit_local_datasource.dart';
import 'package:field_audit_lite/features/audits/domain/entities/audit.dart';

class FakeAuditLocalDataSource extends AuditLocalDataSource {
  final List<Audit> auditsToReturn;
  FakeAuditLocalDataSource(this.auditsToReturn);

  @override
  Future<List<Audit>> getAudits() async {
    return auditsToReturn;
  }

  @override
  Future<void> saveAudit(Audit audit) async {
    auditsToReturn.add(audit);
  }
}

void main() {
  test(
    'Check when datasource returns audits, they are properly fetched from repository',
    () async {
      Audit audit = Audit(
        id: '1',
        title: 'Test Audit 1',
        siteName: 'Mumbai',
        totalItems: 3,
        isSynced: false,
        checklist: [true, false, true],
      );

      Audit audit2 = Audit(
        id: '2',
        title: 'Test Audit 2',
        siteName: 'Thane',
        totalItems: 3,
        isSynced: false,
        checklist: [false, false, false],
      );

      FakeAuditLocalDataSource fakeDataSource = FakeAuditLocalDataSource([
        audit,
        audit2,
      ]);

      final repository = AuditRepoImpl(localDataSource: fakeDataSource);
      List<Audit> result = await repository.getAudits();

      expect(result.length, 2);
      expect(result[0].id, '1');
      expect(result[1].id, '2');
    },
  );

  test(
    'Check when datasource returns empty list of audits, they are properly fetched from repository',
    () async {
      FakeAuditLocalDataSource fakeDataSource = FakeAuditLocalDataSource([]);

      final repository = AuditRepoImpl(localDataSource: fakeDataSource);
      List<Audit> result = await repository.getAudits();

      expect(result.length, 0);
      expect(result.isEmpty, true);
    },
  );

  test(
    'Check when user saves audit it is properly saved to local data source',
    () async {
      Audit audit = Audit(
        id: '1',
        title: 'Test Audit 1',
        siteName: 'Mumbai',
        totalItems: 3,
        isSynced: false,
        checklist: [true, false, true],
      );

      FakeAuditLocalDataSource fakeDataSource = FakeAuditLocalDataSource([]);
      final repository = AuditRepoImpl(localDataSource: fakeDataSource);

      await repository.saveAudit(audit);

      List<Audit> result = await repository.getAudits();
      expect(result.length, 1);
      expect(result[0].id, '1');
    },
  );

  test(
    'Check when user saves multiple audits it is properly saved to local data source',
    () async {
      Audit audit1 = Audit(
        id: '1',
        title: 'Test Audit 1',
        siteName: 'Mumbai',
        totalItems: 3,
        isSynced: false,
        checklist: [true, false, true],
      );

      Audit audit2 = Audit(
        id: '2',
        title: 'Test Audit 2',
        siteName: 'Thane',
        totalItems: 3,
        isSynced: false,
        checklist: [false, false, false],
      );

      FakeAuditLocalDataSource fakeDataSource = FakeAuditLocalDataSource([]);
      final repository = AuditRepoImpl(localDataSource: fakeDataSource);

      await repository.saveAudit(audit1);
      await repository.saveAudit(audit2);

      List<Audit> result = await repository.getAudits();
      expect(result.length, 2);
      expect(result[0].id, '1');
      expect(result[1].id, '2');
    },
  );

  test('Check when user saves no audit, empty list is returned', () async {
    FakeAuditLocalDataSource fakeDataSource = FakeAuditLocalDataSource([]);
    final repository = AuditRepoImpl(localDataSource: fakeDataSource);

    List<Audit> result = await repository.getAudits();
    expect(result.length, 0);
  });
}
