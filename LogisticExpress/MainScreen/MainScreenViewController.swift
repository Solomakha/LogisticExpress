import UIKit

class MainScreenViewController: SGStackViewController {
    
    weak var coordinator: MainScreenCoordinator?
    
    let randomNumber1 = Int.random(in: 500...2000) // Генерация случайного числа от 1 до 100
    let randomNumber2 = Int.random(in: 500...1000) // Генерация случайного числа от 1 до 100
    
    let name = String("Андрій Петрович")
    
    lazy var headerView: SGMainPageHeader = {
        return SGMainPageHeader(name: "Привіт \(name)")
    }()
    
    var numberOfOrders = Int.random(in: 2...5)
    
    lazy var dateView: SGNewOrderInfo = {
        return SGNewOrderInfo(dateString: "Сьогодні \(updateDateTime())", newOrderString: "\(numberOfOrders)")
    }()
    
    var sumWeight: Int = 0
    
    lazy var infoView: SGInfoView = SGInfoView(storageNumber: "Складів 2", truckNumber: "Вільних 2/5", weightNumber: "340")
    
    var notificationView: NotificationView = NotificationView(dateString: "", newOrderString: "")
    
    let buttonHeight: CGFloat = 52
    
    lazy var titleOrderView: SGTitleOrderView = SGTitleOrderView()
    
    var orderTableView: SGOrderTableView = SGOrderTableView()
    
    var orders: [OrderModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        loadSubviews()
    }
    
    // MARK: CGConstruction funcs
    override func addContent() {
        super.addContent()
        stackView.addArrangedSubview(headerView)
        stackView.addArrangedSubview(infoView)
        stackView.addArrangedSubview(dateView, withSpacing: 10)
        stackView.addArrangedSubview(titleOrderView, withSpacing: 10)
        self.view.addSubview(orderTableView)
        self.view.addSubview(notificationView)
    }
    
    override func configureContent() {
        super.configureContent()
        
        navigationController?.navigationBar.tintColor = .black
        
        let counterButton = UIBarButtonItem(customView: notificationBarButton)
        let barButtons:[UIBarButtonItem] = [counterButton]
        self.navigationItem.rightBarButtonItems = barButtons
        
        titleOrderView.reloadDataButton.addTarget(self, action: #selector(reloadData), for: .touchUpInside)
        
        notificationView.translatesAutoresizingMaskIntoConstraints = false
        notificationView.isHidden = true
        notificationView.closeButton.addTarget(self, action: #selector(closeNotificationView), for: .touchUpInside)
        
        orderTableView.translatesAutoresizingMaskIntoConstraints = false
        orderTableView.orderDelegate = self
        orderTableView.numberOfCells = numberOfOrders
        orderTableView.navigationController = self.navigationController
        orderTableView.orderButton.addTarget(self, action: #selector(tapGenerateOrderButton), for: .touchUpInside)
        sumWeight = randomNumber1+randomNumber2
        
        // Обновление infoView с новым значением sumWeight
        let newInfoView = SGInfoView(storageNumber: "Складів 2", truckNumber: "Вільних 1/3", weightNumber: "\(sumWeight) кг.")
        stackView.insertArrangedSubview(newInfoView, at: 1) // Предполагая, что индекс 1 соответствует индексу infoView
        infoView.removeFromSuperview()
        infoView = newInfoView
        
        infoView.truckImageView.isUserInteractionEnabled = true
        // Добавьте жест нажатия к imageView
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        infoView.truckImageView.addGestureRecognizer(tapGesture)

    }
    
    override func styleContent() {
        super.styleContent()
        view.backgroundColor = .white
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            
            dateView.heightAnchor.constraint(equalToConstant: 75),
            headerView.heightAnchor.constraint(equalToConstant: 100),
            titleOrderView.heightAnchor.constraint(equalToConstant: 40),
            
            orderTableView.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            orderTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12),
            orderTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12),
            orderTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            notificationView.heightAnchor.constraint(equalToConstant: 500),
            
            notificationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            notificationView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 12),
            notificationView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -12),
        ])
    }
    
    lazy var notificationBarButton: UIButton = {
        let notificationBarButton = UIButton(type: .custom)
        notificationBarButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        notificationBarButton.backgroundColor = UIColor.white
        notificationBarButton.setTitleColor(  UIColor.white, for: .normal)
        notificationBarButton.contentHorizontalAlignment = .center
        //notificationBarButton.layer.cornerRadius = notificationBarButton.bounds.size.width / 2
        notificationBarButton.clipsToBounds = true
        notificationBarButton.addTarget(self, action: #selector(showNotificationView), for: [.touchUpInside])
        notificationBarButton.setImage(UIImage(named: "notification"), for: .normal)
        notificationBarButton.layer.borderWidth = 0.2
        notificationBarButton.layer.borderColor = UIColor.black.cgColor
        notificationBarButton.layer.cornerRadius = 12
        
        return notificationBarButton
    }()
    
    @objc func tapGenerateOrderButton() {
        print("Побудувати маршрут - натиснута")
        // Передаем randomNumber1 и randomNumber2 в RouteMapScreenViewController
        if let mapScreenVC = navigationController?.viewControllers.first(where: { $0 is RouteMapScreenViewController }) as? RouteMapScreenViewController {
            mapScreenVC.randomNumber1 = randomNumber1
            mapScreenVC.randomNumber2 = randomNumber2
        }
    }
    
    @objc func buttonTapped() {
        coordinator?.showOrderDetailsPage()
    }
    
    @objc func imageTapped() {
        // Создайте экземпляр другого ViewController
        let truckVC = TruckViewController()
        
        // Выполните переход на другой ViewController
        self.navigationController?.pushViewController(truckVC, animated: true)
    }
    
    // Функция для обновления времени и даты
    public func updateDateTime() -> String{
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        
        // Установка формата вывода даты и времени
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        // Получение строки с текущей датой и временем
        let formattedDate = dateFormatter.string(from: currentDate)
        
        //print("Текущая дата и время: \(formattedDate)")
        return formattedDate
    }
    
    @objc func reloadData() {
        orderTableView.reloadData()
    }
    
    @objc func showNotificationView() {
        notificationView.isHidden = false
    }
    
    @objc func closeNotificationView() {
        notificationView.isHidden = true
    }
    
    static func generateOrders() -> (ShopData, [Product]) {
        // Создаем экземпляр класса OrderGenerator
        let orderGenerator = OrderGenerator()
        
        // Получаем случайный магазин и его координаты
        let (shopData, _) = orderGenerator.getRandomShop()
        
        // Генерируем случайное количество продуктов в каждом заказе
        let numberOfProducts = Int.random(in: 1...10)
        
        // Генерируем продукты в каждом заказе
        var products: [Product] = []
        for _ in 0..<numberOfProducts {
            let randomIndex = Int.random(in: 0..<vegetables.count)
            let productName = vegetables[randomIndex] // Предполагается, что у вас есть массив vegetables
            let quantity = Int.random(in: 10...100)
            let pricePerKg = Double.random(in: 10...100).rounded(toPlaces: 2)
            
            // Создаем экземпляр продукта и добавляем его в заказ
            let product = Product(name: productName, quantity: quantity, pricePerKg: pricePerKg)
            products.append(product)
        }
        
        return (shopData, products)
    }
    
}

extension MainScreenViewController: SGOrderTableViewDelegate {
    
    func didSelectOrder(at indexPath: IndexPath, withData data: OrderModel) {
        let orderDetailsVC = OrderDetailsViewController()
        // Создаем массив данных и добавляем в него выбранный заказ
        let dataArray: [OrderModel] = [data]
        orderDetailsVC.receivedData = dataArray
        navigationController?.pushViewController(orderDetailsVC, animated: true)
    }
    
    func receivedCoordinates(_ coordinates: [(Double, Double)]) {
        // Предполагаем, что mapScreenVC уже существует и отображается на экране.
        if let mapScreenVC = navigationController?.viewControllers.first(where: { $0 is RouteMapScreenViewController }) as? RouteMapScreenViewController {
            mapScreenVC.receivedCoordinates = coordinates
        } else {
            // Если mapScreenVC еще не существует, создаем его и передаем координаты.
            let mapScreenVC = RouteMapScreenViewController()
            mapScreenVC.receivedCoordinates = coordinates
            navigationController?.pushViewController(mapScreenVC, animated: true)
        }
    }
    
    func receivedData(_ data: [OrderModel]) {
        // Проверяем, отображается ли уже RouteMapScreenViewController
        if let mapScreenVC = navigationController?.viewControllers.first(where: { $0 is RouteMapScreenViewController }) as? RouteMapScreenViewController {
            // Обновляем данные о заказах в существующем экземпляре RouteMapScreenViewController
            mapScreenVC.receivedData = data
            
        } else {
            // Если RouteMapScreenViewController еще не существует, создаем его и передаем данные о заказах.
            let mapScreenVC = RouteMapScreenViewController()
            mapScreenVC.receivedData = data
            navigationController?.pushViewController(mapScreenVC, animated: true)
        }
    }
    // Реализация метода делегата
        func didUpdateNumberOfOrders(_ numberOfOrders: Int) {
            // Обновите значение в dateView или в любом другом месте, где это необходимо
            dateView.updateNumberOfOrders(numberOfOrders)
        }
}
