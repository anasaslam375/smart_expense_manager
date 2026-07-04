package com.smartexpense.manager.domain.usecase

import com.smartexpense.manager.domain.model.Expense
import com.smartexpense.manager.domain.repository.ExpenseRepository
import javax.inject.Inject

class DeleteExpense @Inject constructor(
    private val repository: ExpenseRepository
) {
    suspend operator fun invoke(expense: Expense) = repository.deleteExpense(expense)
}
