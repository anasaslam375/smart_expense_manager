package com.smartexpense.manager.presentation.utils

import com.smartexpense.manager.presentation.constants.AppStrings

object CurrencyFormatter {
    fun format(amount: Double): String {
        return "${AppStrings.CURRENCY_SYMBOL}${String.format("%.2f", amount)}"
    }
}
