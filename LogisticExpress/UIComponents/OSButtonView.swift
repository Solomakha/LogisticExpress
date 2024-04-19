//
//  destinationView.swift
//  LogisticExpress
//
//  Created by Дмитрий Соломаха on 16.04.2024.
//

import Foundation
import UIKit

class OSButtonView: UIView {
 
    init() {
        super.init(frame: .zero)
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(notificationView)
        setupConstraints()
        
    }
    
    
    let notificationView: UIView = {
        let viewPersonHeight: CGFloat = 100
        
        let infoView = UIView()
        infoView.backgroundColor = .white
        infoView.layer.cornerRadius = 10
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        
        let biggerButton = UIButton()
        biggerButton.setTitle("Зателефонувати", for: .normal)
        biggerButton.backgroundColor = .systemGreen
        biggerButton.translatesAutoresizingMaskIntoConstraints = false
        biggerButton.layer.cornerRadius = 30

        biggerButton.layer.borderWidth = 0.2
        biggerButton.layer.borderColor = UIColor.gray.cgColor
        biggerButton.layer.shadowColor = UIColor.black.cgColor
        biggerButton.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        biggerButton.layer.shadowOpacity = 0.2
        biggerButton.layer.shadowRadius = 2.0
        
        infoView.addSubview(biggerButton)
        
        let smallerButton = UIButton()
        
        smallerButton.backgroundColor = .black
        smallerButton.translatesAutoresizingMaskIntoConstraints = false
        smallerButton.layer.cornerRadius = 15
        smallerButton.addTarget(self, action: #selector(openQRView), for: .touchUpInside)
        
        smallerButton.layer.borderWidth = 0.2
        smallerButton.layer.borderColor = UIColor.gray.cgColor
        smallerButton.layer.shadowColor = UIColor.black.cgColor
        smallerButton.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        smallerButton.layer.shadowOpacity = 0.2
        smallerButton.layer.shadowRadius = 2.0
        
        let smallerImage = UIImage(named: "qr") // замените "smallerIcon" на имя вашего изображения
        smallerButton.setImage(smallerImage, for: .normal)

        infoView.addSubview(smallerButton)
        
        NSLayoutConstraint.activate([
            biggerButton.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 5),
            biggerButton.leadingAnchor.constraint(equalTo: infoView.leadingAnchor),
            biggerButton.trailingAnchor.constraint(equalTo: smallerButton.leadingAnchor, constant: -10),
            biggerButton.centerYAnchor.constraint(equalTo: infoView.centerYAnchor),
            biggerButton.bottomAnchor.constraint(equalTo: infoView.bottomAnchor, constant: -5),
            biggerButton.heightAnchor.constraint(equalToConstant: 60),
            
            smallerButton.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 5),
            smallerButton.bottomAnchor.constraint(equalTo: infoView.bottomAnchor, constant: -5),
            smallerButton.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -10),
            smallerButton.centerYAnchor.constraint(equalTo: infoView.centerYAnchor),
            smallerButton.widthAnchor.constraint(equalToConstant: 60),
            smallerButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        return infoView
    }()
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            notificationView.topAnchor.constraint(equalTo: self.topAnchor),
            notificationView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            notificationView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            notificationView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            notificationView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    @objc func openQRView() {
        print("QR opened")
       
    }
    
    
}
