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

          Text(
            '$completedCount/${checklist.length} completed',
            style: Theme.of(context).textTheme.titleMedium,
          ),

          const SizedBox(height: 16),
          LinearProgressIndicator(value: completedCount / checklist.length),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Select All"),
              const SizedBox(width: 8),
              Checkbox(
                value:
                    checklist.isNotEmpty && completedCount == checklist.length
                    ? true
                    : false,
                onChanged: (value) async {
                  // setState(() {
                  //   checklist = List<bool>.filled(
                  //     checklist.length,
                  //     value ?? false,
                  //   );
                  // });
                  final updatedChecklist = List<bool>.filled(
                    checklist.length,
                    value ?? false,
                  );

                  setState(() {
                    checklist = updatedChecklist;
                  });

                  final updatedAudit = Audit(
                    id: widget.audit.id,
                    title: widget.audit.title,
                    siteName: widget.audit.siteName,
                    totalItems: widget.audit.totalItems,
                    isSynced: false,
                    checklist: updatedChecklist,
                  );

                  await ref
                      .read(auditsProvider.notifier)
                      .updateAudit(updatedAudit);
                },
              ),
            ],
          ),
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
