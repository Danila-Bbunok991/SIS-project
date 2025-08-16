import UIKit

class EntranceFirstVC: UIViewController {
    //MARK: Private initialization
    
    private let viewModel: EntranceViewModel
    
    init(onButtonTapped: (() -> Void)? = nil, viewModel: EntranceViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Создание массива, где будут храниться TextField
    private var textFieldArray: [UITextField] = []
    
    //Создание таймера
    private var timer: Timer?
    private var remainingSeconds = 300 //5 минут
    
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
            secondLabel,
            thirdLabel,
            fourthLabel,
            stackView,
            entranceButton,
            fifthLabel
        ])
        stack.axis = .vertical
        stack.alignment = .center
        return stack
    }()
    
    //Создание второстепенного стека для размещения TextField
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        return stack
    }()
    
    //Создание первого Label
    private lazy var firstLabel: UILabel = {
        let label = UILabel()
        label.widthAnchor.constraint(equalToConstant: 211).isActive = true
        label.heightAnchor.constraint(equalToConstant: 37).isActive = true
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Войти"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    //Создание второго Label
    private lazy var secondLabel: UILabel = {
        let label = UILabel()
        label.widthAnchor.constraint(equalToConstant: 165).isActive = true
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.font = UIFont.systemFont(ofSize: 24)
        label.textAlignment = .center
        label.text = "Верификация"
        label.textColor = .white
        return label
    }()
    
    //Создание третьего Label
    private lazy var thirdLabel: UILabel = {
        let label = UILabel()
        label.widthAnchor.constraint(equalToConstant: 182).isActive = true
        label.heightAnchor.constraint(equalToConstant: 40).isActive = true
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = "Введите код из смс, что мы отправили вам"
        label.textColor = .lightGray
        return label
    }()
    
    //Создание четвёртого Label
    private lazy var fourthLabel: UILabel = {
        let label = UILabel()
        label.widthAnchor.constraint(equalToConstant: 185).isActive = true
        label.heightAnchor.constraint(equalToConstant: 40).isActive = true
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = "Запросить код можно через 05:00"
        label.textColor = .white
        return label
    }()
    
    //Создание пятого Label
    private lazy var fifthLabel: UILabel = {
        // Создание новой Attributed String
        let attributedString = NSMutableAttributedString.init(string: "Я не получил код!")
        
        // Добавление Underline Style Attribute.
        attributedString.addAttribute(
            NSAttributedString.Key.underlineStyle,
            value: 1,
            range: NSRange.init(location: 0, length: attributedString.length)
        )
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.widthAnchor.constraint(equalToConstant: 127).isActive = true
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.attributedText = attributedString
        label.textAlignment = .center
        label.textColor = .white
        
        label.isUserInteractionEnabled = true //Включение .isUserInteractionEnabled для взаимодействия с label
        
        //Установка таргета
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped))
        label.addGestureRecognizer(tap)
        
        return label
    }()
    
    //Создание Button для входа
    private lazy var entranceButton: UIButton = {
        let button = UIButton()
        button.widthAnchor.constraint(equalToConstant: 319).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.insertSublayer(gradientLayer, at: 0)
        button.titleLabel?.widthAnchor.constraint(equalToConstant: 160).isActive = true
        button.titleLabel?.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.setTitle("Войти", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.titleLabel?.textAlignment = .center
        
        button.addTarget(nil, action: #selector(verifyCodeTapped), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = firstLabel
        navigationItem.titleView?.tintColor = .white
        view.backgroundColor = UIColor(named: "viewColor")
        
        setupViews()
        fillTextFields()
        startTimer()
    }
    
    //MARK: Private setup
    
    private func setupViews() {
        //Настройка и добавление mainStackView в view
        view.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 67),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        // Установка индивидуальных отступов
        mainStackView.setCustomSpacing(18, after: secondLabel)
        mainStackView.setCustomSpacing(35, after: thirdLabel)
        mainStackView.setCustomSpacing(52, after: fourthLabel)
        mainStackView.setCustomSpacing(28, after: stackView)
        mainStackView.setCustomSpacing(31, after: entranceButton)
        
        //Настройка и добавление TextField в stackView
        for i in 0..<6 {
            let textField = UITextField()
            configureTextField(textField)
            textFieldArray.append(textField)
            stackView.addArrangedSubview(textFieldArray[i])
        }
    }
    
    // TextField конфигурация
    func configureTextField(_ textField: UITextField) {
        textField.widthAnchor.constraint(equalToConstant: 50).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.font = UIFont.systemFont(ofSize: 22)
        textField.textAlignment = .center
        textField.textColor = .white
        
        // Установка цвета границы
        textField.layer.borderColor = UIColor(named: "secondColor")?.cgColor
        
        // Установка ширины границы
        textField.layer.borderWidth = 2.0
        textField.layer.cornerRadius = 10
        textField.clipsToBounds = true
        
    }
        
    //Создание alert
//    func showAlert(message:String) {
//        let alertVC = UIAlertController(title:nil, message: message, preferredStyle:.alert)
//        alertVC.addAction(UIAlertAction(title:"OK", style:.default))
//        present(alertVC, animated:true)
//    }
    
    //Заполнение TextField
    private func fillTextFields() {
        let chars = Array(AuthModel.authModel.codeSMS)
        
        for (index, textField) in textFieldArray.enumerated() {
            if index < AuthModel.authModel.codeSMS.count {
                textField.text = String(chars[index])
            } else {
                textField.text = ""
            }
        }
    }
    
    //Запуск таймера
    private func startTimer() {
        updateLabel()
        
        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(updateTimer),
            userInfo: nil,
            repeats: true
        )
    }
    
    //Обновление таймера
    @objc private func updateTimer() {
        remainingSeconds -= 1
        
        if remainingSeconds <= 0 {
            timer?.invalidate()
            timer = nil
        } else { updateLabel() }
    }
    
    //Обновление текста fourthLabel
    private func updateLabel() {
        let minutes = remainingSeconds / 60
        let seconds = remainingSeconds % 60
        fourthLabel.text = String(format: "Запросить код можно через %02d:%02d", minutes, seconds)
    }
    
    //Обработка нажатия на label
    @objc func labelTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        viewModel.labelPressed()
    }
    
    //Обработка нажатия на button
    @objc func verifyCodeTapped() {
        viewModel.buttonPressed()
    }
}
