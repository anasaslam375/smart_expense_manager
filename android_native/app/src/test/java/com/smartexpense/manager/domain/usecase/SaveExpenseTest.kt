package com.smartexpense.manager.domain.usecase

import com.smartexpense.manager.domain.model.Category
import com.smartexpense.manager.domain.model.Expense
import com.smartexpense.manager.domain.repository.ExpenseRepository
import io.mockk.coEvery
import io.mockk.mockk
import kotlinx.coroutines.test.runTest
import org.junit.Assert.assertTrue
import org.junit.Before
import org.junit.Test
import java.util.Date

class SaveExpenseTest {

    private lateinit var saveExpense: SaveExpense
    private lateinit var repository: ExpenseRepository

    @Before
    fun setup() {
        repository = mockk()
        saveExpense = SaveExpense(repository)
    }

    @Test
    fun `invoke should save expense successfully`() = runTest {
        // Given
        val expense = Expense(
            id = "1",
            amount = 100.0,
            category = Category("1", "Food", "🍔", "#FF6B6B"),
            date = Date()
        )
        coEvery { repository.saveExpense(expense) } returns Result.success(Unit)

        // When
        val result = saveExpense(expense)

        // Then
        assertTrue(result.isSuccess)
    }

    @Test
    fun `invoke should return error when repository fails`() = runTest {
        // Given
        val expense = Expense(
            id = "1",
            amount = 100.0,
            category = Category("1", "Food", "🍔", "#FF6B6B"),
            date = Date()
        )
        val error = Exception("Database error")
        coEvery { repository.saveExpense(expense) } returns Result.failure(error)

        // When
        val result = saveExpense(expense)

        // Then
        assertTrue(result.isFailure)
        assertEquals(error, result.exceptionOrNull())
    }
}
