package com.smartexpense.manager.presentation.viewmodel

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.smartexpense.manager.domain.model.Category
import com.smartexpense.manager.domain.model.Expense
import com.smartexpense.manager.domain.usecase.DeleteExpense
import com.smartexpense.manager.domain.usecase.GetExpenses
import com.smartexpense.manager.domain.usecase.SaveExpense
import com.smartexpense.manager.presentation.constants.AppStrings
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch
import java.util.Date
import javax.inject.Inject

@HiltViewModel
class ExpenseViewModel @Inject constructor(
    private val getExpenses: GetExpenses,
    private val saveExpense: SaveExpense,
    private val deleteExpense: DeleteExpense
) : ViewModel() {

    private val _uiState = MutableStateFlow<ExpenseUiState>(ExpenseUiState.Loading)
    val uiState: StateFlow<ExpenseUiState> = _uiState.asStateFlow()

    init {
        loadExpenses()
    }

    fun loadExpenses() {
        viewModelScope.launch {
            _uiState.value = ExpenseUiState.Loading
            getExpenses().fold(
                onSuccess = { expenses ->
                    val totalAmount = expenses.sumOf { it.amount }
                    _uiState.value = ExpenseUiState.Success(expenses, totalAmount)
                },
                onFailure = { error ->
                    _uiState.value = ExpenseUiState.Error(error.message ?: AppStrings.UNKNOWN_ERROR)
                }
            )
        }
    }

    fun loadExpensesByDate(date: Date) {
        viewModelScope.launch {
            _uiState.value = ExpenseUiState.Loading
            getExpenses.callByDate(date).fold(
                onSuccess = { expenses ->
                    val totalAmount = expenses.sumOf { it.amount }
                    _uiState.value = ExpenseUiState.Success(expenses, totalAmount)
                },
                onFailure = { error ->
                    _uiState.value = ExpenseUiState.Error(error.message ?: AppStrings.UNKNOWN_ERROR)
                }
            )
        }
    }

    fun loadExpensesByCategory(category: Category) {
        viewModelScope.launch {
            _uiState.value = ExpenseUiState.Loading
            getExpenses.callByCategory(category).fold(
                onSuccess = { expenses ->
                    val totalAmount = expenses.sumOf { it.amount }
                    _uiState.value = ExpenseUiState.Success(expenses, totalAmount)
                },
                onFailure = { error ->
                    _uiState.value = ExpenseUiState.Error(error.message ?: AppStrings.UNKNOWN_ERROR)
                }
            )
        }
    }

    fun addExpense(amount: Double, category: Category, date: Date, note: String?) {
        viewModelScope.launch {
            _uiState.value = ExpenseUiState.Saving
            val expense = Expense(
                id = java.util.UUID.randomUUID().toString(),
                amount = amount,
                category = category,
                date = date,
                note = note
            )
            saveExpense(expense).fold(
                onSuccess = {
                    _uiState.value = ExpenseUiState.Saved
                    loadExpenses()
                },
                onFailure = { error ->
                    _uiState.value = ExpenseUiState.Error(error.message ?: AppStrings.FAILED_TO_SAVE_EXPENSE)
                }
            )
        }
    }

    fun deleteExpense(expense: Expense) {
        viewModelScope.launch {
            _uiState.value = ExpenseUiState.Deleting
            deleteExpense(expense).fold(
                onSuccess = {
                    _uiState.value = ExpenseUiState.Deleted
                    loadExpenses()
                },
                onFailure = { error ->
                    _uiState.value = ExpenseUiState.Error(error.message ?: AppStrings.FAILED_TO_DELETE_EXPENSE)
                }
            )
        }
    }
}

sealed class ExpenseUiState {
    object Loading : ExpenseUiState()
    data class Success(val expenses: List<Expense>, val totalAmount: Double) : ExpenseUiState()
    object Saving : ExpenseUiState()
    object Saved : ExpenseUiState()
    object Deleting : ExpenseUiState()
    object Deleted : ExpenseUiState()
    data class Error(val message: String) : ExpenseUiState()
}
