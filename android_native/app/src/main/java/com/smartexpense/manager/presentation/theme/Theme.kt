package com.smartexpense.manager.presentation.theme

import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.lightColorScheme
import androidx.compose.material3.darkColorScheme
import androidx.compose.runtime.Composable
import com.smartexpense.manager.presentation.constants.AppColors

private val LightColorScheme = lightColorScheme(
    primary = AppColors.primary,
    secondary = AppColors.secondary,
    tertiary = AppColors.tertiary,
    background = AppColors.lightBackground,
    surface = AppColors.lightSurface,
    onPrimary = AppColors.lightOnPrimary,
    onSecondary = AppColors.lightOnSecondary,
    onTertiary = AppColors.lightOnTertiary,
    onBackground = AppColors.lightOnBackground,
    onSurface = AppColors.lightOnSurface,
)

private val DarkColorScheme = darkColorScheme(
    primary = AppColors.primary,
    secondary = AppColors.secondary,
    tertiary = AppColors.tertiary,
    background = AppColors.darkBackground,
    surface = AppColors.darkSurface,
    onPrimary = AppColors.darkOnPrimary,
    onSecondary = AppColors.darkOnSecondary,
    onTertiary = AppColors.darkOnTertiary,
    onBackground = AppColors.darkOnBackground,
    onSurface = AppColors.darkOnSurface,
)

@Composable
fun SmartExpenseManagerTheme(
    darkTheme: Boolean = false,
    content: @Composable () -> Unit
) {
    val colorScheme = if (darkTheme) DarkColorScheme else LightColorScheme

    MaterialTheme(
        colorScheme = colorScheme,
        typography = Typography,
        content = content
    )
}
