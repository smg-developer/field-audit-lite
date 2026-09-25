import 'package:field_audit_lite/features/audits/domain/entities/audit.dart';
import 'package:field_audit_lite/features/audits/presentation/providers/audit_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddAuditScreen extends ConsumerStatefulWidget {
  const AddAuditScreen({super.key});

  @override
  ConsumerState<AddAuditScreen> createState() => _AddAuditScreenState();
}

class _AddAuditScreenState extends ConsumerState<AddAuditScreen> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _siteController = TextEditingController();
  final _totalItemsController = TextEditingController();

  bool _isSaving = false;

  @override
  void dispose() {
    _titleController.dispose();
    _siteController.dispose();
    _totalItemsController.dispose();
    super.dispose();
  }

  void _saveAudit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final totalItems = int.parse(_totalItemsController.text.trim());

    final auditObj = Audit(
      id: DateTime.now().toString(),
      title: _titleController.text.trim(),
      siteName: _siteController.text.trim(),
      totalItems: totalItems,
      completedItems: 0,
      isSynced: false,
      checklist: List<bool>.filled(totalItems, false),
    );

    try {
      await ref.read(auditsProvider.notifier).addAudit(auditObj);

      SnackBar(
        content: Text('Audit "${_titleController.text}" added successfully!'),
      );

      _titleController.clear();
      _siteController.clear();
      _totalItemsController.clear();

      if (!mounted) return;

      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to save audit: $e')));
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Audit')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Audit Title',
                hintText: 'Electrical Safety Inspection',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter an audit title';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _siteController,
              decoration: const InputDecoration(
                labelText: 'Site Name',
                hintText: 'Mumbai Office',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a site name';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _totalItemsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Total Checklist Items',
                hintText: '10',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                final number = int.tryParse(value ?? '');

                if (number == null || number <= 0) {
                  return 'Enter a valid number';
                }

                return null;
              },
            ),

            const SizedBox(height: 24),

            FilledButton.icon(
              onPressed: _isSaving ? null : _saveAudit,
              icon: _isSaving
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.save),
              label: Text(_isSaving ? 'Saving...' : 'Save Audit'),
            ),
          ],
        ),
      ),
    );
  }
}
