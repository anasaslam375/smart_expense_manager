package com.smartexpense.manager.presentation.extensions

import com.smartexpense.manager.presentation.utils.CurrencyFormatter

fun Double.toCurrency(): String {
    return CurrencyFormatter.format(this)
}
