class EntranceViewModel {
    var onButtonTapped: (() -> Void)?
    var onLabelTapped: (() -> Void)?
    
    var phoneNumber: String = ""
    
    func buttonPressed() {
        AuthModel.authModel.phoneNumber = phoneNumber
        onButtonTapped?()
    }
    
    func labelPressed() {
        onLabelTapped?()
    }
}
