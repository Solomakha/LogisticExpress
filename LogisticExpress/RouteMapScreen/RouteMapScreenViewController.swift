//
//  RouteMapScreenViewController.swift
//  LogisticExpress
//
//  Created by Дмитрий Соломаха on 13.04.2024.
//

import UIKit
import MapKit

class RouteMapScreenViewController: SGStackViewController {
    
    weak var coordinator: RouteMapScreenCoordinator?
    var map: SGMap = SGMap()
    let mapHeight: CGFloat = 350
    let qrHeight: CGFloat = 300
    
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
        
        if !receivedCoordinates.isEmpty {
            let mapRegion = region(for: receivedCoordinates)
            map.setRegion(mapRegion, animated: true)
        }
    }
    
    private func region(for coordinates: [(Double, Double)]) -> MKCoordinateRegion {
        let latitudes = coordinates.map { $0.0 }
        let longitudes = coordinates.map { $0.1 }
        
        let maxLat = latitudes.max()!
        let minLat = latitudes.min()!
        let maxLong = longitudes.max()!
        let minLong = longitudes.min()!
        
        let center = CLLocationCoordinate2D(latitude: (maxLat + minLat) / 2, longitude: (maxLong + minLong) / 2)
        let span = MKCoordinateSpan(latitudeDelta: (maxLat - minLat) * 1.1, longitudeDelta: (maxLong - minLong) * 1.1)
        
        return MKCoordinateRegion(center: center, span: span)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSubviews()
        // Do any additional setup after loading the view.
    }
    
    // MARK: CGConstruction funcs
    override func addContent() {
        super.addContent()
        stackView.addArrangedSubview(map)
        stackView.addArrangedSubview(mkImagew, withSpacing: 10)
    }
    
    override func configureContent() {
        super.configureContent()
        
        stackView.spacing = 10
        
        //self.navigationController?.hidesBarsOnTap = true
        //self.navigationController?.hidesBarsOnSwipe = true
        
        // Set button properties
        map.layer.cornerRadius = 10
        map.backgroundColor = .lightGray
        
        // Add shadow to the button
        map.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.35).cgColor
        map.layer.shadowOpacity = 1
        map.layer.shadowRadius = 5
        map.layer.shadowOffset = CGSize(width: 2, height: 2)
        
        map.heightAnchor.constraint(equalToConstant: mapHeight).isActive = true
        
        let image = generateQRCode(from: "Let's learn swift.")
        mkImagew.image = image
        mkImagew.heightAnchor.constraint(equalToConstant: qrHeight).isActive = true
        
        //        navigationController?.navigationBar.clearsContextBeforeDrawing = true
        //        navigationController?.isNavigationBarHidden = true
    }
    
    override func styleContent() {
        super.styleContent()
        self.navigationItem.title = "Замовлення"
        view.backgroundColor = .white
        
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
