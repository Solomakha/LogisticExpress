//
//  NotificationView.swift
//  LogisticExpress
//
//  Created by Дмитрий Соломаха on 10.04.2024.
//

import Foundation
import UIKit

class NotificationView: UIView {
    
    var dateString: String = ""
    var newOrderString: String = ""
    
    let dateTimeLabel = UILabel()
    let boxImageView = UIImageView(frame: CGRectMake(10, 30, 30, 30))
    
    
    
    init(dateString:String, newOrderString:String) {
        self.dateString = dateString
        self.newOrderString = newOrderString
        super.init(frame: .zero)
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(notificationView)
        setupConstraints()
        
        dateTimeLabel.text = dateString
        dateTimeLabel.textAlignment = .left
        dateTimeLabel.font = UIFont.boldSystemFont(ofSize: 18)
        dateTimeLabel.textColor = .blue
        dateTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        dateTimeLabel.sizeToFit()//If required
        //-------
        boxImageView.layer.masksToBounds = false
        boxImageView.clipsToBounds = true
        boxImageView.image =  UIImage(named: "logistics-3")
        
        
    }
    
    lazy var notificationView: UIView = {
        let notificationView = UIView()
        notificationView.backgroundColor = .white
        notificationView.layer.cornerRadius = 10
        notificationView.layer.borderWidth =  0.1
        notificationView.layer.borderColor = UIColor.lightGray.cgColor
        notificationView.translatesAutoresizingMaskIntoConstraints = false
        
        notificationView.layer.shadowColor = UIColor.black.cgColor
        notificationView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        notificationView.layer.shadowOpacity = 0.2
        notificationView.layer.shadowRadius = 2.0
        
        notificationView.addSubview(dateTimeLabel)
        notificationView.addSubview(boxImageView)
        notificationView.addSubview(closeButton)
        
        return notificationView
    }()
    
    lazy var closeButton: UIButton = {
        let closeButton = UIButton(type: .custom)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.clipsToBounds = true
        closeButton.setImage(UIImage(named: "close"), for: .normal)
        return closeButton
    }()
    
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            notificationView.topAnchor.constraint(equalTo: self.topAnchor),
            notificationView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            notificationView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            notificationView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            notificationView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            dateTimeLabel.topAnchor.constraint(equalTo: notificationView.topAnchor, constant: 5),
            dateTimeLabel.leftAnchor.constraint(equalTo: notificationView.leftAnchor, constant: 12),
            
            closeButton.heightAnchor.constraint(equalToConstant: 20),
            closeButton.widthAnchor.constraint(equalToConstant: 20),
            closeButton.topAnchor.constraint(equalTo: notificationView.topAnchor, constant: 10),
            closeButton.rightAnchor.constraint(equalTo: notificationView.rightAnchor, constant: -10),

        ])
    }
}
