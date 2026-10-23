import 'package:field_audit_lite/features/audits/data/repositories/audit_repo_impl.dart';
import 'package:field_audit_lite/features/audits/domain/repositories/audit_repository.dart';
import 'package:field_audit_lite/features/audits/presentation/providers/audit_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:field_audit_lite/features/audits/domain/entities/audit.dart';
import 'package:field_audit_lite/features/audits/presentation/screens/audit_detail_screen.dart';

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
    //_audits.removeWhere((audit) => audit.id == id);
  }

  List<Audit> get audits => List<Audit>.unmodifiable(_audits);
}

void main() {
  testWidgets('checking an item updates the completed count', (
    WidgetTester tester,
  ) async {
    // Arrange
    final audit = Audit(
      id: '1',
      title: 'Test Audit',
      siteName: 'Mumbai',
      totalItems: 3,
      isSynced: false,
      checklist: [true, false, false],
    );

    final fakeRepository = FakeAuditRepository([audit]);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [auditsRepositoryProvider.overrideWithValue(fakeRepository)],
        child: MaterialApp(home: AuditDetailScreen(audit: audit)),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('1/3 completed'), findsOneWidget);

    await tester.tap(find.byType(Checkbox).at(2));

    await tester.pumpAndSettle();

    expect(find.text('2/3 completed'), findsOneWidget);

    expect(fakeRepository.audits[0].checklist, [true, true, false]);
  });

  testWidgets('Test Select All checkbox', (WidgetTester tester) async {
    // Arrange
    final audit = Audit(
      id: '1',
      title: 'Test Audit',
      siteName: 'Mumbai',
      totalItems: 3,
      isSynced: false,
      checklist: [true, false, false],
    );

    final fakeRepository = FakeAuditRepository([audit]);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [auditsRepositoryProvider.overrideWithValue(fakeRepository)],
        child: MaterialApp(home: AuditDetailScreen(audit: audit)),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('1/3 completed'), findsOneWidget);

    await tester.tap(find.byType(Checkbox).at(0));

    await tester.pumpAndSettle();

    expect(find.text('3/3 completed'), findsOneWidget);

    expect(fakeRepository.audits[0].checklist, [true, true, true]);
  });

  testWidgets('When all checkboxes are checked uncheck Select All', (
    WidgetTester tester,
  ) async {
    // Arrange
    final audit = Audit(
      id: '1',
      title: 'Test Audit',
      siteName: 'Mumbai',
      totalItems: 3,
      isSynced: false,
      checklist: [true, true, true],
    );

    final fakeRepository = FakeAuditRepository([audit]);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [auditsRepositoryProvider.overrideWithValue(fakeRepository)],
        child: MaterialApp(home: AuditDetailScreen(audit: audit)),
      ),
    );

    await tester.pumpAndSettle();
    final progressFinder = find.byType(LinearProgressIndicator);
    final progressWidget = tester.widget<LinearProgressIndicator>(
      progressFinder,
    );

    expect(progressWidget.value, closeTo(3 / 3, 0.001));
    expect(find.text('3/3 completed'), findsOneWidget);

    await tester.tap(find.byType(Checkbox).at(0));

    await tester.pumpAndSettle();

    expect(find.text('0/3 completed'), findsOneWidget);

    expect(fakeRepository.audits[0].checklist, [false, false, false]);
    final upProgressWidget = tester.widget<LinearProgressIndicator>(
      progressFinder,
    );
    expect(upProgressWidget.value, closeTo(0 / 3, 0.001));
  });
}
