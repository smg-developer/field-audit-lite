import 'package:flutter_test/flutter_test.dart';

import 'package:field_audit_lite/features/audits/domain/entities/audit.dart';

void main() {
  test('return number of completed items in an audit', () {
    const audit = Audit(
      id: 'aud_1',
      siteName: 'Mumbai',
      title: 'Audit 1',
      totalItems: 5,
      isSynced: false,
      checklist: [false, true, false, false, true],
    );
    final result = audit.completedItems;

    expect(result, 2);
  });

  test('Check if audit is incomplete', () {
    //Arrange
    const audit = Audit(
      id: 'aud_1',
      siteName: 'Mumbai',
      title: 'Audit 1',
      totalItems: 5,
      isSynced: false,
      checklist: [false, true, false, false, true],
    );

    //Act
    final result = audit.isCompleted;

    //Assert
    expect(result, false);
  });

  test('Check if audit is completed', () {
    //Arrange
    const audit = Audit(
      id: 'aud_1',
      siteName: 'Mumbai',
      title: 'Audit 1',
      totalItems: 5,
      isSynced: false,
      checklist: [true, true, true, true, true],
    );

    //Act
    final result = audit.isCompleted;

    //Assert
    expect(result, true);
  });

  test('returns false when checklist is empty', () {
    // Arrange
    const audit = Audit(
      id: 'aud_2',
      siteName: 'Mumbai',
      title: 'Empty Audit',
      totalItems: 0,
      isSynced: false,
      checklist: [],
    );

    // Act
    final result = audit.isCompleted;

    // Assert
    expect(result, isFalse);
  });

  test('Check if all audit checklists are not checked', () {
    //Arrange
    const audit = Audit(
      id: 'aud_1',
      siteName: 'Mumbai',
      title: 'Audit 1',
      totalItems: 5,
      isSynced: false,
      checklist: [false, false, false, false, false],
    );

    //Act
    final result = audit.completedItems;

    //Assert
    expect(result, 0);
  });

  test('Check if all audit checklists are checked', () {
    //Arrange
    const audit = Audit(
      id: 'aud_1',
      siteName: 'Mumbai',
      title: 'Audit 1',
      totalItems: 3,
      isSynced: false,
      checklist: [true, true, true],
    );

    //Act
    final result = audit.completedItems;

    //Assert
    expect(result, 3);
  });

  test('Check if only 1 audit checklists is checked', () {
    //Arrange
    const audit = Audit(
      id: 'aud_1',
      siteName: 'Mumbai',
      title: 'Audit 1',
      totalItems: 1,
      isSynced: false,
      checklist: [true],
    );

    //Act
    final result = audit.completedItems;

    //Assert
    expect(result, 1);
  });
}
