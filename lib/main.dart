import 'package:flutter/material.dart';

void main() {
  runApp(const FieldAuditApp());
}

class FieldAuditApp extends StatelessWidget {
  const FieldAuditApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FieldAudit Lite',
      home: Scaffold(
        appBar: AppBar(title: const Text('FieldAudit Lite')),
        body: const Center(child: Text('Offline-first Audit App')),
      ),
    );
  }
}
