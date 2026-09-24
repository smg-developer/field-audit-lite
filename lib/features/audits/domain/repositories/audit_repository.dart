import 'package:field_audit_lite/features/audits/domain/entities/audit.dart';

abstract class AuditRepository {
  Future<List<Audit>> getAudits();
  
  Future<void> saveAudit(Audit audit);
}
