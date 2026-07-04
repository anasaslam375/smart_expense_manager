package com.smartexpense.manager.data.repository

import com.smartexpense.manager.data.local.ExpenseDao
import com.smartexpense.manager.data.local.entity.toDomainModel
import com.smartexpense.manager.data.local.entity.toEntity
import com.smartexpense.manager.domain.model.Category
import com.smartexpense.manager.domain.model.Expense
import com.smartexpense.manager.domain.repository.ExpenseRepository
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.map
import java.util.Calendar
import java.util.Date
import javax.inject.Inject

class ExpenseRepositoryImpl @Inject constructor(
    private val expenseDao: ExpenseDao
) : ExpenseRepository {

    override suspend fun getExpenses(): Result<List<Expense>> {
        return try {
            val expenses = expenseDao.getAllExpenses()
            // Convert Flow to List by collecting it
            val result = mutableListOf<Expense>()
            expenses.collect { entities ->
                result.clear()
                result.addAll(entities.map { it.toDomainModel() })
            }
            Result.success(result)
        } catch (e: Exception) {
            Result.failure(e)
        }
    }

    override suspend fun getExpenseById(id: String): Result<Expense?> {
        return try {
            val expense = expenseDao.getExpenseById(id)?.toDomainModel()
            Result.success(expense)
        } catch (e: Exception) {
            Result.failure(e)
        }
    }

    override suspend fun saveExpense(expense: Expense): Result<Unit> {
        return try {
            expenseDao.insertExpense(expense.toEntity())
            Result.success(Unit)
        } catch (e: Exception) {
            Result.failure(e)
        }
    }

    override suspend fun deleteExpense(expense: Expense): Result<Unit> {
        return try {
            expenseDao.deleteExpense(expense.toEntity())
            Result.success(Unit)
        } catch (e: Exception) {
            Result.failure(e)
        }
    }

    override suspend fun getExpensesByDate(date: Date): Result<List<Expense>> {
        return try {
            val calendar = Calendar.getInstance()
            calendar.time = date
            calendar.set(Calendar.HOUR_OF_DAY, 0)
            calendar.set(Calendar.MINUTE, 0)
            calendar.set(Calendar.SECOND, 0)
            calendar.set(Calendar.MILLISECOND, 0)

            val startDate = calendar.time
            calendar.add(Calendar.DAY_OF_MONTH, 1)
            val endDate = calendar.time

            val expenses = expenseDao.getExpensesByDateRange(startDate, endDate)
            val result = mutableListOf<Expense>()
            expenses.collect { entities ->
                result.clear()
                result.addAll(entities.map { it.toDomainModel() })
            }
            Result.success(result)
        } catch (e: Exception) {
            Result.failure(e)
        }
    }

    override suspend fun getExpensesByCategory(category: Category): Result<List<Expense>> {
        return try {
            val expenses = expenseDao.getExpensesByCategory(category.id)
            val result = mutableListOf<Expense>()
            expenses.collect { entities ->
                result.clear()
                result.addAll(entities.map { it.toDomainModel() })
            }
            Result.success(result)
        } catch (e: Exception) {
            Result.failure(e)
        }
    }

    override suspend fun getTotalAmount(): Result<Double> {
        return try {
            val total = expenseDao.getTotalAmount() ?: 0.0
            Result.success(total)
        } catch (e: Exception) {
            Result.failure(e)
        }
    }
}
