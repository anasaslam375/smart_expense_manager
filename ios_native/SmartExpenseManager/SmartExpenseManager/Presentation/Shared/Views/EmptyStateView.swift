import SwiftUI
import SmartExpenseManager

struct EmptyStateView: View {
    let icon: String
    let title: String
    let message: String
    
    init(
        icon: String = AppIcons.receipt,
        title: String = AppStrings.noExpensesYet,
        message: String = AppStrings.tapToAddExpense
    ) {
        self.icon = icon
        self.title = title
        self.message = message
    }
    
    var body: some View {
        VStack(spacing: AppConstants.emptyStateSpacing) {
            Image(systemName: icon)
                .font(.system(size: AppConstants.emptyStateIconSize))
                .foregroundColor(AppColors.gray)
            Text(title)
                .font(.title2)
                .foregroundColor(AppColors.gray)
            Text(message)
                .font(.body)
                .foregroundColor(AppColors.gray)
                .multilineTextAlignment(.center)
        }
        .padding(AppConstants.emptyStatePadding)
    }
}

#Preview {
    EmptyStateView()
}
