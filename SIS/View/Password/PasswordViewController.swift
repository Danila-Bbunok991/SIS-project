import UIKit

class PasswordViewController: UIViewController {
    
    private let viewModel: PasswordViewModel
    
    init(onButtonTapped: (() -> Void)? = nil, viewModel: PasswordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var array: [UITextField] = []
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            secondLabel,
            thirdLabel,
            firstTextField,
            button,
        ])
        stack.axis = .vertical
        stack.alignment = .center
        return stack
    }()
    
    private lazy var firstLabel: UILabel = {
        let label = UILabel()
        label.widthAnchor.constraint(equalToConstant: 172).isActive = true
        label.heightAnchor.constraint(equalToConstant: 37).isActive = true
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Код приложения"
        label.textColor = .white
        return label
    }()
    
    private lazy var secondLabel: UILabel = {
        let label = UILabel()
        label.widthAnchor.constraint(equalToConstant: 316).isActive = true
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.font = UIFont.systemFont(ofSize: 24)
        label.textAlignment = .center
        label.text = "Создайте код приложения"
        label.textColor = .white
        return label
    }()
    
    private lazy var thirdLabel: UILabel = {
        let label = UILabel()
        label.widthAnchor.constraint(equalToConstant: 195).isActive = true
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = "Введите код из символов"
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var firstTextField: UITextField = {
        let textField = UITextField()
        textField.widthAnchor.constraint(equalToConstant: 180).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.font = UIFont.systemFont(ofSize: 19)
        textField.textAlignment = .center
        textField.textColor = .white
        textField.backgroundColor = UIColor(named: "UIColor")
        
        // Устанавливаем цвет границы
        textField.layer.borderColor = UIColor(named: "secondColor")?.cgColor
        // Устанавливаем ширину границы
        textField.layer.borderWidth = 2.0
        
        textField.layer.cornerRadius = 25
        textField.clipsToBounds = true
        
        textField.keyboardType = .numberPad
        textField.isSecureTextEntry = true
        
        return textField
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.widthAnchor.constraint(equalToConstant: 319).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.backgroundColor = .blue
        button.titleLabel?.widthAnchor.constraint(equalToConstant: 160).isActive = true
        button.titleLabel?.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.setTitle("Пропустить", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.titleLabel?.textAlignment = .center
        
        button.addTarget(nil, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = firstLabel
        navigationItem.titleView?.tintColor = .white
        view.backgroundColor = UIColor(named: "viewColor")
        
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 75),
            
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        // Устанавливаем индивидуальные отступы
        mainStackView.setCustomSpacing(47, after: secondLabel)
        mainStackView.setCustomSpacing(36, after: thirdLabel)
        mainStackView.setCustomSpacing(77, after: firstTextField)
    }
    
    @objc func buttonTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        viewModel.buttonPressed()
    }
}
