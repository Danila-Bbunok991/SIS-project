class FirstViewModel {
    var onButtonTapped: (() -> Void)?
    var onLabelTapped: (() -> Void)?
    
    func buttonPressed() {
        onButtonTapped?()
    }
    
    func labelPressed() {
        onLabelTapped?()
    }
}
