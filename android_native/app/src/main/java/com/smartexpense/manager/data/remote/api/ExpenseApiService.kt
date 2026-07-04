package com.smartexpense.manager.data.remote.api

import com.smartexpense.manager.data.remote.dto.ExpenseDto
import retrofit2.Response
import retrofit2.http.*

interface ExpenseApiService {
    
    @GET("expenses")
    suspend fun getExpenses(): Response<List<ExpenseDto>>
    
    @GET("expenses/{id}")
    suspend fun getExpenseById(@Path("id") id: String): Response<ExpenseDto>
    
    @POST("expenses")
    suspend fun createExpense(@Body expense: ExpenseDto): Response<ExpenseDto>
    
    @PUT("expenses/{id}")
    suspend fun updateExpense(@Path("id") id: String, @Body expense: ExpenseDto): Response<ExpenseDto>
    
    @DELETE("expenses/{id}")
    suspend fun deleteExpense(@Path("id") id: String): Response<Unit>
    
    @GET("expenses/category/{categoryId}")
    suspend fun getExpensesByCategory(@Path("categoryId") categoryId: String): Response<List<ExpenseDto>>
    
    @GET("expenses/date/{date}")
    suspend fun getExpensesByDate(@Path("date") date: String): Response<List<ExpenseDto>>
}
