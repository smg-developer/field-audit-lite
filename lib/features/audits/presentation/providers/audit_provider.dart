import 'package:field_audit_lite/features/audits/data/datasources/audit_local_datasource.dart';
import 'package:field_audit_lite/features/audits/data/repositories/audit_repo_impl.dart';
import 'package:field_audit_lite/features/audits/domain/entities/audit.dart';
import 'package:field_audit_lite/features/audits/domain/repositories/audit_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final auditsRepositoryProvider = Provider((ref) {
  return AuditRepoImpl(localDataSource: AuditLocalDataSource());
});

// final auditsProvider = FutureProvider<List<Audit>>((ref) async {
//   final repository = ref.read(auditsRepositoryProvider);
//   return repository.getAudits();
// });

final auditsProvider = AsyncNotifierProvider<AuditNotifier, List<Audit>>(
  AuditNotifier.new,
);

class AuditNotifier extends AsyncNotifier<List<Audit>> {
  late final AuditRepository _repository;

  @override
  Future<List<Audit>> build() async {
    _repository = ref.read(auditsRepositoryProvider);

    return _repository.getAudits();
  }

  Future<void> addAudit(Audit audit) async {
    await _repository.saveAudit(audit);

    final audits = await _repository.getAudits();

    state = AsyncData(audits);
  }

  Future<void> updateAudit(Audit audit) async {
    await _repository.saveAudit(audit);

    final audits = await _repository.getAudits();

    state = AsyncData(audits);
  }
}
