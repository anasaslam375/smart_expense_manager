package com.smartexpense.manager.presentation.feature.expense

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.material.icons.filled.Delete
import androidx.compose.material3.*
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import com.smartexpense.manager.presentation.constants.AppConstants
import com.smartexpense.manager.presentation.constants.AppStrings
import com.smartexpense.manager.presentation.constants.AppColors
import com.smartexpense.manager.presentation.shared.components.EmptyState
import com.smartexpense.manager.presentation.shared.components.ErrorState
import com.smartexpense.manager.presentation.extensions.DoubleExtensions
import com.smartexpense.manager.presentation.extensions.DateExtensions
import com.smartexpense.manager.presentation.utils.ColorParser
import com.smartexpense.manager.presentation.viewmodel.ExpenseUiState
import com.smartexpense.manager.presentation.viewmodel.ExpenseViewModel

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun ExpenseListScreen(
    viewModel: ExpenseViewModel = hiltViewModel(),
    onAddExpenseClick: () -> Unit = {}
) {
    val uiState by viewModel.uiState.collectAsState()
    var selectedCategory by androidx.compose.runtime.mutableStateOf<Category?>(null)

    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text(AppStrings.APP_TITLE) },
                colors = TopAppBarDefaults.topAppBarColors(
                    containerColor = MaterialTheme.colorScheme.primary,
                    titleContentColor = AppColors.white
                )
            )
        },
        floatingActionButton = {
            FloatingActionButton(
                onClick = onAddExpenseClick,
                containerColor = MaterialTheme.colorScheme.primary
            ) {
                Icon(Icons.Default.Add, contentDescription = AppStrings.ADD_EXPENSE)
            }
        }
    ) { paddingValues ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(paddingValues)
        ) {
            // Total Amount Card
            when (val state = uiState) {
                is ExpenseUiState.Success -> {
                    TotalAmountCard(state.totalAmount)
                }
                else -> {}
            }

            // Category Filter
            CategoryFilterRow(
                selectedCategory = selectedCategory,
                onCategorySelected = { category ->
                    selectedCategory = category
                    if (category == null) {
                        viewModel.loadExpenses()
                    } else {
                        viewModel.loadExpensesByCategory(category)
                    }
                }
            )

            // Expense List
            when (val state = uiState) {
                is ExpenseUiState.Loading -> {
                    Box(
                        modifier = Modifier.fillMaxSize(),
                        contentAlignment = Alignment.Center
                    ) {
                        CircularProgressIndicator()
                    }
                }
                is ExpenseUiState.Success -> {
                    if (state.expenses.isEmpty()) {
                        EmptyState()
                    } else {
                        LazyColumn(
                            modifier = Modifier.fillMaxSize(),
                            contentPadding = PaddingValues(AppConstants.cardPadding),
                            verticalArrangement = Arrangement.spacedBy(AppConstants.spacingMedium)
                        ) {
                            items(state.expenses) { expense ->
                                ExpenseCard(
                                    expense = expense,
                                    onDelete = { viewModel.deleteExpense(expense) }
                                )
                            }
                        }
                    }
                }
                is ExpenseUiState.Error -> {
                    ErrorState(state.message) {
                        viewModel.loadExpenses()
                    }
                }
                else -> {}
            }
        }
    }
}

@Composable
fun TotalAmountCard(totalAmount: Double) {
    Card(
        modifier = Modifier
            .fillMaxWidth()
            .padding(AppConstants.cardPadding),
        shape = RoundedCornerShape(AppConstants.cardCornerRadius),
        colors = CardDefaults.cardColors(
            containerColor = MaterialTheme.colorScheme.primary
        )
    ) {
        Column(
            modifier = Modifier.padding(AppConstants.cardInnerPadding)
        ) {
            Text(
                AppStrings.TOTAL_SPENT,
                style = MaterialTheme.typography.bodyMedium,
                color = AppColors.white.copy(alpha = AppConstants.alpha70)
            )
            Spacer(modifier = Modifier.height(AppConstants.spacingSmall))
            Text(
                totalAmount.toCurrency(),
                style = MaterialTheme.typography.headlineLarge,
                color = AppColors.white,
                fontWeight = FontWeight.Bold
            )
        }
    }
}

@Composable
fun CategoryFilterRow(
    selectedCategory: Category?,
    onCategorySelected: (Category?) -> Unit
) {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .horizontalScroll(rememberScrollState())
            .padding(horizontal = AppConstants.cardPadding, vertical = AppConstants.spacingSmall),
        horizontalArrangement = Arrangement.spacedBy(AppConstants.spacingSmall)
    ) {
        FilterChip(
            selected = selectedCategory == null,
            onClick = { onCategorySelected(null) },
            label = { Text(AppStrings.ALL) },
            modifier = Modifier.height(AppConstants.categoryFilterHeight)
        )
        Category.defaultCategories.forEach { category ->
            FilterChip(
                selected = selectedCategory?.id == category.id,
                onClick = { onCategorySelected(category) },
                label = { Text(category.name) },
                modifier = Modifier.height(AppConstants.categoryFilterHeight)
            )
        }
    }
}

@Composable
fun ExpenseCard(
    expense: Expense,
    onDelete: () -> Unit
) {
    var showDeleteDialog by androidx.compose.runtime.mutableStateOf(false)

    Card(
        modifier = Modifier.fillMaxWidth(),
        shape = RoundedCornerShape(AppConstants.itemCornerRadius),
        elevation = CardDefaults.cardElevation(defaultElevation = AppConstants.cardElevation)
    ) {
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(AppConstants.cardPadding),
            horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.CenterVertically
        ) {
            Row(
                verticalAlignment = Alignment.CenterVertically,
                modifier = Modifier.weight(1f)
            ) {
                Box(
                    modifier = Modifier
                        .size(AppConstants.iconBoxSize)
                        .background(
                            ColorParser.parseColor(expense.category.color).copy(alpha = AppConstants.alpha20),
                            RoundedCornerShape(AppConstants.iconBoxCornerRadius)
                        ),
                    contentAlignment = Alignment.Center
                ) {
                    Text(
                        expense.category.icon,
                        style = MaterialTheme.typography.titleLarge
                    )
                }
                Spacer(modifier = Modifier.width(AppConstants.cardPadding))
                Column {
                    Text(
                        expense.category.name,
                        style = MaterialTheme.typography.titleMedium,
                        fontWeight = FontWeight.Bold
                    )
                    expense.note?.let {
                        Text(
                            it,
                            style = MaterialTheme.typography.bodySmall,
                            color = MaterialTheme.colorScheme.onSurface.copy(alpha = AppConstants.alpha60),
                            maxLines = AppConstants.maxLinesOne
                        )
                    }
                    Text(
                        expense.date.toFormattedDate(),
                        style = MaterialTheme.typography.bodySmall,
                        color = MaterialTheme.colorScheme.onSurface.copy(alpha = AppConstants.alpha50)
                    )
                }
            }
            Column(
                horizontalAlignment = Alignment.End
            ) {
                Text(
                    expense.amount.toCurrency(),
                    style = MaterialTheme.typography.titleLarge,
                    fontWeight = FontWeight.Bold,
                    color = MaterialTheme.colorScheme.primary
                )
                IconButton(
                    onClick = { showDeleteDialog = true },
                    modifier = Modifier.size(AppConstants.deleteIconSize)
                ) {
                    Icon(
                        Icons.Default.Delete,
                        contentDescription = AppStrings.DELETE,
                        tint = MaterialTheme.colorScheme.error,
                        modifier = Modifier.size(AppConstants.deleteIconInnerSize)
                    )
                }
            }
        }
    }

    if (showDeleteDialog) {
        AlertDialog(
            onDismissRequest = { showDeleteDialog = false },
            title = { Text(AppStrings.DELETE_EXPENSE) },
            text = { Text("${AppStrings.DELETE_CONFIRMATION}${expense.amount.toCurrency()}${AppStrings.DELETE_CONFIRMATION_SUFFIX}") },
            confirmButton = {
                TextButton(
                    onClick = {
                        showDeleteDialog = false
                        onDelete()
                    }
                ) {
                    Text(AppStrings.DELETE, color = MaterialTheme.colorScheme.error)
                }
            },
            dismissButton = {
                TextButton(onClick = { showDeleteDialog = false }) {
                    Text(AppStrings.CANCEL)
                }
            }
        )
    }
}
