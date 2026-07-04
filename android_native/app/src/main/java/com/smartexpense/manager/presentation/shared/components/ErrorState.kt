package com.smartexpense.manager.presentation.shared.components

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.ErrorOutline
import androidx.compose.material3.Button
import androidx.compose.material3.Icon
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import com.smartexpense.manager.presentation.constants.AppConstants
import com.smartexpense.manager.presentation.constants.AppStrings

@Composable
fun ErrorState(
    message: String = AppStrings.UNKNOWN_ERROR,
    onRetry: () -> Unit
) {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(AppConstants.cardPadding),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        Icon(
            imageVector = Icons.Default.ErrorOutline,
            contentDescription = null,
            tint = AppColors.red,
            modifier = Modifier.height(AppConstants.errorStateIconSize.dp)
        )
        Spacer(modifier = Modifier.height(AppConstants.spacingMedium))
        Text(
            text = message,
            style = MaterialTheme.typography.bodyMedium,
            color = AppColors.red,
            textAlign = TextAlign.Center
        )
        Spacer(modifier = Modifier.height(AppConstants.spacingLarge))
        Button(onClick = onRetry) {
            Text(AppStrings.RETRY)
        }
    }
}
