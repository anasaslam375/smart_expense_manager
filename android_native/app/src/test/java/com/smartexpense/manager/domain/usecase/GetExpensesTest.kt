package com.smartexpense.manager.domain.usecase

import com.smartexpense.manager.domain.model.Category
import com.smartexpense.manager.domain.model.Expense
import com.smartexpense.manager.domain.repository.ExpenseRepository
import io.mockk.coEvery
import io.mockk.mockk
import kotlinx.coroutines.test.runTest
import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Before
import org.junit.Test
import java.util.Date

class GetExpensesTest {

    private lateinit var getExpenses: GetExpenses
    private lateinit var repository: ExpenseRepository

    @Before
    fun setup() {
        repository = mockk()
        getExpenses = GetExpenses(repository)
    }

    @Test
    fun `invoke should return expenses from repository`() = runTest {
        // Given
        val expectedExpenses = listOf(
            Expense(
                id = "1",
                amount = 100.0,
                category = Category("1", "Food", "🍔", "#FF6B6B"),
                date = Date()
            )
        )
        coEvery { repository.getExpenses() } returns Result.success(expectedExpenses)

        // When
        val result = getExpenses()

        // Then
        assertTrue(result.isSuccess)
        assertEquals(expectedExpenses, result.getOrNull())
    }

    @Test
    fun `invoke should return error when repository fails`() = runTest {
        // Given
        val error = Exception("Network error")
        coEvery { repository.getExpenses() } returns Result.failure(error)

        // When
        val result = getExpenses()

        // Then
        assertTrue(result.isFailure)
        assertEquals(error, result.exceptionOrNull())
    }

    @Test
    fun `callByDate should return expenses for specific date`() = runTest {
        // Given
        val date = Date()
        val expectedExpenses = listOf(
            Expense(
                id = "1",
                amount = 50.0,
                category = Category("2", "Transport", "🚗", "#4ECDC4"),
                date = date
            )
        )
        coEvery { repository.getExpensesByDate(date) } returns Result.success(expectedExpenses)

        // When
        val result = getExpenses.callByDate(date)

        // Then
        assertTrue(result.isSuccess)
        assertEquals(expectedExpenses, result.getOrNull())
    }

    @Test
    fun `callByCategory should return expenses for specific category`() = runTest {
        // Given
        val category = Category("1", "Food", "🍔", "#FF6B6B")
        val expectedExpenses = listOf(
            Expense(
                id = "1",
                amount = 75.0,
                category = category,
                date = Date()
            )
        )
        coEvery { repository.getExpensesByCategory(category) } returns Result.success(expectedExpenses)

        // When
        val result = getExpenses.callByCategory(category)

        // Then
        assertTrue(result.isSuccess)
        assertEquals(expectedExpenses, result.getOrNull())
    }
}
