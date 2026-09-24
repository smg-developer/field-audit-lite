import 'package:field_audit_lite/features/audits/data/datasources/audit_local_datasource.dart';
import 'package:field_audit_lite/features/audits/data/models/audit_model.dart';
import 'package:field_audit_lite/features/audits/domain/entities/audit.dart';
import 'package:field_audit_lite/features/audits/domain/repositories/audit_repository.dart';

class AuditRepoImpl implements AuditRepository {
  final AuditLocalDataSource localDataSource;

  AuditRepoImpl({required this.localDataSource});

  @override
  Future<List<Audit>> getAudits() async {
    return await localDataSource.getAudits();
  }

  @override
  Future<void> saveAudit(Audit audit) async {
    final model = AuditModel(
      id: audit.id,
      title: audit.title,
      siteName: audit.siteName,
      totalItems: audit.totalItems,
      completedItems: audit.completedItems,
      isSynced: audit.isSynced,
    );

    return localDataSource.saveAudit(model);
  }
}
