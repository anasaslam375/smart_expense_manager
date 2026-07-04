import 'package:flutter/material.dart';
import 'package:smart_expense_manager/core/constants/app_constants.dart';
import 'package:smart_expense_manager/core/constants/app_colors.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const DeleteConfirmationDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    required this.onCancel,
  });

  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String content,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => DeleteConfirmationDialog(
        title: title,
        content: content,
        onConfirm: () => Navigator.pop(context, true),
        onCancel: () => Navigator.pop(context, false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: const Text(AppStrings.cancel),
        ),
        TextButton(
          onPressed: onConfirm,
          style: TextButton.styleFrom(foregroundColor: AppColors.red),
          child: const Text(AppStrings.delete),
        ),
      ],
    );
  }
}
