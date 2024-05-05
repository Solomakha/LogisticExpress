//
//  BottomSheetUIView.swift
//  LogisticExpress
//
//  Created by Дмитрий Соломаха on 16.04.2024.
//

import Foundation
import UIKit

class BottomSheetUIView: UIView {
    let qrSize: CGFloat = 300
    
    let mkImagew : UIImageView = {
        let imageView = UIImageView()
        //imageView.frame = CGRect(x:  0, y:  0, width:  0, height:  300)
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        imageView.layer.shadowOpacity = 0.2
        imageView.layer.shadowRadius = 2.0
        
        return imageView
    }()
    
    let textLabel : UILabel = {
        let textLabel = UILabel()
        textLabel.text = "Відскануйте QR-code"
        textLabel.textAlignment = .center
        textLabel.font = UIFont.boldSystemFont(ofSize: 20)
        textLabel.textColor = .black
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.sizeToFit()//If required
        return textLabel
    }()
    
    let descriptionLabel : UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Покажіть цей код у вибраній точці обслуговування."
        descriptionLabel.numberOfLines = 2
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.textColor = .gray
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.sizeToFit()//If required
        return descriptionLabel
    }()
    
    lazy var closeButton: UIButton = {
        let closeButton = UIButton(type: .system)
        closeButton.setTitle("Закрити", for: .normal)
        closeButton.backgroundColor = .systemOrange
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.clipsToBounds = true
        closeButton.layer.cornerRadius = 25
        closeButton.setTitleColor(.white, for: .normal)
        return closeButton
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
        setupConstraints()
        mkImagew.translatesAutoresizingMaskIntoConstraints = false
        mkImagew.heightAnchor.constraint(equalToConstant: qrSize).isActive = true
        mkImagew.widthAnchor.constraint(equalToConstant: qrSize).isActive = true
    }
    
    lazy var notificationView: UIView = {
        let notificationView = UIView()
        notificationView.backgroundColor = .white
        notificationView.layer.cornerRadius = 13
        notificationView.translatesAutoresizingMaskIntoConstraints = false
        notificationView.layer.borderWidth = 0.5
        notificationView.layer.borderColor = UIColor.black.cgColor
        notificationView.layer.shadowColor = UIColor.black.cgColor
        notificationView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        notificationView.layer.shadowOpacity = 0.2
        notificationView.layer.shadowRadius = 2.0
        
        notificationView.addSubview(textLabel)
        notificationView.addSubview(descriptionLabel)
        
        notificationView.addSubview(closeButton)
        notificationView.addSubview(mkImagew)
        
        return notificationView
    }()
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            notificationView.topAnchor.constraint(equalTo: self.topAnchor),
            notificationView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            notificationView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            notificationView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            notificationView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            textLabel.topAnchor.constraint(equalTo: notificationView.topAnchor, constant: 15),
            textLabel.leftAnchor.constraint(equalTo: notificationView.leftAnchor, constant: 12),
            textLabel.rightAnchor.constraint(equalTo: notificationView.rightAnchor, constant: -12),
            
            descriptionLabel.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 10),
            descriptionLabel.leftAnchor.constraint(equalTo: notificationView.leftAnchor, constant: 12),
            descriptionLabel.rightAnchor.constraint(equalTo: notificationView.rightAnchor, constant: -12),
            
            closeButton.heightAnchor.constraint(equalToConstant: 50),
            closeButton.rightAnchor.constraint(equalTo: notificationView.rightAnchor, constant: -20),
            closeButton.leftAnchor.constraint(equalTo: notificationView.leftAnchor, constant: 20),
            closeButton.bottomAnchor.constraint(equalTo: notificationView.bottomAnchor, constant: -20),
            mkImagew.centerYAnchor.constraint(equalTo: notificationView.centerYAnchor),
            mkImagew.centerXAnchor.constraint(equalTo: notificationView.centerXAnchor)

        ])
    }
    
}
