import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:smart_expense_manager/core/constants/app_constants.dart';

part 'expense.g.dart';

@HiveType(typeId: 0)
class Expense extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final Category category;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final String? note;

  @HiveField(5)
  final String? receiptUrl;

  @HiveField(6)
  final DateTime createdAt;

  @HiveField(7)
  final DateTime updatedAt;

  Expense({
    String? id,
    required this.amount,
    required this.category,
    required this.date,
    this.note,
    this.receiptUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now() {
    // Validation
    assert(amount > 0, 'Amount must be positive');
    assert(
        amount <= AppConstants.maxAmount, 'Amount cannot exceed 1,000,000.00');
    assert((amount * 100).toInt().toDouble() / 100 == amount,
        'Amount can have maximum 2 decimal places');
    assert(
        date.isBefore(DateTime.now()) || date.isAtSameMomentAs(DateTime.now()),
        'Date cannot be in the future');
    assert(note == null || note!.length <= AppConstants.maxNoteLength,
        'Note cannot exceed 500 characters');
    assert(
        receiptUrl == null || receiptUrl!.startsWith(AppConstants.httpsPrefix),
        'Receipt URL must use HTTPS');
  }

  Expense copyWith({
    String? id,
    double? amount,
    Category? category,
    DateTime? date,
    String? note,
    String? receiptUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Expense(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      date: date ?? this.date,
      note: note ?? this.note,
      receiptUrl: receiptUrl ?? this.receiptUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Expense && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

@HiveType(typeId: 1)
class Category extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String icon;

  @HiveField(3)
  final String color;

  Category({
    String? id,
    required this.name,
    required this.icon,
    required this.color,
  }) : id = id ?? const Uuid().v4() {
    // Validation
    assert(name.isNotEmpty && name.length <= AppConstants.maxCategoryNameLength,
        'Category name must be 1-50 characters');
    assert(RegExp(r'^#[0-9A-Fa-f]{6}$').hasMatch(color),
        'Color must be valid hex format');
  }

  static List<Category> defaultCategories = [
    Category(name: 'Food', icon: '🍔', color: '#FF6B6B'),
    Category(name: 'Transport', icon: '🚗', color: '#4ECDC4'),
    Category(name: 'Shopping', icon: '🛍️', color: '#45B7D1'),
    Category(name: 'Entertainment', icon: '🎬', color: '#96CEB4'),
    Category(name: 'Bills', icon: '📄', color: '#FFEAA7'),
    Category(name: 'Health', icon: '❤️', color: '#DDA0DD'),
    Category(name: 'Education', icon: '📚', color: '#98D8C8'),
    Category(name: 'Travel', icon: '✈️', color: '#F7DC6F'),
    Category(name: 'Other', icon: '📦', color: '#95A5A6'),
  ];

  Category copyWith({
    String? id,
    String? name,
    String? icon,
    String? color,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Category && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
