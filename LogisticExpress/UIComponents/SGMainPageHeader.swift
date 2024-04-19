//
//  SGMainPageHeader.swift
//  LogisticExpress
//
//  Created by Дмитрий Соломаха on 16.03.2024.
//

import Foundation
import UIKit

class SGMainPageHeader: UIView {
    
    let userImageView = UIImageView(frame: CGRectMake(10, 10, 70, 70))
    let locationImageView = UIImageView(frame: CGRectMake(90, 40, 17, 17))
    let massageLabel = UILabel()
    let nameLabel = UILabel()
    
   var name: String = ""
    
    init(name:String) {
        self.name = name
        super.init(frame: .zero)
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(mainView)
        setupConstraints()
        
        userImageView.backgroundColor = UIColor(red: 0, green: 0, blue: 213, alpha: 0.2)
        userImageView.layer.borderWidth = 1.0
        userImageView.layer.masksToBounds = false
        userImageView.layer.borderColor = UIColor.gray.cgColor
        userImageView.layer.cornerRadius = 35
        userImageView.clipsToBounds = true
        userImageView.image =  UIImage(named: "man")
        
        
        //locationImageView.translatesAutoresizingMaskIntoConstraints = false
        locationImageView.layer.masksToBounds = false
        locationImageView.clipsToBounds = true
        locationImageView.image =  UIImage(named: "locator")
        
       
        nameLabel.text = name
        nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 3
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        nameLabel.textColor = .black
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.sizeToFit()
        
        massageLabel.text = "м.Харків, вул.Перемоги, буд.45"
        massageLabel.textAlignment = .left
        massageLabel.font = UIFont.boldSystemFont(ofSize: 15)
        massageLabel.textColor = .gray
        massageLabel.translatesAutoresizingMaskIntoConstraints = false
        massageLabel.sizeToFit()//If required
        
    }
    
    lazy var mainView: UIView = {
        let userView = UIView()
        //userView.backgroundColor = UIColor(red: 150, green: 0, blue: 255, alpha: 1)
        userView.backgroundColor = .clear
        userView.layer.cornerRadius = 10
        userView.layer.borderWidth =  0.1
        userView.layer.borderColor = UIColor.lightGray.cgColor
        userView.translatesAutoresizingMaskIntoConstraints = false
        
        userView.addSubview(userImageView)
        userView.addSubview(nameLabel)
        userView.addSubview(massageLabel)
        userView.addSubview(locationImageView)

        return userView
    }()
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.topAnchor),
            mainView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10),
            nameLabel.leftAnchor.constraint(equalTo: userImageView.rightAnchor, constant: 10),
            nameLabel.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -5),
            
            massageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3),
            massageLabel.leftAnchor.constraint(equalTo: locationImageView.rightAnchor, constant: 5),
            massageLabel.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -10),
            
            locationImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            locationImageView.leftAnchor.constraint(equalTo: userImageView.rightAnchor),
        ])
    }
}
