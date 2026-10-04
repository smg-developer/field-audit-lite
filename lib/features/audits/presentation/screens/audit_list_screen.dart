import 'package:field_audit_lite/features/audits/presentation/providers/audit_provider.dart';
import 'package:field_audit_lite/features/audits/presentation/screens/add_audit_screen.dart';
import 'package:field_audit_lite/features/audits/presentation/screens/audit_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuditListScreen extends ConsumerWidget {
  const AuditListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auditsAsync = ref.watch(auditsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Field Audits')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) {
                return AddAuditScreen();
              },
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.black),
      ),
      body: auditsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            Center(child: Text('Something went wrong: $error')),
        data: (audits) {
          if (audits.isEmpty) {
            return const Center(child: Text('No audits available'));
          }

          return ListView.builder(
            itemCount: audits.length,
            itemBuilder: (context, index) {
              final audit = audits[index];

              return Dismissible(
                key: ValueKey(audit.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.delete),
                ),
                confirmDismiss: (direction) async {
                  return await showDialog<bool>(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Delete audit?'),
                        content: Text(
                          'Are you sure you want to delete "${audit.title}"?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                            child: const Text('Cancel'),
                          ),
                          FilledButton(
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                            child: const Text('Delete'),
                          ),
                        ],
                      );
                    },
                  );
                },
                onDismissed: (direction) {
                  ref.read(auditsProvider.notifier).deleteAudit(audit.id);
                },

                child: ListTile(
                  title: Text(audit.title),
                  subtitle: Text(
                    '${audit.siteName} • '
                    '${audit.completedItems}/${audit.totalItems} completed',
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(audit.isSynced ? Icons.cloud_done : Icons.cloud_off),
                      const SizedBox(height: 4),
                      Text(
                        audit.isCompleted ? 'Completed' : 'In Progress',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) {
                          return AuditDetailScreen(audit: audit);
                        },
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
