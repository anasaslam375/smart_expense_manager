package com.smartexpense.manager.presentation

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.smartexpense.manager.presentation.constants.AppStrings
import com.smartexpense.manager.presentation.feature.expense.AddExpenseBottomSheet
import com.smartexpense.manager.presentation.feature.expense.ExpenseListScreen
import com.smartexpense.manager.presentation.theme.SmartExpenseManagerTheme
import com.smartexpense.manager.presentation.viewmodel.ExpenseViewModel
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            SmartExpenseManagerTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    SmartExpenseNavHost()
                }
            }
        }
    }
}

@Composable
fun SmartExpenseNavHost(
    viewModel: ExpenseViewModel = androidx.hilt.navigation.compose.hiltViewModel()
) {
    val navController = rememberNavController()
    var showAddExpenseSheet by androidx.compose.runtime.mutableStateOf(false)

    NavHost(
        navController = navController,
        startDestination = AppStrings.ROUTE_EXPENSE_LIST
    ) {
        composable(AppStrings.ROUTE_EXPENSE_LIST) {
            ExpenseListScreen(
                onAddExpenseClick = { showAddExpenseSheet = true }
            )
        }
    }

    if (showAddExpenseSheet) {
        AddExpenseBottomSheet(
            onDismiss = { showAddExpenseSheet = false },
            onExpenseAdded = { amount, category, date, note ->
                viewModel.addExpense(amount, category, date, note)
                showAddExpenseSheet = false
            }
        )
    }
}
