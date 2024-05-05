//
//  DeteilOrderView.swift
//  LogisticExpress
//
//  Created by Дмитрий Соломаха on 28.04.2024.
//

import Foundation
import UIKit

class DetailOrderView: UIView {

   
    
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
        infoView.addSubview(stack3)
        stack3.addSubview(lbl3)
        stack3.addSubview(lbl4)
        infoView.addSubview(stack4)
        stack4.addSubview(lbl5)
        stack4.addSubview(lbl6)
        infoView.addSubview(textView)
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
        titleLabel.text = "Деталі замовлення"
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
        lbl1.text = "Товари:"
        lbl1.textAlignment = .left
        lbl1.textColor = .gray
        lbl1.font = UIFont.systemFont(ofSize: 15)
        lbl1.translatesAutoresizingMaskIntoConstraints = false
        return lbl1
    }()

    let stack3: UIStackView = {
        let stack3 = UIStackView()
        stack3.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        stack3.isLayoutMarginsRelativeArrangement = true
        
        // Установить положение компонентов внутри Stack
        stack3.axis = .vertical
        stack3.backgroundColor = .white
        
        stack3.translatesAutoresizingMaskIntoConstraints = false
        
        
        stack3.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return stack3
    }()
    
    let lbl3 : UILabel = {
        let lbl3 = UILabel()
        lbl3.text = "Спосіб оплати:"
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
        stack4.axis = .vertical
        stack4.backgroundColor = .white
        stack4.translatesAutoresizingMaskIntoConstraints = false
        stack4.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return stack4
    }()
    
    let lbl5 : UILabel = {
        let lbl5 = UILabel()
        lbl5.text = "Спосіб доставки:"
        lbl5.textAlignment = .left
        lbl5.textColor = .gray
        lbl5.font = UIFont.systemFont(ofSize: 15)
        lbl5.translatesAutoresizingMaskIntoConstraints = false
        return lbl5
    }()
    
    let lbl6 : UILabel = {
        let lbl6 = UILabel()
        lbl6.text = "Рефрижераторний автотранспорт"
        lbl6.textAlignment = .left
        lbl6.font = UIFont.systemFont(ofSize: 15)
        lbl6.translatesAutoresizingMaskIntoConstraints = false
        return lbl6
    }()
    
    let textView : UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textAlignment = .left
        textView.isEditable = true // Разрешить редактирование текста
        textView.isScrollEnabled = true // Разрешить прокрутку текста, если текст не помещается в пределах textView
        
        // Настройка внешнего вида
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.cornerRadius = 8.0
        return textView
    }()
    
    let destinationView: UIStackView = {
        let viewHeight: CGFloat = 500
        
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
    
    func updateTextViewWithProducts(_ text: String) {
        // Добавляем новую строку к существующему тексту в textView
        textView.text.append("\(text)\n")
    }
    
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

            stack2.topAnchor.constraint(equalTo: infoView.topAnchor),
            stack2.leftAnchor.constraint(equalTo: infoView.leftAnchor),
            stack2.rightAnchor.constraint(equalTo: infoView.rightAnchor),
            //
            lbl1.topAnchor.constraint(equalTo: stack2.topAnchor, constant: 5),
            lbl1.leftAnchor.constraint(equalTo: stack2.leftAnchor, constant: 10),
            lbl1.rightAnchor.constraint(equalTo: stack2.rightAnchor, constant: -10),
       
            textView.topAnchor.constraint(equalTo: stack2.bottomAnchor, constant: 5),
            textView.leftAnchor.constraint(equalTo: infoView.leftAnchor, constant: 10),
            textView.rightAnchor.constraint(equalTo: infoView.rightAnchor, constant: -10),
            textView.heightAnchor.constraint(equalToConstant: 300),
            
            stack3.topAnchor.constraint(equalTo: textView.bottomAnchor),
            stack3.leftAnchor.constraint(equalTo: infoView.leftAnchor),
            stack3.rightAnchor.constraint(equalTo: infoView.rightAnchor),
            
            lbl3.topAnchor.constraint(equalTo: stack3.topAnchor, constant: 5),
            lbl3.leftAnchor.constraint(equalTo: stack3.leftAnchor, constant: 10),
            lbl3.rightAnchor.constraint(equalTo: stack3.rightAnchor, constant: -10),
            
            lbl4.topAnchor.constraint(equalTo: lbl3.bottomAnchor, constant: 5),
            lbl4.leftAnchor.constraint(equalTo: stack3.leftAnchor, constant: 10),
            lbl4.rightAnchor.constraint(equalTo: stack3.rightAnchor, constant: -10),
            
            stack4.topAnchor.constraint(equalTo: stack3.bottomAnchor),
            stack4.leftAnchor.constraint(equalTo: infoView.leftAnchor),
            stack4.rightAnchor.constraint(equalTo: infoView.rightAnchor),
            
            lbl5.topAnchor.constraint(equalTo: stack4.topAnchor, constant: 5),
            lbl5.leftAnchor.constraint(equalTo: stack4.leftAnchor, constant: 10),
            lbl5.rightAnchor.constraint(equalTo: stack4.rightAnchor, constant: -10),
            
            lbl6.topAnchor.constraint(equalTo: lbl5.bottomAnchor, constant: 5),
            lbl6.leftAnchor.constraint(equalTo: stack4.leftAnchor, constant: 10),
            lbl6.rightAnchor.constraint(equalTo: stack4.rightAnchor, constant: -10),
            
           
        ])
    }
}
