package com.smartexpense.manager.domain.model

import com.smartexpense.manager.presentation.constants.AppConstants
import java.util.Date
import java.util.UUID

data class Expense(
    val id: String = UUID.randomUUID().toString(),
    val amount: Double,
    val category: Category,
    val date: Date,
    val note: String? = null,
    val receiptUrl: String? = null,
    val createdAt: Date = Date(),
    val updatedAt: Date = Date()
) {
    init {
        require(amount > 0) { "Amount must be positive" }
        require(amount <= AppConstants.MAX_AMOUNT) { "Amount cannot exceed 1,000,000.00" }
        require((amount * 100).toInt().toDouble() / 100 == amount) { "Amount can have maximum 2 decimal places" }
        require(date <= Date()) { "Date cannot be in the future" }
        note?.let { require(it.length <= AppConstants.MAX_NOTE_LENGTH) { "Note cannot exceed 500 characters" } }
        receiptUrl?.let { require(it.startsWith(AppConstants.HTTPS_PREFIX)) { "Receipt URL must use HTTPS" } }
    }
}

data class Category(
    val id: String = UUID.randomUUID().toString(),
    val name: String,
    val icon: String,
    val color: String
) {
    init {
        require(name.length in AppConstants.MIN_CATEGORY_NAME_LENGTH..AppConstants.MAX_CATEGORY_NAME_LENGTH) { "Category name must be 1-50 characters" }
        require(color.matches(Regex("^#[0-9A-Fa-f]{6}$"))) { "Color must be valid hex format" }
    }

    companion object {
        val defaultCategories = listOf(
            Category("1", "Food", "🍔", "#FF6B6B"),
            Category("2", "Transport", "🚗", "#4ECDC4"),
            Category("3", "Shopping", "🛍️", "#45B7D1"),
            Category("4", "Entertainment", "🎬", "#96CEB4"),
            Category("5", "Bills", "📄", "#FFEAA7"),
            Category("6", "Health", "❤️", "#DDA0DD"),
            Category("7", "Education", "📚", "#98D8C8"),
            Category("8", "Travel", "✈️", "#F7DC6F"),
            Category("9", "Other", "📦", "#95A5A6")
        )
    }
}

data class Budget(
    val id: String = UUID.randomUUID().toString(),
    val category: Category,
    val limit: Double,
    val spent: Double,
    val period: BudgetPeriod
)

enum class BudgetPeriod {
    DAILY,
    WEEKLY,
    MONTHLY,
    YEARLY
}
