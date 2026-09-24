import 'package:field_audit_lite/features/audits/presentation/providers/audit_provider.dart';
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
          // We'll navigate to AddAuditScreen here
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

              return ListTile(
                title: Text(audit.title),
                subtitle: Text(
                  '${audit.siteName} • '
                  '${audit.completedItems}/${audit.totalItems} completed',
                ),
                trailing: Icon(
                  audit.isSynced ? Icons.cloud_done : Icons.cloud_off,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
