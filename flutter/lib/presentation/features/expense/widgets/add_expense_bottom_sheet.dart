import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_expense_manager/core/constants/app_constants.dart';
import 'package:smart_expense_manager/core/constants/app_colors.dart';
import 'package:smart_expense_manager/domain/models/expense.dart';
import 'package:smart_expense_manager/core/extensions/date_time_extensions.dart';
import 'package:smart_expense_manager/presentation/shared/widgets/category_icon.dart';

class AddExpenseBottomSheet extends StatefulWidget {
  final Function(double amount, Category category, DateTime date, String? note)
      onExpenseAdded;

  const AddExpenseBottomSheet({
    super.key,
    required this.onExpenseAdded,
  });

  @override
  State<AddExpenseBottomSheet> createState() => _AddExpenseBottomSheetState();
}

class _AddExpenseBottomSheetState extends State<AddExpenseBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  Category? _selectedCategory;
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppConstants.borderRadiusLarge)),
      ),
      padding: EdgeInsets.only(
        left: AppConstants.spacingExtraLarge,
        right: AppConstants.spacingExtraLarge,
        top: AppConstants.spacingExtraLarge,
        bottom: MediaQuery.of(context).viewInsets.bottom +
            AppConstants.spacingExtraLarge,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: AppConstants.handleBarWidth,
                height: AppConstants.handleBarHeight,
                margin: const EdgeInsets.only(
                    bottom: AppConstants.spacingExtraLarge),
                decoration: BoxDecoration(
                  color: AppColors.grey300,
                  borderRadius:
                      BorderRadius.circular(AppConstants.tinyBorderRadius),
                ),
              ),
            ),
            const Text(
              AppStrings.addNewExpense,
              style: TextStyle(
                fontSize: AppConstants.headerFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppConstants.spacingExtraLarge),
            TextFormField(
              controller: _amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp(AppConstants.amountInputPattern)),
              ],
              decoration: const InputDecoration(
                labelText: AppStrings.amount,
                prefixText: '${AppStrings.currencySymbol} ',
                hintText: AppStrings.amountPlaceholder,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppStrings.pleaseEnterAmount;
                }
                final amount = double.tryParse(value);
                if (amount == null || amount <= 0) {
                  return AppStrings.pleaseEnterValidAmount;
                }
                return null;
              },
            ),
            const SizedBox(height: AppConstants.spacingLarge),
            const Text(
              AppStrings.category,
              style: TextStyle(
                fontSize: AppConstants.titleFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppConstants.spacingMedium),
            SizedBox(
              height: AppConstants.categoryGridHeight,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: AppConstants.categoryGridCrossAxisCount,
                  childAspectRatio: AppConstants.childAspectRatio,
                  crossAxisSpacing: AppConstants.spacingMedium,
                  mainAxisSpacing: AppConstants.spacingMedium,
                ),
                itemCount: Category.defaultCategories.length,
                itemBuilder: (context, index) {
                  final category = Category.defaultCategories[index];
                  final isSelected = _selectedCategory?.id == category.id;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = category;
                      });
                      HapticFeedback.lightImpact();
                    },
                    child: AnimatedContainer(
                      duration: AppConstants.chipAnimationDuration,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? CategoryIcon.parseColor(category.color)
                            : AppColors.grey100,
                        borderRadius: BorderRadius.circular(
                            AppConstants.borderRadiusMedium),
                        border: Border.all(
                          color: isSelected
                              ? CategoryIcon.parseColor(category.color)
                              : AppColors.grey300,
                          width: AppConstants.borderWidth,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            category.icon,
                            style: const TextStyle(
                                fontSize: AppConstants.categoryGridIconSize),
                          ),
                          const SizedBox(height: AppConstants.spacingSmall),
                          Text(
                            category.name,
                            style: TextStyle(
                              fontSize: AppConstants.categoryGridTextSize,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: isSelected
                                  ? AppColors.white
                                  : AppColors.grey700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: AppConstants.spacingLarge),
            InkWell(
              onTap: () => _selectDate(context),
              borderRadius:
                  BorderRadius.circular(AppConstants.borderRadiusMedium),
              child: Container(
                padding: const EdgeInsets.all(AppConstants.spacingLarge),
                decoration: BoxDecoration(
                  color: AppColors.grey100,
                  borderRadius:
                      BorderRadius.circular(AppConstants.borderRadiusMedium),
                  border: Border.all(color: AppColors.grey300),
                ),
                child: Row(
                  children: [
                    const Icon(AppIcons.calendar, color: AppColors.grey),
                    const SizedBox(width: AppConstants.spacingMedium),
                    Text(
                      '${AppStrings.date}: ${_selectedDate.toFormattedDate()}',
                      style:
                          const TextStyle(fontSize: AppConstants.titleFontSize),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppConstants.spacingLarge),
            TextFormField(
              controller: _noteController,
              maxLines: AppConstants.maxLinesThree,
              decoration: const InputDecoration(
                labelText: AppStrings.note,
                hintText: AppStrings.addANote,
              ),
            ),
            const SizedBox(height: AppConstants.spacingExtraLarge),
            SizedBox(
              width: double.infinity,
              height: AppConstants.buttonHeight,
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(AppConstants.borderRadiusMedium),
                  ),
                  elevation: AppConstants.elevationNone,
                ),
                child: const Text(
                  AppStrings.addExpense,
                  style: TextStyle(
                    fontSize: AppConstants.buttonFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(AppStrings.minDateYear),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_selectedCategory == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(AppStrings.pleaseSelectCategory)),
        );
        return;
      }

      final amount = double.parse(_amountController.text);
      widget.onExpenseAdded(
        amount,
        _selectedCategory!,
        _selectedDate,
        _noteController.text.isEmpty ? null : _noteController.text,
      );
      Navigator.pop(context);
      HapticFeedback.mediumImpact();
    }
  }
}
