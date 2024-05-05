//
//  RouteMapScreenViewController.swift
//  LogisticExpress
//
//  Created by Дмитрий Соломаха on 13.04.2024.
//

import UIKit
import MapKit
import CoreLocation

class RouteMapScreenViewController: SGStackViewController {
    
    weak var coordinator: RouteMapScreenCoordinator?
  
    var childCoordinators: [Coordinator] = []
    
    var ordersInfoHandler: (([OrderInfo]) -> Void)?
    
    var map: SGMap = SGMap()
    let mapHeight: CGFloat = 550
    let qrHeight: CGFloat = 300
    
    // Заданные значения:
    let fuelConsumption: Double = 11.4 // Расход топлива (л/100 км)
    let fuelCost: Double = 54.74 // Стоимость топлива (грн/л)
    let loadCapacity: Double = 2197 // Грузоподъемность (кг)
    let maintenanceCost: Double = 10000 // Месячные расходы на техобслуживание (грн)
    let refrigerationCost: Double = 1500 // Месячные расходы на холодильное оборудование (грн)
    
    var ordersInfo: [OrderInfo] = []
    
    // Добавляем переменные randomNumber1 и randomNumber2
    var randomNumber1: Int = 0
    var randomNumber2: Int = 0
    
    // Створення матриці вартості транспортування
    var costMatrix: [[Double]] = []
    var supply:[Double] = []  // Доступное количество товара на складах 1 и 2 соответственно
    var demand:[Double] = []  // Потребность в товаре у магазинов 1, 2 и 3 соответственно
    
    let solver = TransportationSolver()
    
    let senderCompanyName = "ТОВ Агро-Нова"
    var currentDate = ""
    var orderWeight:Int = 0
    
    var receivedCoordinates: [(Double, Double)] = [] {
        didSet {
            printCoordinates()
            updateMapAnnotations()
        }
    }
    
    func printCoordinates() {
        for coordinate in receivedCoordinates {
            print(coordinate)
        }
    }
    
    func updateMapAnnotations() {
        map.removeAnnotations(map.annotations) // Удаляем старые аннотации
        for coordinates in receivedCoordinates {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: coordinates.0, longitude: coordinates.1)
            map.addAnnotation(annotation)
        }
        for stock in stockDataArr {
            if let title = stock["Склад"] as? String,
               let coordinates = stock["координати"] as? (Double, Double) {
                let annotation = MKPointAnnotation()
                annotation.title = title
                annotation.coordinate = CLLocationCoordinate2D(latitude: coordinates.0, longitude: coordinates.1)
                map.addAnnotation(annotation)
            }
        }
        if !receivedCoordinates.isEmpty {
            let mapRegion = region(for: receivedCoordinates)
            map.setRegion(mapRegion, animated: true)
        }
    }
    
    private func region(for coordinates: [(Double, Double)]) -> MKCoordinateRegion {
        let latitudes = coordinates.map { $0.0 }
        let longitudes = coordinates.map { $0.1 }
        
        let maxLat = latitudes.max() ?? 0
        let minLat = latitudes.min() ?? 0
        let maxLong = longitudes.max() ?? 0
        let minLong = longitudes.min() ?? 0
        
        let center = CLLocationCoordinate2D(latitude: (maxLat + minLat) / 2, longitude: (maxLong + minLong) / 2)
        let span = MKCoordinateSpan(latitudeDelta: max(0.01, (maxLat - minLat) * 1.1), longitudeDelta: max(0.01, (maxLong - minLong) * 1.1))
        
        return MKCoordinateRegion(center: center, span: span)
    }
    
    var receivedData: [OrderModel] = []
    
    // Функция для создания матрицы расстояний
    func createDistanceMatrix() -> [[Double]] {
        var distanceMatrix: [[Double]] = []
        
        for stock in stockDataArr {
            var warehouseDistances: [Double] = []
            if let warehouseCoordinates = stock["координати"] as? (Double, Double) {
                let warehouseLocation = CLLocation(latitude: warehouseCoordinates.0, longitude: warehouseCoordinates.1)
                
                for storeCoordinates in receivedCoordinates {
                    let storeLocation = CLLocation(latitude: storeCoordinates.0, longitude: storeCoordinates.1)
                    // Расстояние в метрах
                    let distanceInMeters = warehouseLocation.distance(from: storeLocation)
                    // Преобразуем расстояние в километры
                    let distanceInKilometers = distanceInMeters / 1000
                    warehouseDistances.append(distanceInKilometers)
                }
            }
            distanceMatrix.append(warehouseDistances)
        }
        
        return distanceMatrix
    }
    
    func calculateTransportationCostPerUnitPerKilometer() -> Double {
        // Расходы на топливо на 100 км:
        let fuelExpensesPer100km = fuelConsumption * fuelCost
        
        // Расходы на техобслуживание за 1 км:
        let maintenanceCostPerKilometer = maintenanceCost / (loadCapacity * 1000) // 1000 км в 1 т
        
        // Расходы на холодильное оборудование за 1 км:
        let refrigerationCostPerKilometer = refrigerationCost / (loadCapacity * 1000)
        
        // Общие расходы на 1 км:
        let totalCostPerKilometer = fuelExpensesPer100km / 100 + maintenanceCostPerKilometer + refrigerationCostPerKilometer
        
        // Расходы на 1 единицу товара на 1 км:
        let costPerUnitPerKilometer = totalCostPerKilometer
        
        return costPerUnitPerKilometer
    }
    
    let orderButton : UIButton = {
        let button = UIButton(type: .system)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Відгрузити вантаж", for: .normal)
        button.backgroundColor = .orange
        
        // Set button properties
        button.tintColor = .white
        button.layer.cornerRadius = 25
        
        // Add shadow to the button
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.06).cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 8
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSubviews()
    }
    
    // MARK: CGConstruction funcs
    override func addContent() {
        super.addContent()
        stackView.addArrangedSubview(map)
    }
    
    override func configureContent() {
        super.configureContent()
        stackView.spacing = 10
        // Set button properties
        map.layer.cornerRadius = 10
        map.backgroundColor = .lightGray
        
        // Add shadow to the button
        map.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.35).cgColor
        map.layer.shadowOpacity = 1
        map.layer.shadowRadius = 5
        map.layer.shadowOffset = CGSize(width: 2, height: 2)
        
        map.heightAnchor.constraint(equalToConstant: mapHeight).isActive = true
        
        // Добавляем значения randomNumber1 и randomNumber2 в массив supply
        supply.append(Double(randomNumber1))
        supply.append(Double(randomNumber2))
        print("\(supply)")
        
        orderButton.addTarget(self, action: #selector(clearTable), for: [.touchUpInside])
        
        // Проверяем, есть ли данные в receivedData
        if receivedData.isEmpty {
            print("No data received")
        } else {
            for order in receivedData {
                if order.totalWeight >= 0 {
                    demand.append(Double(order.totalWeight))
                } else {
                    print("Warning: Invalid total weight for order. Skipping.")
                }
                
                currentDate = order.orderDate
                orderWeight = order.totalWeight
                
                
            }
        }
        
        print("\(demand)")
        
        // Создаем экземпляр OrderInfo и добавляем его в массив
        let orderInfo = OrderInfo(creationDate: "\(currentDate)", orderWeight: Double(orderWeight), senderCompanyName: senderCompanyName)
        ordersInfo.append(orderInfo)
        print("ordersInfo \(ordersInfo)")
        ordersInfoHandler?(ordersInfo)
        
        let distanceMatrix = createDistanceMatrix()
        print("distanceMatrix = \(distanceMatrix)")
        
        // Пример использования:
        let costPerUnitPerKilometer = calculateTransportationCostPerUnitPerKilometer()
        
        print("Вартість транспортування однієї одиниці товару на 1 км: \(costPerUnitPerKilometer) грн")
        
        for warehouseDistances in distanceMatrix {
            let warehouseCosts = warehouseDistances.map { distance in
                let costForDistance = Double(distance) * Double(costPerUnitPerKilometer)
                return Double(String(format: "%.2f", costForDistance))!
            }
            costMatrix.append(warehouseCosts)
        }
        
        // Виведення матриці вартості транспортування
        for row in costMatrix {
            print(row.map { String(format: "%.2f", $0) }.joined(separator: ", "))
        }
        
        // Анализируем транспортную задачу
        if let (solution, totalCost) = solver.analyzeTransportationProblem(supply: supply, demand: demand, costs: costMatrix) {
            for i in 0..<supply.count {
                var hasShipments = false // Флаг, указывающий, есть ли отправки из текущего склада
                let from = "Зі складу №\(i + 1)"
                
                for j in 0..<demand.count {
                    let quantity = solution[i][j]
                    
                    // Проверяем, что есть отправки из текущего склада
                    if quantity > 0 {
                        hasShipments = true
                        break
                    }
                }
                
                // Создаем вертикальное стековое представление для текущего склада, только если есть отправки из него
                if hasShipments {
                    let verticalStackView = UIStackView()
                    verticalStackView.axis = .vertical
                    verticalStackView.spacing = 10
                    verticalStackView.layer.borderWidth = 0.2
                    verticalStackView.layer.borderColor = UIColor.gray.cgColor
                    verticalStackView.layer.cornerRadius = 10
                    
                    verticalStackView.layer.shadowColor = UIColor.black.cgColor
                    verticalStackView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
                    //verticalStackView.layer.shadowOpacity = 0.2
                    verticalStackView.layer.shadowRadius = 2.0
                    
                    let fromLabel = UILabel()
                    fromLabel.text = from
                    fromLabel.textAlignment = .left
                    verticalStackView.addArrangedSubview(fromLabel)
                    
                    for (j, order) in receivedData.enumerated() {
                        let to = "\(order.storeName)"
                        let quantity = solution[i][j]
                        
                        // Проверяем, что количество товара больше 0
                        guard quantity > 0 else {
                            continue
                        }
                        
                        // Создаем горизонтальное стековое представление для кружочка и лейбла с названием магазина
                        let horizontalStackView = UIStackView()
                        horizontalStackView.axis = .horizontal
                        horizontalStackView.spacing = 10
                        
                        // Создаем и добавляем кружочек
                        let circleLabel = UILabel()
                        circleLabel.text = "●"
                        circleLabel.textColor = .systemOrange
                        circleLabel.widthAnchor.constraint(equalToConstant: 20).isActive = true // Задаем ширину для кружочка
                        circleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true // Задаем высоту для кружочка
                        
                        horizontalStackView.addArrangedSubview(circleLabel)
                        
                        // Создаем и добавляем лейбл с названием магазина
                        let transportLabel = UILabel()
                        transportLabel.text = "\(to)"
                        transportLabel.textAlignment = .left
                        horizontalStackView.addArrangedSubview(transportLabel)
                        
                        // Создаем вертикальное стековое представление для лейбла с количеством товара
                        let quantityStackView = UIStackView()
                        quantityStackView.axis = .horizontal
                        quantityStackView.spacing = 5
                        
                        let quantityLineView = UIView()
                        quantityLineView.backgroundColor = .systemOrange
                        quantityLineView.widthAnchor.constraint(equalToConstant: 3).isActive = true
                        quantityLineView.heightAnchor.constraint(equalToConstant: 30).isActive = true
                        
                        // Создаем и добавляем лейбл с количеством товара
                        let quantityLabel = UILabel()
                        quantityLabel.text = "Вага: \(quantity)"
                        quantityLabel.textAlignment = .left
                        
                        quantityStackView.addArrangedSubview(quantityLineView)
                        quantityStackView.addArrangedSubview(quantityLabel)
                        
                        let lineView = UIView()
                        lineView.backgroundColor = .systemOrange
                        lineView.widthAnchor.constraint(equalToConstant: 3).isActive = true
                        lineView.heightAnchor.constraint(equalToConstant: 30).isActive = true
                        
                        let lineStackView = UIStackView()
                        lineStackView.axis = .horizontal
                        lineStackView.spacing = 10
                        
                        let lineLabel = UILabel()
                        lineLabel.text = ""
                        lineLabel.textAlignment = .left
                        
                        
                        lineStackView.addArrangedSubview(lineView)
                        lineStackView.addArrangedSubview(lineLabel)
                        
                        // Добавляем горизонтальное стековое представление в вертикальное
                        verticalStackView.addArrangedSubview(horizontalStackView)
                        
                        // Добавляем вертикальное стековое представление в горизонтальное
                        verticalStackView.addArrangedSubview(quantityStackView)
                        verticalStackView.addArrangedSubview(lineStackView)
                        
                        NSLayoutConstraint.activate([
                            lineView.leftAnchor.constraint(equalTo: lineStackView.leftAnchor, constant: 5),
                            quantityLineView.leftAnchor.constraint(equalTo: quantityStackView.leftAnchor, constant: 5),
                            quantityLabel.leftAnchor.constraint(equalTo: quantityLineView.rightAnchor, constant: 20),
                            fromLabel.topAnchor.constraint(equalTo: verticalStackView.topAnchor, constant: 5),
                            fromLabel.leftAnchor.constraint(equalTo: verticalStackView.leftAnchor, constant: 10)
                            
                        ])
                        
                        
                    }
                    
                    // Добавляем вертикальное стековое представление в основное стековое представление
                    stackView.addArrangedSubview(verticalStackView)
                    
                }
                
            }
            
            // Вывод общей стоимости перевозок
            let formattedTotalCost = String(format: "%.2f", totalCost)
            let totalCostLabel = UILabel()
            totalCostLabel.text = "Загальна вартість перевезень: \(formattedTotalCost) грн."
            stackView.addArrangedSubview(totalCostLabel)
        } else {
            print("Невозможно решить транспортную задачу.")
        }
        stackView.addArrangedSubview(orderButton)
    }
    
    //    func showRouteOnMap() {
    //        for (from, to) in { // Замените это на ваш массив данных маршрута
    //                let sourcePlacemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: from.latitude, longitude: from.longitude))
    //                let destinationPlacemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: to.latitude, longitude: to.longitude))
    //
    //                let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
    //                let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
    //
    //                let directionRequest = MKDirections.Request()
    //                directionRequest.source = sourceMapItem
    //                directionRequest.destination = destinationMapItem
    //                directionRequest.transportType = .automobile // Можно изменить тип транспорта
    //
    //                let directions = MKDirections(request: directionRequest)
    //                directions.calculate { (response, error) in
    //                    guard let response = response else {
    //                        if let error = error {
    //                            print("Error: \(error)")
    //                        }
    //                        return
    //                    }
    //
    //                    let route = response.routes[0]
    //                    self.map.addOverlay(route.polyline, level: .aboveRoads)
    //
    //                    let rect = route.polyline.boundingMapRect
    //                    self.map.setRegion(MKCoordinateRegion(rect), animated: true)
    //                }
    //            }
    //        }
    
    // Ваш остальной код
    
    // Функция отображения маршрута на карте
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 5.0
        return renderer
    }
    
    override func styleContent() {
        super.styleContent()
        self.navigationItem.title = "Маршрутний лист"
        view.backgroundColor = .white
        
    }
    
    @objc func clearTable() {
        print("clear table")
        let mainScreen = MainScreenViewController()
        mainScreen.orderTableView.clearData()
        showMainPage()
      
    }
    
    func showMainPage() {
        let mainScreenCoordinator = MainScreenCoordinator(navigationController: navigationController ?? UINavigationController())
        
        
        ordersInfoHandler?(ordersInfo)
        
        childCoordinators.append(mainScreenCoordinator)
        mainScreenCoordinator.start()
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
