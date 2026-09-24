import 'package:field_audit_lite/features/audits/data/datasources/audit_local_datasource.dart';
import 'package:field_audit_lite/features/audits/data/repositories/audit_repo_impl.dart';
import 'package:field_audit_lite/features/audits/domain/entities/audit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final auditsRepositoryProvider = Provider((ref) {
  return AuditRepoImpl(localDataSource: AuditLocalDataSource());
});

final auditsProvider = FutureProvider<List<Audit>>((ref) async {
  final repository = ref.read(auditsRepositoryProvider);
  return repository.getAudits();
});
