class PasswordViewModel {
    var onButtonTapped: (() -> Void)?
    
    func buttonPressed() {
        onButtonTapped?()
    }
}
