import 'package:field_audit_lite/features/audits/presentation/providers/audit_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/audit.dart';

class AuditDetailScreen extends ConsumerStatefulWidget {
  final Audit audit;

  const AuditDetailScreen({super.key, required this.audit});

  @override
  ConsumerState<AuditDetailScreen> createState() => _AuditDetailScreenState();
}

class _AuditDetailScreenState extends ConsumerState<AuditDetailScreen> {
  late List<bool> checklist;

  @override
  void initState() {
    super.initState();

    checklist = List<bool>.from(widget.audit.checklist);
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
              onChanged: (value) async {
                final updatedChecklist = List<bool>.from(checklist);

                updatedChecklist[index] = value ?? false;

                setState(() {
                  checklist = updatedChecklist;
                });

                final updatedAudit = Audit(
                  id: widget.audit.id,
                  title: widget.audit.title,
                  siteName: widget.audit.siteName,
                  totalItems: widget.audit.totalItems,
                  completedItems: updatedChecklist.where((item) => item).length,
                  isSynced: false,
                  checklist: updatedChecklist,
                );

                await ref
                    .read(auditsProvider.notifier)
                    .updateAudit(updatedAudit);
              },
            ),
          ),
        ],
      ),
    );
  }
}
