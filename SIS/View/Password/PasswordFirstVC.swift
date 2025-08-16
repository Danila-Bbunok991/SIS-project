import UIKit

class PasswordFirstVC: UIViewController {
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            firstView,
            button
        ])
        stack.axis = .vertical
        stack.alignment = .center
        return stack
    }()
    
    private lazy var firstView: UIView = {
        let view = UIView()
        view.widthAnchor.constraint(equalToConstant: 330).isActive = true
        view.heightAnchor.constraint(equalToConstant: 118).isActive = true
        view.backgroundColor = UIColor(named: "textFieldColor")
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var firstLabel: UILabel = {
        let label = UILabel()
        label.widthAnchor.constraint(equalToConstant: 240).isActive = true
        label.heightAnchor.constraint(equalToConstant: 40).isActive = true
        label.font = UIFont.systemFont(ofSize: 16)
        label.backgroundColor = UIColor(named: "textFieldColor")
        label.text = "Вы успешно создали код приложения"
        label.textColor = .white
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.widthAnchor.constraint(equalToConstant: 330).isActive = true
        button.heightAnchor.constraint(equalToConstant: 70).isActive = true
        button.backgroundColor = UIColor(named: "textFieldColor")
        
        button.titleLabel?.widthAnchor.constraint(equalToConstant: 170).isActive = true
        button.titleLabel?.heightAnchor.constraint(equalToConstant: 25).isActive = true
        button.setTitle("Войти в приложение", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.setTitleColor(.systemBlue, for: .normal)
        
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.titleLabel?.textAlignment = .center
        
        button.addTarget(nil, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "viewColor")
    
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 325),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        // Устанавливаем индивидуальные отступы
        mainStackView.setCustomSpacing(24, after: firstView)
        
        firstView.addSubview(firstLabel)
        firstLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstLabel.centerXAnchor.constraint(equalTo: firstView.centerXAnchor),
            firstLabel.centerYAnchor.constraint(equalTo: firstView.centerYAnchor)
        ])
    }
    
    @objc func buttonTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        
        let alert = UIAlertController(title: "Функция недоступна!", message: "Функция недоработана, разработчик в отпуске", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
}
