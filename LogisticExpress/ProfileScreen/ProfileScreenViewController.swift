import UIKit

class ProfileScreenViewController: SGStackViewController {
    
    weak var coordinator: ProfileScreenCoordinator?
    
    private lazy var userView: UIStackView = setupUserInfoView()
    private lazy var notificationView: UIStackView = setupNotificationView()
    
    let organisationName = String("Агро-Нова")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSubviews()
    }
    
    // MARK: CGConstruction funcs
    override func addContent() {
        super.addContent()
        stackView.addArrangedSubview(userView, withSpacing: 5)
        stackView.addArrangedSubview(notificationView)
    }
    
    override func configureContent() {
        super.configureContent()
        stackView.spacing = 15
        
        //self.navigationController?.hidesBarsOnTap = true
        //self.navigationController?.hidesBarsOnSwipe = true
        
        let logOutBarButton = UIBarButtonItem(image: UIImage(named: "logout"), style: .plain, target: self, action: #selector(logOut))
        navigationItem.rightBarButtonItem = logOutBarButton
        navigationController?.navigationBar.tintColor = .black
        
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width:0, height: 0.2))
        lineView.backgroundColor = .black
        navigationController?.navigationBar.addSubview(lineView)
        
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.widthAnchor.constraint(equalTo: (navigationController?.navigationBar.widthAnchor)!).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 0.2).isActive = true
        lineView.centerXAnchor.constraint(equalTo: (navigationController?.navigationBar.centerXAnchor)!).isActive = true
        lineView.topAnchor.constraint(equalTo: (navigationController?.navigationBar.bottomAnchor)!).isActive = true
    }
    
    override func styleContent() {
        super.styleContent()
        self.navigationItem.title = "Профіль"
        
        view.backgroundColor = .white
        
        notificationView.layer.cornerRadius = 12
        notificationView.layer.shadowColor = UIColor.black.cgColor
        notificationView.layer.shadowOpacity = 0.2
        notificationView.layer.shadowOffset = CGSize(width: 0, height: 2)
        notificationView.layer.shadowRadius = 5
        notificationView.layer.borderWidth = 0.2
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    func setupUserInfoView() -> UIStackView{
        let viewPersonHeight: CGFloat = 180
        
        let stack = UIStackView()
        stack.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        stack.isLayoutMarginsRelativeArrangement = true
        
        // Установить положение компонентов внутри Stack
        stack.axis = .vertical
        stack.spacing = 10
        
        stack.backgroundColor = .white
        stack.layer.cornerRadius = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.layer.borderWidth = 0.2
        stack.layer.borderColor = UIColor.gray.cgColor
        
        stack.layer.shadowColor = UIColor.black.cgColor
        stack.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        stack.layer.shadowOpacity = 0.2
        stack.layer.shadowRadius = 2.0
        stack.heightAnchor.constraint(equalToConstant: viewPersonHeight).isActive = true
        
        let nameView = UIView()
        //nameView.backgroundColor = .white
        //nameView.layer.cornerRadius = 10
        nameView.translatesAutoresizingMaskIntoConstraints = false
        nameView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        stack.addSubview(nameView)
        
        let nameLabel = UILabel()
        nameLabel.text = "ТОВ \(organisationName)"
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.textColor = .black
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.sizeToFit()//If required
        nameView.addSubview(nameLabel)
        
        // Создаем изображение для кнопки
        let buttonImage = UIImage(named: "pensil")
        
        // Создаем кнопку и устанавливаем изображение
        let profileEditButton = UIButton(type: .custom)
        profileEditButton.setImage(buttonImage, for: .normal)
        
        // Устанавливаем размер кнопки
        let buttonSize = CGSize(width: 20, height: 20)
        profileEditButton.frame = CGRect(x: nameView.center.x + 335, y: 10, width: buttonSize.width, height: buttonSize.height)
        
        // Добавляем обработчик нажатия на кнопку
        profileEditButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        nameView.addSubview(profileEditButton)
        
        let stroke = UIView()
        stroke.translatesAutoresizingMaskIntoConstraints = false
        stroke.backgroundColor = .lightGray
        stack.addSubview(stroke)
        //
        let infoView = UIView()
        infoView.backgroundColor = .white
        //infoView.layer.cornerRadius = 10
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        stack.addSubview(infoView)
        //
        let stack2 = UIStackView()
        stack2.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        stack2.isLayoutMarginsRelativeArrangement = true
        
        // Установить положение компонентов внутри Stack
        stack2.axis = .horizontal
        stack2.backgroundColor = .white
        
        stack2.translatesAutoresizingMaskIntoConstraints = false
        
        stack2.heightAnchor.constraint(equalToConstant: 30).isActive = true
        infoView.addSubview(stack2)
        
        let lbl1 = UILabel()
        lbl1.text = "E-mail"
        lbl1.textAlignment = .left
        lbl1.textColor = .gray
        lbl1.font = UIFont.systemFont(ofSize: 15)
        lbl1.translatesAutoresizingMaskIntoConstraints = false
        stack2.addSubview(lbl1)
        
        let lbl2 = UILabel()
        lbl2.text = "george@gmail.com"
        lbl2.textAlignment = .left
        lbl2.font = UIFont.systemFont(ofSize: 15)
        lbl2.translatesAutoresizingMaskIntoConstraints = false
        stack2.addSubview(lbl2)
        //
        let stack3 = UIStackView()
        stack3.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        stack3.isLayoutMarginsRelativeArrangement = true
        
        // Установить положение компонентов внутри Stack
        stack3.axis = .horizontal
        stack3.backgroundColor = .white
        
        stack3.translatesAutoresizingMaskIntoConstraints = false
        
        
        stack3.heightAnchor.constraint(equalToConstant: 30).isActive = true
        infoView.addSubview(stack3)
        //
        let lbl3 = UILabel()
        lbl3.text = "Номер телефону"
        lbl3.textAlignment = .left
        lbl3.textColor = .gray
        lbl3.font = UIFont.systemFont(ofSize: 15)
        lbl3.translatesAutoresizingMaskIntoConstraints = false
        stack3.addArrangedSubview(lbl3)
        
        let lbl4 = UILabel()
        lbl4.text = "+380991234567"
        lbl4.textAlignment = .left
        lbl4.font = UIFont.systemFont(ofSize: 15)
        lbl4.translatesAutoresizingMaskIntoConstraints = false
        stack3.addArrangedSubview(lbl4)
        //
        let stroke2 = UIView()
        stroke2.translatesAutoresizingMaskIntoConstraints = false
        stroke2.backgroundColor = .lightGray
        
        stack.addSubview(stroke2)
        
        let adresView = UIView()
        adresView.backgroundColor = .white
        adresView.layer.cornerRadius = 10
        adresView.translatesAutoresizingMaskIntoConstraints = false
        adresView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        stack.addSubview(adresView)
        
        let lbl5 = UILabel()
        lbl5.text = "Адреса"
        lbl5.textAlignment = .left
        lbl5.textColor = .gray
        lbl5.font = UIFont.systemFont(ofSize: 15)
        lbl5.translatesAutoresizingMaskIntoConstraints = false
        adresView.addSubview(lbl5)
        
        let lbl6 = UILabel()
        lbl6.text = "вул.Перемоги, буд.45"
        lbl6.textAlignment = .left
        lbl6.font = UIFont.systemFont(ofSize: 15)
        lbl6.translatesAutoresizingMaskIntoConstraints = false
        adresView.addSubview(lbl6)
        
        // Создаем изображение для кнопки
        let nextButtonImage = UIImage(named: "next")
        
        // Создаем кнопку и устанавливаем изображение
        let nextButton = UIButton(type: .custom)
        nextButton.setImage(nextButtonImage, for: .normal)
        
        // Устанавливаем размер кнопки
        let nextButtonSize = CGSize(width: 30, height: 30)
        nextButton.frame = CGRect(x: adresView.center.x + 325, y: 15, width: nextButtonSize.width, height: buttonSize.height)
        
        // Добавляем обработчик нажатия на кнопку
        nextButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        adresView.addSubview(nextButton)
        
        
        NSLayoutConstraint.activate([
            
            nameView.topAnchor.constraint(equalTo: stack.topAnchor),
            nameView.leftAnchor.constraint(equalTo: stack.leftAnchor),
            nameView.rightAnchor.constraint(equalTo: stack.rightAnchor),
            nameView.centerXAnchor.constraint(equalTo: stack.centerXAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: nameView.topAnchor, constant: 10),
            nameLabel.leftAnchor.constraint(equalTo: nameView.leftAnchor, constant: 10),
            
            stroke.heightAnchor.constraint(equalToConstant: 0.5),
            stroke.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 5),
            stroke.leftAnchor.constraint(equalTo: stack.leftAnchor, constant: 10),
            stroke.rightAnchor.constraint(equalTo: stack.rightAnchor, constant: -10),
            stroke.bottomAnchor.constraint(equalTo: infoView.topAnchor, constant: -5),
            stroke.centerXAnchor.constraint(equalTo: stack.centerXAnchor),
            //
            infoView.topAnchor.constraint(equalTo: stroke.bottomAnchor, constant: 5),
            infoView.leftAnchor.constraint(equalTo: stack.leftAnchor),
            infoView.rightAnchor.constraint(equalTo: stack.rightAnchor),
            //infoView.bottomAnchor.constraint(equalTo: stack.bottomAnchor, constant: -10),
            //
            stack2.topAnchor.constraint(equalTo: infoView.topAnchor),
            stack2.leftAnchor.constraint(equalTo: infoView.leftAnchor),
            stack2.rightAnchor.constraint(equalTo: infoView.rightAnchor),
            //
            lbl1.topAnchor.constraint(equalTo: stack2.topAnchor, constant: 5),
            lbl1.leftAnchor.constraint(equalTo: stack2.leftAnchor, constant: 10),
            
            lbl2.topAnchor.constraint(equalTo: stack2.topAnchor, constant: 5),
            lbl2.rightAnchor.constraint(equalTo: stack2.rightAnchor, constant: -10),
            
            stack3.topAnchor.constraint(equalTo: stack2.bottomAnchor),
            stack3.leftAnchor.constraint(equalTo: infoView.leftAnchor),
            stack3.rightAnchor.constraint(equalTo: infoView.rightAnchor),
            
            lbl3.topAnchor.constraint(equalTo: stack3.topAnchor, constant: 5),
            lbl3.leftAnchor.constraint(equalTo: stack3.leftAnchor, constant: 10),
            
            lbl4.topAnchor.constraint(equalTo: stack3.topAnchor, constant: 5),
            lbl4.leftAnchor.constraint(equalTo: lbl3.rightAnchor, constant: 5),
            lbl4.rightAnchor.constraint(equalTo: stack3.rightAnchor, constant: -10),
            //
            stroke2.heightAnchor.constraint(equalToConstant: 0.5),
            stroke2.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 5),
            stroke2.leftAnchor.constraint(equalTo: stack.leftAnchor, constant: 10),
            stroke2.rightAnchor.constraint(equalTo: stack.rightAnchor, constant: -10),
            stroke2.centerXAnchor.constraint(equalTo: stack.centerXAnchor),
            
            adresView.topAnchor.constraint(equalTo: stroke2.bottomAnchor, constant: 5),
            adresView.leftAnchor.constraint(equalTo: stack.leftAnchor, constant: 5),
            adresView.rightAnchor.constraint(equalTo: stack.rightAnchor),
            
            lbl5.topAnchor.constraint(equalTo: adresView.topAnchor, constant: 5),
            lbl5.leftAnchor.constraint(equalTo: adresView.leftAnchor, constant: 5),
            lbl6.topAnchor.constraint(equalTo: lbl5.bottomAnchor, constant: 5),
            lbl6.leftAnchor.constraint(equalTo: adresView.leftAnchor, constant: 5),
            
        ])
        
        return stack
    }
    
    func setupNotificationView() -> UIStackView{
        let stack = UIStackView()
        stack.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layer.borderWidth = 0.2
        stack.layer.borderColor = UIColor.gray.cgColor
        
        stack.layer.shadowColor = UIColor.black.cgColor
        stack.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        stack.layer.shadowOpacity = 0.2
        stack.layer.shadowRadius = 2.0
        stack.backgroundColor = .white
        stack.spacing = 10
        // Установить положение компонентов внутри Stack
        stack.axis = .horizontal
        
        let lbl1 = UILabel()
        lbl1.text = "Get push notification"
        lbl1.textAlignment = .left
        lbl1.font = UIFont.systemFont(ofSize: 15)
        lbl1.translatesAutoresizingMaskIntoConstraints = false
        
        let switchDemo = UISwitch(frame: CGRect(x: view.center.x - 50, y: view.center.y - 50, width: 100, height: 100))
        switchDemo.addTarget(self, action: #selector(switchStateDidChange(_:)), for: .valueChanged)
        switchDemo.setOn(true, animated: false)
        
        
        stack.addArrangedSubview(lbl1)
        stack.addArrangedSubview(switchDemo)
        
        return stack
    }
    
    // MARK: - Action
    
    @objc func switchStateDidChange(_ sender: UISwitch!) {
        if sender.isOn {
            print("UISwitch state is now ON")
        } else {
            print("UISwitch state is now Off")
        }
    }
    
    @objc func logOut() {
        print("By!")
        // coordinator?.navigationController.popViewController(animated: true)
        //coordinator?.showProfilePage()
    }
    
    @objc func buttonTapped() {
        print("Кнопка была нажата")
        // Ваш код обработки нажатия на кнопку
    }
}


//let backButton = UIButton(type: .system)
//                backButton.setTitle("Go back", for: .normal)
//                backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
//
//                view.addSubview(backButton)
//
//                backButton.translatesAutoresizingMaskIntoConstraints = false
//                NSLayoutConstraint.activate([
//                    backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//                    backButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//                ])

// Do any additional setup after loading the view.
