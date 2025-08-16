import UIKit

final class AppCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showFirstVC()
    }
    
    //Вызов начального экрана
    private func showFirstVC() {
        let viewModel = FirstViewModel()
        let viewController = ViewController(viewModel: viewModel)
        viewModel.onButtonTapped = { [weak self] in
            self?.showEntranceVC()
        }
        viewModel.onLabelTapped = { [weak self] in
            self?.showRegistrationVC()
        }
        navigationController.pushViewController(viewController, animated: true)
        
    }
    
    //Вызов экрана входа
    private func showEntranceVC() {
        let viewModel = EntranceViewModel()
        let viewController = EntranceViewController(viewModel: viewModel)

        viewModel.onButtonTapped = { [weak self] in
            self?.showEntranceFirstVC()
        }
        navigationController.pushViewController(viewController, animated: true)
    }
    
    //Вызов второго экрана входа
    private func showEntranceFirstVC() {
        let viewModel = EntranceViewModel()
        let viewController = EntranceFirstVC(viewModel: viewModel)

        viewModel.onButtonTapped = { [weak self] in
            self?.showPasswordVC()
        }
        viewModel.onLabelTapped = { [weak self] in
            self?.showSupportVC()
        }
        navigationController.pushViewController(viewController, animated: true)
    }
    
    //Вызов экрана для создания пароля
    private func showPasswordVC() {
        let viewModel = PasswordViewModel()
        let viewController = PasswordViewController(viewModel: viewModel)

        viewModel.onButtonTapped = { [weak self] in
            self?.showPasswordFirstVC()
        }
        navigationController.pushViewController(viewController, animated: true)
    }
    
    //Вызов второго экрана создания пароля
    private func showPasswordFirstVC() {
        let viewController = PasswordFirstVC()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    //Вызов экрана поддержки
    private func showSupportVC() {
        let viewController = SupportViewController()

        navigationController.pushViewController(viewController, animated: true)
    }
    
    //Вызов экрана регистрации
    private func showRegistrationVC() {
        let viewModel = RegistrationViewModel()
        let viewController = RegistrationViewController(viewModel: viewModel)

        viewModel.onButtonTapped = { [weak self] in
            self?.showRegistrationFirstVC()
        }
        navigationController.pushViewController(viewController, animated: true)
    }
    
    //Вызов второго экрана регистрации
    private func showRegistrationFirstVC() {
        let viewModel = RegistrationViewModel()
        let viewController = RegistrationFirstVC(viewModel: viewModel)

        viewModel.onButtonTapped = { [weak self] in
            self?.showPasswordVC()
        }
        viewModel.onLabelTapped = { [weak self] in
            self?.showSupportVC()
        }
        navigationController.pushViewController(viewController, animated: true)
    }
}
