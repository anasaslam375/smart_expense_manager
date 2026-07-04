import Foundation

struct Expense: Identifiable, Codable {
    let id: UUID
    let amount: Double
    let category: Category
    let date: Date
    let note: String?
    let receiptURL: String?
    let createdAt: Date
    let updatedAt: Date
    
    init(
        id: UUID = UUID(),
        amount: Double,
        category: Category,
        date: Date = Date(),
        note: String? = nil,
        receiptURL: String? = nil,
        createdAt: Date = Date(),
        updatedAt: Date = Date()
    ) {
        self.id = id
        self.amount = amount
        self.category = category
        self.date = date
        self.note = note
        self.receiptURL = receiptURL
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        
        // Validation
        precondition(amount > 0, "Amount must be positive")
        precondition(amount <= AppConstants.maxAmount, "Amount cannot exceed 1,000,000.00")
        precondition((amount * 100).rounded() / 100 == amount, "Amount can have maximum 2 decimal places")
        precondition(date <= Date(), "Date cannot be in the future")
        precondition(note == nil || note!.count <= AppConstants.maxNoteLength, "Note cannot exceed 500 characters")
        precondition(receiptURL == nil || receiptURL!.hasPrefix(AppConstants.httpsPrefix), "Receipt URL must use HTTPS")
    }
}

struct Category: Identifiable, Codable, Hashable {
    let id: UUID
    let name: String
    let icon: String
    let color: String
    
    init(
        id: UUID = UUID(),
        name: String,
        icon: String,
        color: String
    ) {
        self.id = id
        self.name = name
        self.icon = icon
        self.color = color
        
        // Validation
        precondition((AppConstants.minCategoryNameLength...AppConstants.maxCategoryNameLength).contains(name.count), "Category name must be 1-50 characters")
        precondition(color.matches(pattern: "^#[0-9A-Fa-f]{6}$"), "Color must be valid hex format")
    }
    
    static let defaultCategories: [Category] = [
        Category(name: "Food", icon: "🍔", color: "#FF6B6B"),
        Category(name: "Transport", icon: "🚗", color: "#4ECDC4"),
        Category(name: "Shopping", icon: "🛍️", color: "#45B7D1"),
        Category(name: "Entertainment", icon: "🎬", color: "#96CEB4"),
        Category(name: "Bills", icon: "📄", color: "#FFEAA7"),
        Category(name: "Health", icon: "❤️", color: "#DDA0DD"),
        Category(name: "Education", icon: "📚", color: "#98D8C8"),
        Category(name: "Travel", icon: "✈️", color: "#F7DC6F"),
        Category(name: "Other", icon: "📦", color: "#95A5A6")
    ]
}

extension String {
    func matches(pattern: String) -> Bool {
        return self.range(of: pattern, options: .regularExpression) != nil
    }
}
