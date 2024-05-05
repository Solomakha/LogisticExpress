//
//  OrderDetailsViewController.swift
//  LogisticExpress
//
//  Created by Дмитрий Соломаха on 16.04.2024.
//

import UIKit
import MapKit

class OrderDetailsViewController: SGStackViewController, MKMapViewDelegate {
    
    weak var coordinator: OrderDetailsScreenCoordinator?
    
    var map: SGMap = SGMap()
    let mapHeight: CGFloat = 350
    
    var receivedData: [OrderModel] = []
    
    var orderNumber: String = ""
    var orderDate: String = ""
    var deliveryAddress: String = ""
    var storeName: String = ""
    var totalWeight: Int = 0
    var orderDetail: String = ""
    var shopCoordinates: (Double, Double) = (0, 0)
    
    var orderNumberLabel = UILabel()
    var orderDateLabel = UILabel()
    var deliveryAddressLabel = UILabel()
    var storeNameLabel = UILabel()
    var totalWeightLabel = UILabel()
    
    // Создаем изображение для кнопки
    let buttonImage = UIImage(named: "copy")
    
    // Создаем кнопку и устанавливаем изображение
    let reloadDataButton = UIButton(type: .custom)
    // Устанавливаем размер кнопки
    let buttonSize = CGSize(width: 25, height: 25)
    
    // Создаем координаты места, где должен быть маркер
    var latitude: CLLocationDegrees = 0.0
    var longitude: CLLocationDegrees = 0.0
    
    // Создаем маркер с координатами и заголовком
    let annotation = MKPointAnnotation()
    
    var senderView: SenderInfoView = SenderInfoView()
    var destinationView: DestinationView = DestinationView()
    var detailOrderView: DetailOrderView = DetailOrderView()
    var bottomButtonView: OSButtonView = OSButtonView()
    
    var bottomSheetView: BottomSheetUIView = BottomSheetUIView()
    
    let phoneNumber = "123456789"
    var phoneNumbers: [String] = []
    
    // Генерация случайного индекса от 0 до количества элементов в кортеже
    let randomIndex = Int.random(in: 0..<namesAndSurnames.count)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSubviews()
    }
    
    // MARK: CGConstruction funcs
    override func addContent() {
        super.addContent()
        stackView.addArrangedSubview(orderNumberView)
        stackView.addArrangedSubview(map, withSpacing: 10)
        stackView.addArrangedSubview(senderView, withSpacing: 10)
        stackView.addArrangedSubview(destinationView, withSpacing: 10)
        stackView.addArrangedSubview(detailOrderView, withSpacing: 10)
        stackView.addArrangedSubview(bottomButtonView, withSpacing: 10)
        self.view.addSubview(bottomSheetView)
    }

    // Функция для форматирования текста с информацией о продуктах
    func formatProductsText(from products: [Product]) -> String {
        var productsText = ""
        for product in products {
            productsText += "Найменування: \(product.name)\n"
            productsText += "Кількість: \(product.quantity) кг.\n"
            productsText += "Ціна: \(product.pricePerKg) грн. за кг.\n"
            productsText += "\n"
        }
        return productsText
    }
    
    override func configureContent() {
        super.configureContent()
        map.delegate = self
        map.translatesAutoresizingMaskIntoConstraints = false
        map.layer.cornerRadius = 15
        map.backgroundColor = .lightGray
        map.layer.borderWidth = 0.2
        map.layer.borderColor = UIColor.gray.cgColor
        map.layer.shadowColor = UIColor.black.cgColor
        map.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        map.layer.shadowOpacity = 0.2
        map.layer.shadowRadius = 2.0
        map.heightAnchor.constraint(equalToConstant: mapHeight).isActive = true
        
        // Проверяем, есть ли данные в receivedData
        if receivedData.isEmpty {
            print("No data received")
        } else {
            // Если массив не пустой, перебираем его элементы
            for order in receivedData {
                orderNumber = order.orderNumber
                orderDate = order.orderDate
                deliveryAddress = order.deliveryAddress
                storeName = order.storeName
                orderDetail = order.productsText
                
                latitude = order.shopCoordinates.0
                longitude = order.shopCoordinates.1

                detailOrderView.updateTextViewWithProducts(orderDetail)
                annotation.title = order.storeName
            }
        }
        
        let image = generateQRCode(from: orderNumber)
        bottomSheetView.mkImagew.image = image
        
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        annotation.coordinate = location
        map.addAnnotation(annotation)
        
        // Устанавливаем область показа карты с увеличением
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)
        
        senderView.translatesAutoresizingMaskIntoConstraints = false
        destinationView.translatesAutoresizingMaskIntoConstraints = false
        bottomButtonView.translatesAutoresizingMaskIntoConstraints = false
        
        orderNumberLabel.text = "Замовлення №\(orderNumber)"
        orderNumberLabel.textAlignment = .left
        orderNumberLabel.textColor = .black
        orderNumberLabel.font = UIFont.boldSystemFont(ofSize: 20)
        orderNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        orderNumberLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        orderDateLabel.text = orderDate
        orderDateLabel.textAlignment = .left
        orderDateLabel.textColor = .black
        orderDateLabel.font = UIFont.systemFont(ofSize: 15)
        orderDateLabel.translatesAutoresizingMaskIntoConstraints = false
        orderDateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        deliveryAddressLabel.text = deliveryAddress
        deliveryAddressLabel.textAlignment = .left
        deliveryAddressLabel.textColor = .black
        deliveryAddressLabel.font = UIFont.systemFont(ofSize: 15)
        deliveryAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        deliveryAddressLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        destinationView.lbl8.text = deliveryAddress
        
        storeNameLabel.text = storeName
        storeNameLabel.textAlignment = .center
        storeNameLabel.textColor = .black
        storeNameLabel.font = UIFont.systemFont(ofSize: 15)
        storeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        storeNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        destinationView.lbl2.text = "\(storeNameLabel.text ?? "NO NAME")"
        
        totalWeightLabel.text = String(totalWeight)
        totalWeightLabel.textAlignment = .center
        totalWeightLabel.textColor = .black
        totalWeightLabel.font = UIFont.systemFont(ofSize: 15)
        totalWeightLabel.translatesAutoresizingMaskIntoConstraints = false
        totalWeightLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        orderNumberView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        reloadDataButton.setImage(buttonImage, for: .normal)
        
        bottomSheetView.translatesAutoresizingMaskIntoConstraints = false
        bottomSheetView.isHidden = true
        
        bottomSheetView.closeButton.addTarget(self, action: #selector(closeNotificationView), for: .touchUpInside)
        
        bottomButtonView.smallerButton.addTarget(self, action: #selector(showNotificationView), for: .touchUpInside)
        bottomButtonView.biggerButton.addTarget(self, action: #selector(callButtonTapped), for: .touchUpInside)
        
        // Получение случайного элемента из кортежа по сгенерированному индексу
        let randomNameAndSurname = namesAndSurnames[randomIndex]
        destinationView.lbl4.text = "\(randomNameAndSurname.0) \(randomNameAndSurname.1)"
        
        for _ in 1...50 {
            var phoneNumber = "+38"
            
            // Выбор случайного кода оператора
            let randomOperatorIndex = Int.random(in: 0..<operatorCodes.count)
            phoneNumber += operatorCodes[randomOperatorIndex]
            
            // Генерация 7 случайных цифр
            for _ in 1...7 {
                phoneNumber += "\(Int.random(in: 0...9))"
            }
            
            phoneNumbers.append(phoneNumber)
        }
        
        // Вывод сгенерированных номеров телефонов
        for phoneNumber in phoneNumbers {
            destinationView.lbl6.text = "\(phoneNumber)"
        }
        
        let randomEmail = generateRandomEmail()
        destinationView.lbl10.text = "\(randomEmail)"
        
        // Проверяем, что массив не пустой
        if !paymentAndDeliveryMethods.isEmpty {
            // Генерируем случайный индекс в допустимом диапазоне
            let randomPayment = Int.random(in: 0..<paymentAndDeliveryMethods.count)
            // Получаем случайный элемент из массива
            let randomMethod = paymentAndDeliveryMethods[randomPayment]
            detailOrderView.lbl4.text = "\(randomMethod)"
            
        } else {
            print("Массив пустой")
        }
        
        
       
    }
    
    override func styleContent() {
        super.styleContent()
        self.navigationItem.title = "Деталі замовлення"
        view.backgroundColor = .white
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        NSLayoutConstraint.activate([
            orderNumberLabel.topAnchor.constraint(equalTo: orderNumberView.topAnchor, constant: 5),
            orderNumberLabel.bottomAnchor.constraint(equalTo: orderNumberView.bottomAnchor, constant: -5),
            orderNumberLabel.leftAnchor.constraint(equalTo: orderNumberView.leftAnchor, constant: 10),
            orderNumberLabel.rightAnchor.constraint(equalTo: reloadDataButton.leftAnchor),
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            bottomSheetView.heightAnchor.constraint(equalToConstant: 500),
            
            bottomSheetView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            bottomSheetView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            bottomSheetView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            
        ])
    }
    
    lazy var orderNumberView: UIView = {
        let orderNumberView = UIView()
        orderNumberView.backgroundColor = .white
        orderNumberView.layer.cornerRadius = 10
        orderNumberView.translatesAutoresizingMaskIntoConstraints = false
        orderNumberView.layer.borderWidth = 0.2
        orderNumberView.layer.borderColor = UIColor.gray.cgColor
        orderNumberView.layer.shadowColor = UIColor.black.cgColor
        orderNumberView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        orderNumberView.layer.shadowOpacity = 0.2
        orderNumberView.layer.shadowRadius = 2.0
        orderNumberView.addSubview(orderNumberLabel)
        orderNumberView.addSubview(reloadDataButton)
        
        reloadDataButton.frame = CGRect(x: orderNumberView.center.x + 338, y: 5, width: buttonSize.width, height: buttonSize.height)
        
        return orderNumberView
    }()
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 5, y: 5)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return UIImage()
    }
    
    @objc func callButtonTapped() {
        callPhoneNumber(phoneNumber: phoneNumber)
    }
    
    func callPhoneNumber(phoneNumber: String) {
        let formattedNumber = phoneNumber.replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "-", with: "")
            .replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
        
        if let phoneCallURL = URL(string: "tel://+380\(formattedNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                if #available(iOS 10.0, *) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                } else {
                    application.openURL(phoneCallURL)
                }
            }
        }
    }
    
    func generateRandomEmail() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyz"
        let numbers = "0123456789"
        
        let randomLetters = (0..<5).map { _ in letters.randomElement()! }
        let randomNumbers = (0..<5).map { _ in numbers.randomElement()! }
        
        let username = String(randomLetters) + String(randomNumbers)
        let domain = ["gmail.com", "yahoo.com", "hotmail.com", "outlook.com"].randomElement()!
        
        return "\(username)@\(domain)"
    }
    
    @objc func showNotificationView() {
        bottomSheetView.isHidden = false
    }
    
    @objc func closeNotificationView() {
        bottomSheetView.isHidden = true
    }
}

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
