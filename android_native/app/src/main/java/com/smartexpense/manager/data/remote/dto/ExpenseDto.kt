package com.smartexpense.manager.data.remote.dto

import com.google.gson.annotations.SerializedName
import com.smartexpense.manager.domain.model.Category
import com.smartexpense.manager.domain.model.Expense
import java.util.Date

data class ExpenseDto(
    @SerializedName("id")
    val id: String,
    
    @SerializedName("amount")
    val amount: Double,
    
    @SerializedName("category")
    val category: CategoryDto,
    
    @SerializedName("date")
    val date: String,
    
    @SerializedName("note")
    val note: String?,
    
    @SerializedName("receiptUrl")
    val receiptUrl: String?,
    
    @SerializedName("createdAt")
    val createdAt: String,
    
    @SerializedName("updatedAt")
    val updatedAt: String
)

data class CategoryDto(
    @SerializedName("id")
    val id: String,
    
    @SerializedName("name")
    val name: String,
    
    @SerializedName("icon")
    val icon: String,
    
    @SerializedName("color")
    val color: String
)

fun ExpenseDto.toDomainModel(): Expense {
    return Expense(
        id = id,
        amount = amount,
        category = Category(
            id = category.id,
            name = category.name,
            icon = category.icon,
            color = category.color
        ),
        date = Date(), // Parse date string properly in production
        note = note,
        receiptUrl = receiptUrl,
        createdAt = Date(), // Parse date string properly in production
        updatedAt = Date()  // Parse date string properly in production
    )
}

fun Expense.toDto(): ExpenseDto {
    return ExpenseDto(
        id = id,
        amount = amount,
        category = CategoryDto(
            id = category.id,
            name = category.name,
            icon = category.icon,
            color = category.color
        ),
        date = date.toString(), // Format date properly in production
        note = note,
        receiptUrl = receiptUrl,
        createdAt = createdAt.toString(), // Format date properly in production
        updatedAt = updatedAt.toString()  // Format date properly in production
    )
}
