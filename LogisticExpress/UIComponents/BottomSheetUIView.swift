//
//  BottomSheetUIView.swift
//  LogisticExpress
//
//  Created by Дмитрий Соломаха on 16.04.2024.
//

import Foundation
import UIKit

class BottomSheetUIView: UIView {
    
    lazy var bottomView: UIView = {
        let bottomView = UIView()
        bottomView.backgroundColor = .white
        
        bottomView.layer.cornerRadius = 10
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        bottomView.layer.borderWidth = 0.2
        bottomView.layer.borderColor = UIColor.gray.cgColor
        bottomView.layer.shadowColor = UIColor.black.cgColor
        bottomView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        bottomView.layer.shadowOpacity = 0.2
        bottomView.layer.shadowRadius = 2.0
        
        return bottomView
    }()
    
    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Bottom Sheet"
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let orderButton : UIButton = {
        let button = UIButton(type: .system)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Побудувати маршрут", for: .normal)
        button.backgroundColor = .orange
        
        // Set button properties
        button.tintColor = .white
        button.layer.cornerRadius = 25
        
        // Add shadow to the button
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.06).cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 8
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        return button
    }()
    
    lazy var closeButton: UIButton = {
        let closeButton = UIButton(type: .custom)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.clipsToBounds = true
        closeButton.setImage(UIImage(named: "close"), for: .normal)
        return closeButton
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViewHierarchy()
        setupViewAttributes()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViewHierarchy(){
        self.addSubview(bottomView)
       
    }
    
    func setupViewAttributes(){
        self.backgroundColor = .black
        self.layer.cornerRadius = 40
        orderButton.addTarget(self, action: #selector(routePlanningButtonTapped), for: .touchUpInside)
    }
    
    func setupLayout(){
        NSLayoutConstraint.activate([
            
            bottomView.topAnchor.constraint(equalTo: self.topAnchor),
            bottomView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            closeButton.heightAnchor.constraint(equalToConstant: 20),
            closeButton.widthAnchor.constraint(equalToConstant: 20),
            closeButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 10),
            closeButton.rightAnchor.constraint(equalTo: bottomView.rightAnchor, constant: -10),
            
        ])
    }
    
    @objc func addButtonTapped() {
        // Действие, которое происходит при нажатии на кнопку "Добавить"
        print("Кнопка 'Добавить' нажата")
    }
    
}
