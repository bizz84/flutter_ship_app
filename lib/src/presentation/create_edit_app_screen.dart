import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ship_app/src/common_widgets/responsive_center_scrollable.dart';
import 'package:flutter_ship_app/src/common_widgets/show_alert_dialog.dart';
import 'package:flutter_ship_app/src/constants/app_sizes.dart';
import 'package:flutter_ship_app/src/domain/app.dart';
import 'package:flutter_ship_app/src/presentation/create_edit_app_controller.dart';
import 'package:flutter_ship_app/src/utils/string_hardcoded.dart';

/// Screen used to create a new app or edit an existing one
class CreateOrEditAppScreen extends ConsumerStatefulWidget {
  const CreateOrEditAppScreen({super.key, this.app});
  final App? app;

  @override
  ConsumerState<CreateOrEditAppScreen> createState() =>
      _CreateOrEditAppScreenState();
}

class _CreateOrEditAppScreenState extends ConsumerState<CreateOrEditAppScreen> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';

  @override
  void initState() {
    super.initState();
    // * preload the form with the initial data (useful in edit mode)
    if (widget.app != null) {
      _name = widget.app?.name ?? '';
    }
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    if (_validateAndSaveForm()) {
      try {
        // * Create or edit the app with the controller, which will talk to the
        // * underlying DB
        await ref
            .read(createEditAppControllerProvider.notifier)
            .createOrEditApp(widget.app, _name);
        if (mounted) {
          Navigator.of(context).pop();
        }
      } catch (e) {
        // TODO: Error monitoring
        showAlertDialog(
          context: context,
          title: 'Error Saving Data'.hardcoded,
          content: e.toString(),
          defaultActionText: 'OK'.hardcoded,
        );
      }
    }
  }

  Future<void> _delete() async {
    try {
      // * Safe to use ! as deletion only happens in edit mode
      final appName = widget.app!.name;
      final shouldDelete = await showAlertDialog(
        context: context,
        title: 'Are you sure?'.hardcoded,
        content:
            'This will delete "$appName" along with all its completed tasks'
                .hardcoded,
        cancelActionText: 'Cancel'.hardcoded,
        defaultActionText: 'Delete'.hardcoded,
        isDestructive: true,
      );
      if (shouldDelete == true) {
        // * Safe to use ! as deletion only happens in edit mode
        final appId = widget.app!.id;
        // * Delete the app with the controller, which will talk to the
        // * underlying DB
        await ref
            .read(createEditAppControllerProvider.notifier)
            .deleteAppById(appId);
        if (mounted) {
          // * Pop back to root
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      }
    } catch (e) {
      // TODO: Error monitoring
      showAlertDialog(
        context: context,
        title: 'Error Deleting App'.hardcoded,
        content: e.toString(),
        defaultActionText: 'OK'.hardcoded,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text((widget.app == null ? 'New App' : 'Edit App').hardcoded),
        actions: [
          if (widget.app != null)
            IconButton(
              tooltip: 'Delete this app'.hardcoded,
              onPressed: _delete,
              icon: Icon(
                Icons.delete,
                semanticLabel: 'Delete this app'.hardcoded,
              ),
            ),
        ],
      ),
      body: ResponsiveCenter(
        padding: const EdgeInsets.all(Sizes.p24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Semantics(
                identifier: 'app-name-input',
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'App name'.hardcoded),
                  keyboardAppearance: Theme.of(context).brightness,
                  textCapitalization: TextCapitalization.words,
                  initialValue: _name,
                  validator: (value) => (value ?? '').isNotEmpty
                      ? null
                      : 'Name can\'t be empty'.hardcoded,
                  onSaved: (value) => _name = value ?? '',
                  onEditingComplete: _submit,
                ),
              ),
              gapH16,
              Semantics(
                identifier: 'save-button',
                child: ElevatedButton(
                  onPressed: _submit,
                  child: Text('Save'.hardcoded),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: use_build_context_synchronously
