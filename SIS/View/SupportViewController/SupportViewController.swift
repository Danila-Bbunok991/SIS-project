import UIKit

class SupportViewController: UIViewController {
    //MARK: Private initialization
    
    //Создание градиента
    private lazy var gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        
        //Цвет градиента
        gradient.colors = [
            UIColor(named: "firstColor")?.cgColor as Any,
            UIColor(named: "secondColor")?.cgColor as Any,
            UIColor(named: "thirdColor")?.cgColor as Any,
            UIColor(named: "fourthColor")?.cgColor as Any,
            UIColor(named: "fifthColor")?.cgColor as Any
        ]
        gradient.startPoint = CGPoint(x: 0, y: 1) //Слева направо
        gradient.endPoint = CGPoint(x: 2, y: 1)
        gradient.frame = CGRect(x: 0, y: 0, width: 319, height: 50)
        return gradient
    }()
    
    //Создание основного стека
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            firstLabel,
            secondLabel,
            button
        ])
        stack.axis = .vertical
        stack.alignment = .center
        return stack
    }()
    
    //Создание первого Label
    private lazy var firstLabel: UILabel = {
        let label = UILabel()
        label.widthAnchor.constraint(equalToConstant: 200).isActive = true
        label.heightAnchor.constraint(equalToConstant: 55).isActive = true
        label.font = UIFont.systemFont(ofSize: 24)
        label.textAlignment = .center
        label.text = "Не пришел код?"
        label.textColor = .white
        return label
    }()
    
    //Создание второго Label
    private lazy var secondLabel: UILabel = {
        let label = UILabel()
        label.widthAnchor.constraint(equalToConstant: 185).isActive = true
        label.heightAnchor.constraint(equalToConstant: 60).isActive = true
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 3
        label.text = "Не пришел код? Обратитесь в чат поддержки"
        label.textColor = .white
        return label
    }()
    
    //Создание Button
    private lazy var button: UIButton = {
        let button = UIButton()
        button.widthAnchor.constraint(equalToConstant: 319).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.insertSublayer(gradientLayer, at: 0)
        button.titleLabel?.widthAnchor.constraint(equalToConstant: 200).isActive = true
        button.titleLabel?.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.setTitle("Обратиться в поддержку", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.titleLabel?.textAlignment = .center
        
        //Установка таргета
        button.addTarget(nil, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "viewColor")
        
        setupViews()
    }
    
    //MARK: Private setup
    
    private func setupViews() {
        view.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 157),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        // Установка индивидуальных отступов
        mainStackView.setCustomSpacing(4, after: firstLabel)
        mainStackView.setCustomSpacing(230, after: secondLabel)
    }
    
    //Обработка нажатия на button
    @objc func buttonTapped() {
        let alert = UIAlertController(title: "Функция недоступна!", message: "Функция недоработана, разработчик в отпуске", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
}
