import 'package:flutter/material.dart';

import '../../domain/entities/audit.dart';

class AuditDetailScreen extends StatefulWidget {
  final Audit audit;

  const AuditDetailScreen({super.key, required this.audit});

  @override
  State<AuditDetailScreen> createState() => _AuditDetailScreenState();
}

class _AuditDetailScreenState extends State<AuditDetailScreen> {
  late List<bool> checklist;

  @override
  void initState() {
    super.initState();

    checklist = List<bool>.filled(widget.audit.totalItems, false);
  }

  @override
  Widget build(BuildContext context) {
    final completedCount = checklist.where((item) => item).length;

    return Scaffold(
      appBar: AppBar(title: Text(widget.audit.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            widget.audit.siteName,
            style: Theme.of(context).textTheme.titleLarge,
          ),

          const SizedBox(height: 8),

          Text('$completedCount/${checklist.length} completed'),

          const SizedBox(height: 24),

          ...List.generate(
            checklist.length,
            (index) => CheckboxListTile(
              title: Text('Checklist Item ${index + 1}'),
              value: checklist[index],
              onChanged: (value) {
                setState(() {
                  checklist[index] = value ?? false;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
