package com.smartexpense.manager.domain.repository

import com.smartexpense.manager.domain.model.Expense
import com.smartexpense.manager.domain.model.Category
import java.util.Date

interface ExpenseRepository {
    suspend fun getExpenses(): Result<List<Expense>>
    suspend fun getExpenseById(id: String): Result<Expense?>
    suspend fun saveExpense(expense: Expense): Result<Unit>
    suspend fun deleteExpense(expense: Expense): Result<Unit>
    suspend fun getExpensesByDate(date: Date): Result<List<Expense>>
    suspend fun getExpensesByCategory(category: Category): Result<List<Expense>>
    suspend fun getTotalAmount(): Result<Double>
}
