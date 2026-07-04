package com.smartexpense.manager.presentation.utils

import androidx.compose.ui.graphics.Color

object ColorParser {
    fun parseColor(colorString: String): Color {
        return Color(android.graphics.Color.parseColor(colorString))
    }
}
