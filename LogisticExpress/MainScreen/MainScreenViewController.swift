import UIKit

class MainScreenViewController: SGStackViewController {
    
    weak var coordinator: MainScreenCoordinator?
    let name = String("Андрій Петрович")
    lazy var headerView: SGMainPageHeader = {
        return SGMainPageHeader(name: "Привіт \(name)")
    }()
    var numberOfOrders = Int.random(in: 2...5)
    lazy var dateView: SGNewOrderInfo = {
        return SGNewOrderInfo(dateString: "Сьогодні \(updateDateTime())", newOrderString: "\(numberOfOrders)")
    }()
    
    lazy var infoView: SGInfoView = SGInfoView()
    var notificationView: NotificationView = NotificationView(dateString: "", newOrderString: "")
    //--------------
    let costMatrix = [
        [3, 2, 7],
        [2, 4, 5],
        [5, 1, 2]
    ]
    
    let supply = [100, 150, 200]
    let demand = [120, 80, 170]
    //---------------
    let buttonHeight: CGFloat = 52
    lazy var titleOrderView: SGTitleOrderView = SGTitleOrderView()
    var orderTableView: SGOrderTableView = SGOrderTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSubviews()
        let result = simplexMethod(costMatrix: costMatrix, supply: supply, demand: demand)
        print(result)
    }
    
    // MARK: CGConstruction funcs
    override func addContent() {
        super.addContent()
        stackView.addArrangedSubview(headerView)
        stackView.addArrangedSubview(infoView)
        stackView.addArrangedSubview(dateView, withSpacing: 10)
        stackView.addArrangedSubview(titleOrderView, withSpacing: 10)
        stackView.addArrangedSubview(orderTableView, withSpacing: 10)
        self.view.addSubview(notificationView)
    }
    
    override func configureContent() {
        super.configureContent()
        
        navigationController?.navigationBar.tintColor = .black
        //self.navigationController?.hidesBarsOnTap = true
        //self.navigationController?.hidesBarsOnSwipe = true
        
        let counterButton = UIBarButtonItem(customView: notificationBarButton)
        let barButtons:[UIBarButtonItem] = [counterButton]
        self.navigationItem.rightBarButtonItems = barButtons
        
        titleOrderView.reloadDataButton.addTarget(self, action: #selector(reloadData), for: .touchUpInside)
        
        orderTableView.orderButton.addTarget(self, action: #selector(tapGenerateOrderButton), for: .touchUpInside)
        
        notificationView.translatesAutoresizingMaskIntoConstraints = false
        notificationView.isHidden = true
        
        notificationView.closeButton.addTarget(self, action: #selector(closeNotificationView), for: .touchUpInside)
        orderTableView.orderDelegate = self
        orderTableView.numberOfCells = numberOfOrders
        
        orderTableView.navigationController = self.navigationController
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
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            dateView.heightAnchor.constraint(equalToConstant: 75),
            headerView.heightAnchor.constraint(equalToConstant: 100),
            titleOrderView.heightAnchor.constraint(equalToConstant: 40),
            orderTableView.heightAnchor.constraint(equalToConstant: 700),
            
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
        print("Побудувати маршрут натиснута")
    }
    
    @objc func buttonTapped() {
        coordinator?.showOrderDetailsPage()
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
}
