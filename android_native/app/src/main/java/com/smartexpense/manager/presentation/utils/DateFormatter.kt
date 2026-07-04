package com.smartexpense.manager.presentation.utils

import com.smartexpense.manager.presentation.constants.AppConstants
import com.smartexpense.manager.presentation.constants.AppStrings
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale

object DateFormatter {
    fun format(date: Date): String {
        val now = Date()
        val diff = now.time - date.time
        val days = diff / AppConstants.millisecondsPerDay

        return when {
            days == 0L -> AppStrings.TODAY
            days == 1L -> AppStrings.YESTERDAY
            days < 7L -> "${days} days ago"
            else -> SimpleDateFormat(AppConstants.DATE_FORMAT, Locale.getDefault()).format(date)
        }
    }
}
