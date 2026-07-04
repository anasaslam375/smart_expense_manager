package com.smartexpense.manager.presentation.extensions

import com.smartexpense.manager.presentation.utils.DateFormatter
import java.util.Date

fun Date.toFormattedDate(): String {
    return DateFormatter.format(this)
}
