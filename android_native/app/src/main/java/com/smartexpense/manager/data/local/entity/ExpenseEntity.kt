package com.smartexpense.manager.data.local.entity

import androidx.room.Entity
import androidx.room.PrimaryKey
import com.smartexpense.manager.domain.model.Category
import java.util.Date

@Entity(tableName = "expenses")
data class ExpenseEntity(
    @PrimaryKey
    val id: String,
    val amount: Double,
    val categoryId: String,
    val categoryName: String,
    val categoryIcon: String,
    val categoryColor: String,
    val date: Date,
    val note: String?,
    val receiptUrl: String?,
    val createdAt: Date,
    val updatedAt: Date
)

fun ExpenseEntity.toDomainModel() = com.smartexpense.manager.domain.model.Expense(
    id = id,
    amount = amount,
    category = Category(
        id = categoryId,
        name = categoryName,
        icon = categoryIcon,
        color = categoryColor
    ),
    date = date,
    note = note,
    receiptUrl = receiptUrl,
    createdAt = createdAt,
    updatedAt = updatedAt
)

fun com.smartexpense.manager.domain.model.Expense.toEntity() = ExpenseEntity(
    id = id,
    amount = amount,
    categoryId = category.id,
    categoryName = category.name,
    categoryIcon = category.icon,
    categoryColor = category.color,
    date = date,
    note = note,
    receiptUrl = receiptUrl,
    createdAt = createdAt,
    updatedAt = updatedAt
)
