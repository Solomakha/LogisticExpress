//
//  destinationView.swift
//  LogisticExpress
//
//  Created by Дмитрий Соломаха on 16.04.2024.
//

import Foundation
import UIKit

class OSButtonView: UIView {
    
    let biggerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Зателефонувати", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(makeCall), for: .touchUpInside)
        button.layer.borderWidth = 0.2
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 2.0
        return button
    }()
    
    let smallerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(openQRView), for: .touchUpInside)
        button.layer.borderWidth = 0.2
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 2.0
        
        let smallerImage = UIImage(named: "qr") // замените "smallerIcon" на имя вашего изображения
        button.setImage(smallerImage, for: .normal)
        // Добавление обработчика нажатия на кнопку
        //button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(notificationView)
        setupButtons()
        setupConstraints()
    }
    
    let notificationView: UIView = {
        let infoView = UIView()
        infoView.backgroundColor = .white
        infoView.layer.cornerRadius = 10
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        return infoView
    }()
    
    private func setupButtons() {
        notificationView.addSubview(biggerButton)
        notificationView.addSubview(smallerButton)
        
        NSLayoutConstraint.activate([
            biggerButton.topAnchor.constraint(equalTo: notificationView.topAnchor, constant: 5),
            biggerButton.leadingAnchor.constraint(equalTo: notificationView.leadingAnchor),
            biggerButton.trailingAnchor.constraint(equalTo: smallerButton.leadingAnchor, constant: -10),
            biggerButton.centerYAnchor.constraint(equalTo: notificationView.centerYAnchor),
            biggerButton.bottomAnchor.constraint(equalTo: notificationView.bottomAnchor, constant: -5),
            biggerButton.heightAnchor.constraint(equalToConstant: 60),
            
            smallerButton.topAnchor.constraint(equalTo: notificationView.topAnchor, constant: 5),
            smallerButton.bottomAnchor.constraint(equalTo: notificationView.bottomAnchor, constant: -5),
            smallerButton.trailingAnchor.constraint(equalTo: notificationView.trailingAnchor, constant: -10),
            smallerButton.centerYAnchor.constraint(equalTo: notificationView.centerYAnchor),
            smallerButton.widthAnchor.constraint(equalToConstant: 60),
            smallerButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
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
    @objc func makeCall() {
        print("call")
       
    }
}
