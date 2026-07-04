package com.smartexpense.manager.domain.usecase

import com.smartexpense.manager.domain.repository.ExpenseRepository
import javax.inject.Inject

class GetExpenses @Inject constructor(
    private val repository: ExpenseRepository
) {
    suspend operator fun invoke() = repository.getExpenses()
    
    suspend fun callByDate(date: java.util.Date) = repository.getExpensesByDate(date)
    
    suspend fun callByCategory(category: com.smartexpense.manager.domain.model.Category) = 
        repository.getExpensesByCategory(category)
}
