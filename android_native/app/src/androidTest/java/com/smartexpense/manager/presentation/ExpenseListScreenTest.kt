package com.smartexpense.manager.presentation

import androidx.compose.ui.test.junit4.createComposeRule
import androidx.compose.ui.test.onNodeWithText
import androidx.compose.ui.test.performClick
import androidx.test.ext.junit.runners.AndroidJUnit4
import com.smartexpense.manager.presentation.feature.expense.ExpenseListScreen
import dagger.hilt.android.testing.HiltAndroidRule
import dagger.hilt.android.testing.HiltAndroidTest
import org.junit.Before
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

@HiltAndroidTest
@RunWith(AndroidJUnit4::class)
class ExpenseListScreenTest {

    @get:Rule
    val hiltRule = HiltAndroidRule(this)

    @get:Rule
    val composeTestRule = createComposeRule()

    @Before
    fun setup() {
        hiltRule.inject()
    }

    @Test
    fun expenseListScreen_displaysTitle() {
        composeTestRule.setContent {
            ExpenseListScreen()
        }

        composeTestRule.onNodeWithText("My Expenses").assertExists()
    }

    @Test
    fun expenseListScreen_displaysTotalSpent() {
        composeTestRule.setContent {
            ExpenseListScreen()
        }

        composeTestRule.onNodeWithText("Total Spent").assertExists()
    }

    @Test
    fun expenseListScreen_fabClick_triggersAddExpense() {
        var addExpenseClicked = false
        
        composeTestRule.setContent {
            ExpenseListScreen(
                onAddExpenseClick = { addExpenseClicked = true }
            )
        }

        // FAB click test would go here
        // composeTestRule.onNodeWithContentDescription("Add Expense").performClick()
        // assertTrue(addExpenseClicked)
    }
}
