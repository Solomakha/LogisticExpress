//
//  senderInfoView.swift
//  LogisticExpress
//
//  Created by Дмитрий Соломаха on 16.04.2024.
//

import Foundation
import UIKit

class SenderInfoView: UIView {
    
   
    
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

    
    let notificationView: UIStackView = {
        let viewPersonHeight: CGFloat = 100
        
        let stack = UIStackView()
        stack.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = .white
        stack.axis = .vertical
        stack.layer.cornerRadius = 10
        stack.layer.borderWidth = 0.2
        stack.layer.borderColor = UIColor.gray.cgColor
        stack.layer.shadowColor = UIColor.black.cgColor
        stack.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        stack.layer.shadowOpacity = 0.2
        stack.layer.shadowRadius = 2.0
        stack.heightAnchor.constraint(equalToConstant: viewPersonHeight).isActive = true
        
        let nameView = UIView()
        nameView.translatesAutoresizingMaskIntoConstraints = false
        nameView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        stack.addSubview(nameView)
        
        let titleLabel = UILabel()
        titleLabel.text = "Відправник"
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.sizeToFit()//If required
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        nameView.addSubview(titleLabel)
        
        let nameLabel = UILabel()
        nameLabel.text = "ТОВ Агро-Нова"
        nameLabel.textAlignment = .right
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        nameLabel.textColor = .black
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.sizeToFit()//If required
        nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        nameView.addSubview(nameLabel)
        
        let infoView = UIView()
        infoView.backgroundColor = .white
        //infoView.layer.cornerRadius = 10
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        stack.addSubview(infoView)
        //
        let stack2 = UIStackView()
        stack2.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        stack2.isLayoutMarginsRelativeArrangement = true
        
        // Установить положение компонентов внутри Stack
        stack2.axis = .horizontal
        stack2.backgroundColor = .white
        
        stack2.translatesAutoresizingMaskIntoConstraints = false
        
        stack2.heightAnchor.constraint(equalToConstant: 30).isActive = true
        infoView.addSubview(stack2)
        
        let lbl1 = UILabel()
        lbl1.text = "E-mail"
        lbl1.textAlignment = .left
        lbl1.textColor = .gray
        lbl1.font = UIFont.systemFont(ofSize: 15)
        lbl1.translatesAutoresizingMaskIntoConstraints = false
        stack2.addSubview(lbl1)
        
        let lbl2 = UILabel()
        lbl2.text = "george@gmail.com"
        lbl2.textAlignment = .left
        lbl2.font = UIFont.systemFont(ofSize: 15)
        lbl2.translatesAutoresizingMaskIntoConstraints = false
        stack2.addSubview(lbl2)
        //
        let stack3 = UIStackView()
        stack3.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        stack3.isLayoutMarginsRelativeArrangement = true
        
        // Установить положение компонентов внутри Stack
        stack3.axis = .horizontal
        stack3.backgroundColor = .white
        
        stack3.translatesAutoresizingMaskIntoConstraints = false
        
        
        stack3.heightAnchor.constraint(equalToConstant: 30).isActive = true
        infoView.addSubview(stack3)
        //
        let lbl3 = UILabel()
        lbl3.text = "Номер телефону"
        lbl3.textAlignment = .left
        lbl3.textColor = .gray
        lbl3.font = UIFont.systemFont(ofSize: 15)
        lbl3.translatesAutoresizingMaskIntoConstraints = false
        stack3.addArrangedSubview(lbl3)
        
        let lbl4 = UILabel()
        lbl4.text = "+380991234567"
        lbl4.textAlignment = .left
        lbl4.font = UIFont.systemFont(ofSize: 15)
        lbl4.translatesAutoresizingMaskIntoConstraints = false
        stack3.addArrangedSubview(lbl4)
        
        NSLayoutConstraint.activate([
            
            nameView.topAnchor.constraint(equalTo: stack.topAnchor),
            nameView.leftAnchor.constraint(equalTo: stack.leftAnchor),
            nameView.rightAnchor.constraint(equalTo: stack.rightAnchor),
            nameView.centerXAnchor.constraint(equalTo: stack.centerXAnchor),
            
            
            titleLabel.topAnchor.constraint(equalTo: nameView.topAnchor, constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: nameView.leftAnchor, constant: 10),
            
            titleLabel.centerXAnchor.constraint(equalTo: nameView.centerXAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: nameView.topAnchor, constant: 10),
            
            nameLabel.rightAnchor.constraint(equalTo: nameView.rightAnchor, constant: -10),
            
            nameLabel.centerXAnchor.constraint(equalTo: nameView.centerXAnchor),
            //
            infoView.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 5),
            infoView.leftAnchor.constraint(equalTo: stack.leftAnchor),
            infoView.rightAnchor.constraint(equalTo: stack.rightAnchor),
            //infoView.bottomAnchor.constraint(equalTo: stack.bottomAnchor, constant: -10),
            //
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
            lbl4.leftAnchor.constraint(equalTo: lbl3.rightAnchor, constant: 5),
            lbl4.rightAnchor.constraint(equalTo: stack3.rightAnchor, constant: -10),
            //
            
        ])
        
        return stack
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
}
