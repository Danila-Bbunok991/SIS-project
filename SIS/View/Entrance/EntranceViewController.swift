import UIKit

class EntranceViewController: UIViewController {
    //MARK: Private initialization
    
    private let viewModel: EntranceViewModel
    
    init(onButtonTapped: (() -> Void)? = nil, viewModel: EntranceViewModel) {
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
    
    //Создание первого стека
    private lazy var firstStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [pickerNumber, phoneNumberTextField])
        stack.axis = .horizontal
        stack.spacing = 18
        stack.alignment = .center
        return stack
    }()
    
    //Создание второго стека
    private lazy var secondStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [thirdLabel, sendCodeButton])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 53
        return stack
    }()
    
    //Создание picker для отображения региона номера
    private lazy var pickerNumber: UIPickerView = {
        let picker = UIPickerView()
        picker.widthAnchor.constraint(equalToConstant: 70).isActive = true
        picker.heightAnchor.constraint(equalToConstant: 50).isActive = true
        picker.backgroundColor = .clear
        picker.subviews.forEach { subview in
            subview.backgroundColor = .clear
        }
        
        // Установка цвета границы
        picker.layer.borderColor = UIColor(named: "secondColor")?.cgColor
        
        // Установка ширины границы
        picker.layer.borderWidth = 2.0
        
        picker.layer.cornerRadius = 10
        picker.clipsToBounds = true
        
        return picker
    }()
    
    //Создание TextField для ввода номера
    private lazy var phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.widthAnchor.constraint(equalToConstant: 231).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        textField.font = UIFont.systemFont(ofSize: 19)
        textField.textAlignment = .center
        textField.textColor = .white
        
        // Установка цвета границы
        textField.layer.borderColor = UIColor(named: "secondColor")?.cgColor
        
        // Установка ширины границы
        textField.layer.borderWidth = 2.0

        textField.layer.cornerRadius = 10
        textField.clipsToBounds = true
        
        return textField
    }()
    
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
    
    private lazy var secondLabel: UILabel = {
        let label = UILabel()
        label.widthAnchor.constraint(equalToConstant: 113).isActive = true
        label.heightAnchor.constraint(equalToConstant: 15).isActive = true
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        label.text = "Номер телефона"
        label.textColor = .white
        return label
    }()
    
    private lazy var thirdLabel: UILabel = {
        let label = UILabel()
        label.widthAnchor.constraint(equalToConstant: 245).isActive = true
        label.heightAnchor.constraint(equalToConstant: 17).isActive = true
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        label.text = "Код придет на ваш номер телефона"
        label.textColor = .white
        return label
    }()
    
    //
    private lazy var sendCodeButton: UIButton = {
        let button = UIButton()
        button.widthAnchor.constraint(equalToConstant: 319).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        button.titleLabel?.widthAnchor.constraint(equalToConstant: 160).isActive = true
        button.titleLabel?.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.setTitle("Получить код", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        button.layer.insertSublayer(gradientLayer, at: 0)
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.titleLabel?.textAlignment = .center
        
        button.addTarget(nil, action: #selector(sendCodeTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = firstLabel
        navigationItem.titleView?.tintColor = .white
        
        view.backgroundColor = UIColor(named: "viewColor")
        
        pickerNumber.dataSource = self
        pickerNumber.delegate = self
        
        setupViews()
    }
    
    //MARK: Private setup
    
    private func setupViews() {
        view.addSubview(secondLabel)
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34),
            secondLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 135),
        ])
        
        view.addSubview(firstStackView)
        firstStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstStackView.topAnchor.constraint(equalTo: secondLabel.bottomAnchor, constant: 15)
        ])
        
        view.addSubview(secondStackView)
        secondStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondStackView.topAnchor.constraint(equalTo: firstStackView.bottomAnchor, constant: 22),
            secondStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
    }
    
    @objc func sendCodeTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        if !phoneNumberTextField.text!.isEmpty {
            //AuthModel.authModel.phoneNumber += phoneNumberTextField.text!
            viewModel.phoneNumber += phoneNumberTextField.text!
            
            viewModel.buttonPressed()
        } else {
            showAlert(message: "Введите номер телефона")
        }
    }
    
    //Вызов Alert
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
}

//Расширение для работы с UIPickerViewDataSource и UIPickerViewDelegate
extension EntranceViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "+7"
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.text = "+7"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 19)
        label.textAlignment = .center
        label.backgroundColor = .clear
        //AuthModel.authModel.phoneNumber += label.text!
        viewModel.phoneNumber += label.text!
        return label
    }
}
