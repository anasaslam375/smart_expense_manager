package com.smartexpense.manager.presentation.feature.expense

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import androidx.compose.ui.window.Dialog
import com.smartexpense.manager.domain.model.Category
import com.smartexpense.manager.presentation.constants.AppConstants
import com.smartexpense.manager.presentation.constants.AppStrings
import java.util.Date

@Composable
fun AddExpenseBottomSheet(
    onDismiss: () -> Unit,
    onExpenseAdded: (Double, Category, Date, String?) -> Unit
) {
    var amount by remember { mutableStateOf("") }
    var selectedCategory by remember { mutableStateOf(Category.defaultCategories.first()) }
    var note by remember { mutableStateOf("") }
    var selectedDate by remember { mutableStateOf(Date()) }

    Dialog(onDismissRequest = onDismiss) {
        Card(
            modifier = Modifier
                .fillMaxWidth()
                .padding(AppConstants.bottomSheetPadding),
            shape = RoundedCornerShape(AppConstants.bottomSheetCornerRadius)
        ) {
            Column(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(AppConstants.bottomSheetInnerPadding)
                    .verticalScroll(rememberScrollState())
            ) {
                Text(
                    AppStrings.ADD_EXPENSE,
                    style = MaterialTheme.typography.headlineSmall,
                    fontWeight = androidx.compose.ui.text.font.FontWeight.Bold
                )

                Spacer(modifier = Modifier.height(AppConstants.bottomSheetInnerPadding))

                // Amount Input
                OutlinedTextField(
                    value = amount,
                    onValueChange = { amount = it },
                    label = { Text(AppStrings.AMOUNT) },
                    modifier = Modifier.fillMaxWidth(),
                    keyboardOptions = androidx.compose.foundation.text.KeyboardOptions(
                        keyboardType = androidx.compose.foundation.text.KeyboardType.Decimal
                    )
                )

                Spacer(modifier = Modifier.height(AppConstants.spacingLarge))

                // Category Selection
                Text(
                    AppStrings.CATEGORY,
                    style = MaterialTheme.typography.titleMedium
                )
                Spacer(modifier = Modifier.height(AppConstants.spacingSmall))

                FlowRow(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.spacedBy(AppConstants.spacingSmall)
                ) {
                    Category.defaultCategories.forEach { category ->
                        FilterChip(
                            selected = selectedCategory.id == category.id,
                            onClick = { selectedCategory = category },
                            label = { Text(category.icon) },
                            modifier = Modifier.height(AppConstants.categoryChipHeight)
                        )
                    }
                }

                Spacer(modifier = Modifier.height(AppConstants.spacingLarge))

                // Note Input
                OutlinedTextField(
                    value = note,
                    onValueChange = { note = it },
                    label = { Text(AppStrings.NOTE_OPTIONAL) },
                    modifier = Modifier.fillMaxWidth(),
                    maxLines = AppConstants.maxLinesThree
                )

                Spacer(modifier = Modifier.height(AppConstants.bottomSheetInnerPadding))

                // Add Button
                Button(
                    onClick = {
                        val amountValue = amount.toDoubleOrNull() ?: 0.0
                        if (amountValue > 0) {
                            onExpenseAdded(amountValue, selectedCategory, selectedDate, note.ifBlank { null })
                            onDismiss()
                        }
                    },
                    modifier = Modifier.fillMaxWidth(),
                    enabled = amount.isNotBlank() && amount.toDoubleOrNull() != null
                ) {
                    Text(AppStrings.ADD_EXPENSE)
                }
            }
        }
    }
}
