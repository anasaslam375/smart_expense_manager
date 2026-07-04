import SwiftUI

struct AlertView: ViewModifier {
    let title: String
    let message: String?
    let isPresented: Binding<Bool>
    let onDismiss: () -> Void
    
    func body(content: Content) -> some View {
        content
            .alert(title, isPresented: isPresented) {
                Button(AppStrings.ok) {
                    onDismiss()
                }
            } message: {
                if let message = message {
                    Text(message)
                }
            }
    }
}

extension View {
    func alertView(
        title: String = AppStrings.error,
        message: String?,
        isPresented: Binding<Bool>,
        onDismiss: @escaping () -> Void = {}
    ) -> some View {
        self.modifier(AlertView(
            title: title,
            message: message,
            isPresented: isPresented,
            onDismiss: onDismiss
        ))
    }
}
