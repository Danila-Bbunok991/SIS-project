import UIKit

class ViewController: UIViewController {
    
    //MARK: Private initialization
    
    private let viewModel: FirstViewModel //Экземпляр FirstViewModel
    
    init(onButtonTapped: (() -> Void)? = nil, viewModel: FirstViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
            iconImage,
            firstLabel,
            secondLabel,
            nextVCButton,
            stackView
        ])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 8
        return stack
    }()
    
    //Создание второстепенного стека
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [thirdLabel, fourthLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .center
        stack.widthAnchor.constraint(equalToConstant: 187).isActive = true
        stack.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return stack
    }()
    
    //Создание ImageView
    private lazy var iconImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "icon")
        image.widthAnchor.constraint(equalToConstant: 79).isActive = true
        image.heightAnchor.constraint(equalToConstant: 79).isActive = true
        return image
    }()
    
    //Создание первого Label
    private lazy var firstLabel: UILabel = {
        let label = UILabel()
        label.widthAnchor.constraint(equalToConstant: 53).isActive = true
        label.heightAnchor.constraint(equalToConstant: 43).isActive = true
        label.font = UIFont.systemFont(ofSize: 34)
        label.text = "SIS"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    //Создание второго Label
    private lazy var secondLabel: UILabel = {
        let label = UILabel()
        label.widthAnchor.constraint(equalToConstant: 230).isActive = true
        label.heightAnchor.constraint(equalToConstant: 23).isActive = true
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .center
        label.text = "Выбери свою безопасность"
        label.textColor = .white
        return label
    }()
    
    //Создание третьего Label
    private lazy var thirdLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.text = "У вас нет аккаунта?"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    //Создание четвёртого Label
    private lazy var fourthLabel: UILabel = {
        //Создание новой Attributed String
        let attributedString = NSMutableAttributedString.init(string: "Зарегистрируйтесь сейчас")
        //Добавление Underline Style Attribute.
        attributedString.addAttribute(
            NSAttributedString.Key.underlineStyle,
            value: 1,
            range: NSRange.init(location: 0, length: attributedString.length)
        )
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.attributedText = attributedString
        label.textColor = .systemBlue
        label.textAlignment = .center
        label.isUserInteractionEnabled = true

        let tap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped))
        label.addGestureRecognizer(tap)
        
        return label
    }()
    
    //Создание Button
    private lazy var nextVCButton: UIButton = {
        let button = UIButton()
        
        button.widthAnchor.constraint(equalToConstant: 319).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        button.titleLabel?.widthAnchor.constraint(equalToConstant: 214).isActive = true
        button.titleLabel?.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.setTitle("Войти по номеру телефона", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        button.layer.insertSublayer(gradientLayer, at: 0)
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        
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
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            iconImage.topAnchor.constraint(equalTo: mainStackView.topAnchor, constant: 265),
        ])
        
        // Установка индивидуальных отступов
        mainStackView.setCustomSpacing(32, after: iconImage)
        mainStackView.setCustomSpacing(18, after: firstLabel)
        mainStackView.setCustomSpacing(100, after: secondLabel)
        mainStackView.setCustomSpacing(100, after: nextVCButton)
        
    }
    
    @objc func labelTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        viewModel.labelPressed()
    }
    
    @objc func buttonTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        viewModel.buttonPressed()
    }
}

