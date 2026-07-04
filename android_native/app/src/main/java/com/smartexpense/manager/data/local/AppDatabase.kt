package com.smartexpense.manager.data.local

import androidx.room.Database
import androidx.room.RoomDatabase
import com.smartexpense.manager.data.local.entity.ExpenseEntity
import com.smartexpense.manager.presentation.constants.AppConstants

@Database(
    entities = [ExpenseEntity::class],
    version = AppConstants.DATABASE_VERSION,
    exportSchema = false
)
abstract class AppDatabase : RoomDatabase() {
    abstract fun expenseDao(): ExpenseDao
}
