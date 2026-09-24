import 'package:field_audit_lite/features/audits/presentation/screens/audit_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: const FieldAuditApp()));
}

class FieldAuditApp extends StatelessWidget {
  const FieldAuditApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FieldAudit Lite',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      home: const AuditListScreen(),
    );
  }
}
