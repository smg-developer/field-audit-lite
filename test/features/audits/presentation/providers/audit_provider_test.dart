import 'package:field_audit_lite/features/audits/domain/entities/audit.dart';
import 'package:field_audit_lite/features/audits/domain/repositories/audit_repository.dart';
import 'package:field_audit_lite/features/audits/presentation/providers/audit_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

// Fake repository for testing
class FakeAuditRepository implements AuditRepository {
  final List<Audit> _audits;

  FakeAuditRepository([List<Audit>? initialAudits])
    : _audits = List<Audit>.from(initialAudits ?? []);

  @override
  Future<List<Audit>> getAudits() async {
    return List<Audit>.from(_audits);
  }

  @override
  Future<void> saveAudit(Audit audit) async {
    final index = _audits.indexWhere((item) => item.id == audit.id);

    if (index == -1) {
      _audits.add(audit);
    } else {
      _audits[index] = audit;
    }
  }

  @override
  Future<void> deleteAudit(String id) async {
    _audits.removeWhere((audit) => audit.id == id);
  }
}

void main() {
  final audit1 = Audit(
    id: '1',
    title: 'Test Audit 1',
    siteName: 'Mumbai',
    totalItems: 3,
    isSynced: false,
    checklist: [true, false, true],
  );

  final audit2 = Audit(
    id: '2',
    title: 'Test Audit 2',
    siteName: 'Pune',
    totalItems: 2,
    isSynced: false,
    checklist: [true, false],
  );

  group('AuditNotifier tests', () {
    // setUp(() {
    //   // Any setup code can go here
    //   final auditsRepositoryProvider = Provider<AuditRepository>((ref) {
    //     return AuditRepoImpl(localDataSource: AuditLocalDataSource());
    //   });
    // });

    test('Scenario 12: When provider loads audits successfully, '
        'its state contains the returned audits', () async {
      // Arrange
      final fakeRepository = FakeAuditRepository([audit1, audit2]);

      //auditsRepositoryProvider.overrideWith((ref) => fakeRepository);

      final container = ProviderContainer(
        overrides: [
          auditsRepositoryProvider.overrideWith((ref) => fakeRepository),
        ],
      );

      addTearDown(container.dispose);

      // Act
      final result = await container.read(auditsProvider.future);

      // Assert
      expect(result.length, 2);
      expect(result[0].id, '1');
      expect(result[1].id, '2');
    });

    test('Scenario 13: When repository returns no audits, '
        'provider exposes an empty list', () async {
      // Arrange
      final fakeRepository = FakeAuditRepository([]);

      final container = ProviderContainer(
        overrides: [
          auditsRepositoryProvider.overrideWith((ref) => fakeRepository),
        ],
      );

      addTearDown(container.dispose);

      // Act
      final result = await container.read(auditsProvider.future);

      // Assert
      expect(result, isEmpty);
    });

    test('Scenario 14: When a new audit is added, '
        'provider state reflects the addition', () async {
      // Arrange
      final fakeRepository = FakeAuditRepository([audit1]);

      final container = ProviderContainer(
        overrides: [
          auditsRepositoryProvider.overrideWith((ref) => fakeRepository),
        ],
      );

      addTearDown(container.dispose);

      // Ensure the initial state has loaded
      await container.read(auditsProvider.future);

      // Act
      await container.read(auditsProvider.notifier).addAudit(audit2);

      // Assert
      final result = container.read(auditsProvider).requireValue;

      expect(result.length, 2);
      expect(result.any((audit) => audit.id == '2'), isTrue);
    });

    test('Scenario 15: When an audit is deleted, '
        'provider state no longer contains it', () async {
      // Arrange
      final fakeRepository = FakeAuditRepository([audit1, audit2]);

      final container = ProviderContainer(
        overrides: [
          auditsRepositoryProvider.overrideWith((ref) => fakeRepository),
        ],
      );

      addTearDown(container.dispose);

      // Ensure the initial state has loaded
      await container.read(auditsProvider.future);

      // Act
      await container.read(auditsProvider.notifier).deleteAudit('1');

      // Assert
      final result = container.read(auditsProvider).requireValue;

      expect(result.length, 1);
      expect(result.any((audit) => audit.id == '1'), isFalse);
      expect(result.single.id, '2');
    });
  });
}
