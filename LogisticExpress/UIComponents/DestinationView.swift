//
//  destinationView.swift
//  LogisticExpress
//
//  Created by Дмитрий Соломаха on 16.04.2024.
//

import Foundation
import UIKit

class DestinationView: UIView {
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(destinationView)
        destinationView.addSubview(nameView)
        nameView.addSubview(titleLabel)
        destinationView.addSubview(infoView)
        infoView.addSubview(stack2)
        stack2.addSubview(lbl1)
        stack2.addSubview(lbl2)
        infoView.addSubview(stack3)
        stack3.addSubview(lbl3)
        stack3.addSubview(lbl4)
        infoView.addSubview(stack4)
        stack4.addSubview(lbl5)
        stack4.addSubview(lbl6)
        infoView.addSubview(stack5)
        stack5.addSubview(lbl7)
        stack5.addSubview(lbl8)
        infoView.addSubview(stack6)
        stack6.addSubview(lbl9)
        stack6.addSubview(lbl10)
        setupConstraints()
        
    }
    
    
    
    let nameView : UIView = {
        let nameView = UIView()
        nameView.translatesAutoresizingMaskIntoConstraints = false
        nameView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return nameView
    }()
    
    let titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Отримувач"
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.sizeToFit()//If required
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        return titleLabel
    }()
    
    
    
    let infoView : UIView = {
        let infoView = UIView()
        infoView.backgroundColor = .white
        //infoView.layer.cornerRadius = 10
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        return infoView
    }()
    
    let stack2: UIStackView = {
        let stack2 = UIStackView()
        stack2.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        stack2.isLayoutMarginsRelativeArrangement = true
        
        // Установить положение компонентов внутри Stack
        stack2.axis = .horizontal
        stack2.backgroundColor = .white
        
        stack2.translatesAutoresizingMaskIntoConstraints = false
        
        stack2.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return stack2
    }()
    
    let lbl1 : UILabel = {
        let lbl1 = UILabel()
        lbl1.text = "Компанія"
        lbl1.textAlignment = .left
        lbl1.textColor = .gray
        lbl1.font = UIFont.systemFont(ofSize: 15)
        lbl1.translatesAutoresizingMaskIntoConstraints = false
        
        //
        return lbl1
    }()
    
    let lbl2 : UILabel = {
        let lbl2 = UILabel()
        lbl2.textAlignment = .left
        lbl2.font = UIFont.systemFont(ofSize: 15)
        lbl2.translatesAutoresizingMaskIntoConstraints = false
        return lbl2
    }()
    
    
    
    
    let stack3: UIStackView = {
        let stack3 = UIStackView()
        stack3.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        stack3.isLayoutMarginsRelativeArrangement = true
        
        // Установить положение компонентов внутри Stack
        stack3.axis = .horizontal
        stack3.backgroundColor = .white
        
        stack3.translatesAutoresizingMaskIntoConstraints = false
        
        
        stack3.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return stack3
    }()
    
    let lbl3 : UILabel = {
        let lbl3 = UILabel()
        lbl3.text = "Ім'я, Прізвище"
        lbl3.textAlignment = .left
        lbl3.textColor = .gray
        lbl3.font = UIFont.systemFont(ofSize: 15)
        lbl3.translatesAutoresizingMaskIntoConstraints = false
        return lbl3
    }()
    
    let lbl4 : UILabel = {
        let lbl4 = UILabel()
        lbl4.textAlignment = .left
        lbl4.font = UIFont.systemFont(ofSize: 15)
        lbl4.translatesAutoresizingMaskIntoConstraints = false
        return lbl4
    }()
    
    let stack4: UIStackView = {
        let stack4 = UIStackView()
        stack4.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        stack4.isLayoutMarginsRelativeArrangement = true
        stack4.axis = .horizontal
        stack4.backgroundColor = .white
        stack4.translatesAutoresizingMaskIntoConstraints = false
        stack4.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return stack4
    }()
    
    let lbl5 : UILabel = {
        let lbl5 = UILabel()
        lbl5.text = "Телефон"
        lbl5.textAlignment = .left
        lbl5.textColor = .gray
        lbl5.font = UIFont.systemFont(ofSize: 15)
        lbl5.translatesAutoresizingMaskIntoConstraints = false
        
        //
        return lbl5
    }()
    
    let lbl6 : UILabel = {
        let lbl6 = UILabel()
        lbl6.textAlignment = .left
        lbl6.font = UIFont.systemFont(ofSize: 15)
        lbl6.translatesAutoresizingMaskIntoConstraints = false
        return lbl6
    }()
    
    let stack5: UIStackView = {
        let stack5 = UIStackView()
        stack5.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        stack5.isLayoutMarginsRelativeArrangement = true
        stack5.axis = .horizontal
        stack5.backgroundColor = .white
        stack5.translatesAutoresizingMaskIntoConstraints = false
        stack5.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return stack5
    }()
    
    let lbl7 : UILabel = {
        let lbl7 = UILabel()
        lbl7.text = "Адреса доставки"
        lbl7.textAlignment = .left
        lbl7.textColor = .gray
        lbl7.font = UIFont.systemFont(ofSize: 15)
        lbl7.translatesAutoresizingMaskIntoConstraints = false
        return lbl7
    }()
    
    let lbl8 : UILabel = {
        let lbl8 = UILabel()
        lbl8.textAlignment = .left
        lbl8.font = UIFont.systemFont(ofSize: 15)
        lbl8.translatesAutoresizingMaskIntoConstraints = false
        return lbl8
    }()
    
    let stack6: UIStackView = {
        let stack6 = UIStackView()
        stack6.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        stack6.isLayoutMarginsRelativeArrangement = true
        stack6.axis = .horizontal
        stack6.backgroundColor = .white
        stack6.translatesAutoresizingMaskIntoConstraints = false
        stack6.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return stack6
    }()
    
    let lbl9 : UILabel = {
        let lbl9 = UILabel()
        lbl9.text = "E-mail"
        lbl9.textAlignment = .left
        lbl9.textColor = .gray
        lbl9.font = UIFont.systemFont(ofSize: 15)
        lbl9.translatesAutoresizingMaskIntoConstraints = false
        return lbl9
    }()
    
    let lbl10 : UILabel = {
        let lbl10 = UILabel()
        lbl10.textAlignment = .left
        lbl10.font = UIFont.systemFont(ofSize: 15)
        lbl10.translatesAutoresizingMaskIntoConstraints = false
        return lbl10
    }()
    
    let destinationView: UIStackView = {
        let viewHeight: CGFloat = 190
        
        let destinationView = UIStackView()
        destinationView.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        destinationView.isLayoutMarginsRelativeArrangement = true
        destinationView.translatesAutoresizingMaskIntoConstraints = false
        destinationView.backgroundColor = .white
        destinationView.axis = .vertical
        destinationView.layer.cornerRadius = 10
        destinationView.layer.borderWidth = 0.2
        destinationView.layer.borderColor = UIColor.gray.cgColor
        destinationView.layer.shadowColor = UIColor.black.cgColor
        destinationView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        destinationView.layer.shadowOpacity = 0.2
        destinationView.layer.shadowRadius = 2.0
        destinationView.heightAnchor.constraint(equalToConstant: viewHeight).isActive = true
        
        return destinationView
    }()
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            destinationView.topAnchor.constraint(equalTo: self.topAnchor),
            destinationView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            destinationView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            destinationView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            destinationView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            nameView.topAnchor.constraint(equalTo: destinationView.topAnchor, constant: 2),
            nameView.leadingAnchor.constraint(equalTo: destinationView.leadingAnchor, constant: 2),
            nameView.trailingAnchor.constraint(equalTo: destinationView.trailingAnchor, constant: -2),
            nameView.centerXAnchor.constraint(equalTo: destinationView.centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: nameView.topAnchor, constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: nameView.leftAnchor, constant: 10),
            
            titleLabel.centerXAnchor.constraint(equalTo: nameView.centerXAnchor),
            
        
            
            infoView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 5),
            infoView.leftAnchor.constraint(equalTo: destinationView.leftAnchor),
            infoView.rightAnchor.constraint(equalTo: destinationView.rightAnchor),
            //infoView.bottomAnchor.constraint(equalTo: stack.bottomAnchor, constant: -10),
            
            stack2.topAnchor.constraint(equalTo: infoView.topAnchor),
            stack2.leftAnchor.constraint(equalTo: infoView.leftAnchor),
            stack2.rightAnchor.constraint(equalTo: infoView.rightAnchor),
            //
            lbl1.topAnchor.constraint(equalTo: stack2.topAnchor, constant: 5),
            lbl1.leftAnchor.constraint(equalTo: stack2.leftAnchor, constant: 10),
            
            lbl2.topAnchor.constraint(equalTo: stack2.topAnchor, constant: 5),
            lbl2.rightAnchor.constraint(equalTo: stack2.rightAnchor, constant: -10),
            
            stack3.topAnchor.constraint(equalTo: stack2.bottomAnchor),
            stack3.leftAnchor.constraint(equalTo: infoView.leftAnchor),
            stack3.rightAnchor.constraint(equalTo: infoView.rightAnchor),
            
            lbl3.topAnchor.constraint(equalTo: stack3.topAnchor, constant: 5),
            lbl3.leftAnchor.constraint(equalTo: stack3.leftAnchor, constant: 10),
            
            lbl4.topAnchor.constraint(equalTo: stack3.topAnchor, constant: 5),
            
            lbl4.rightAnchor.constraint(equalTo: stack3.rightAnchor, constant: -10),
            
            stack4.topAnchor.constraint(equalTo: stack3.bottomAnchor),
            stack4.leftAnchor.constraint(equalTo: infoView.leftAnchor),
            stack4.rightAnchor.constraint(equalTo: infoView.rightAnchor),
            
            lbl5.topAnchor.constraint(equalTo: stack4.topAnchor, constant: 5),
            lbl5.leftAnchor.constraint(equalTo: stack4.leftAnchor, constant: 10),
            
            lbl6.topAnchor.constraint(equalTo: stack4.topAnchor, constant: 5),
            
            lbl6.rightAnchor.constraint(equalTo: stack4.rightAnchor, constant: -10),
            
            stack5.topAnchor.constraint(equalTo: stack4.bottomAnchor),
            stack5.leftAnchor.constraint(equalTo: infoView.leftAnchor),
            stack5.rightAnchor.constraint(equalTo: infoView.rightAnchor),
            
            lbl7.topAnchor.constraint(equalTo: stack5.topAnchor, constant: 5),
            lbl7.leftAnchor.constraint(equalTo: stack5.leftAnchor, constant: 10),
            
            lbl8.topAnchor.constraint(equalTo: stack5.topAnchor, constant: 5),
            
            lbl8.rightAnchor.constraint(equalTo: stack5.rightAnchor, constant: -10),
            
            stack6.topAnchor.constraint(equalTo: stack5.bottomAnchor),
            stack6.leftAnchor.constraint(equalTo: infoView.leftAnchor),
            stack6.rightAnchor.constraint(equalTo: infoView.rightAnchor),
            
            lbl9.topAnchor.constraint(equalTo: stack6.topAnchor, constant: 5),
            lbl9.leftAnchor.constraint(equalTo: stack6.leftAnchor, constant: 10),
            
            lbl10.topAnchor.constraint(equalTo: stack6.topAnchor, constant: 5),
            
            lbl10.rightAnchor.constraint(equalTo: stack6.rightAnchor, constant: -10),
            
        ])
    }
}
