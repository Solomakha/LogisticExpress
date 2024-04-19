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
    let qrHeight: CGFloat = 300
    
    var receivedData: [OrderModel] = []
    
    var orderNumber: String = ""
    var orderDate: String = ""
    var deliveryAddress: String = ""
    var storeName: String = ""
    var totalWeight: Int = 0
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
    
    let organisationName: String = "Агро-Нова"
    
    var senderView: SenderInfoView = SenderInfoView()
    var destinationView: DestinationView = DestinationView()
    var bottomButtonView: OSButtonView = OSButtonView()
    
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
        stackView.addArrangedSubview(bottomButtonView, withSpacing: 10)
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
        
        let image = generateQRCode(from: "Let's learn swift.")
        mkImagew.image = image
        mkImagew.heightAnchor.constraint(equalToConstant: qrHeight).isActive = true
        
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
                totalWeight = order.totalWeight
                
                latitude = order.shopCoordinates.0
                longitude = order.shopCoordinates.1
                
                annotation.title = order.storeName
                print(order) // Или любую другую информацию о заказе, которую вы хотите вывести
            }
        }
        
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
        
        storeNameLabel.text = storeName
        storeNameLabel.textAlignment = .center
        storeNameLabel.textColor = .black
        storeNameLabel.font = UIFont.systemFont(ofSize: 15)
        storeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        storeNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        totalWeightLabel.text = String(totalWeight)
        totalWeightLabel.textAlignment = .center
        totalWeightLabel.textColor = .black
        totalWeightLabel.font = UIFont.systemFont(ofSize: 15)
        totalWeightLabel.translatesAutoresizingMaskIntoConstraints = false
        totalWeightLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        orderNumberView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        reloadDataButton.setImage(buttonImage, for: .normal)
        
        
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
    
    let mkImagew : UIImageView = {
        let imageView = UIImageView()
        //imageView.frame = CGRect(x:  0, y:  0, width:  0, height:  300)
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.layer.borderWidth =  0.5
        imageView.layer.borderColor = UIColor.black.cgColor
        
        return imageView
    }()
}
