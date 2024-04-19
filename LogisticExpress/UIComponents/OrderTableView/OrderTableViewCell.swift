//
//  CustomTableViewCell.swift
//  LogisticExpress
//
//  Created by Дмитрий Соломаха on 31.03.2024.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
  
    let mainView: UIView = {
        let titleOrderView = UIView()
        titleOrderView.backgroundColor = .random
        titleOrderView.layer.cornerRadius = 10
        titleOrderView.translatesAutoresizingMaskIntoConstraints = false
        titleOrderView.layer.borderWidth = 0.2
        titleOrderView.layer.borderColor = UIColor.gray.cgColor
        
        titleOrderView.layer.shadowColor = UIColor.black.cgColor
        titleOrderView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        titleOrderView.layer.shadowOpacity = 0.2
        titleOrderView.layer.shadowRadius = 2.0
        
        return titleOrderView
    }()
    
    let orderView: UIView = {
        let titleOrderView = UIView()
        titleOrderView.backgroundColor = .white
        titleOrderView.layer.cornerRadius = 10
        titleOrderView.translatesAutoresizingMaskIntoConstraints = false
        
        return titleOrderView
    }()
    
    let orderNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let orderDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    let deliveryAddressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    let storeNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let totalWeightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let calendarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        imageView.image =  UIImage(named: "calendar")
        return imageView
    }()
    
    let storeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        imageView.image =  UIImage(named: "shop")
        return imageView
    }()
    
    let geoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        imageView.image =  UIImage(named: "locator")
        return imageView
    }()
    
    let weightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        imageView.image =  UIImage(named: "weight")
        return imageView
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        addSubview(mainView)
        mainView.addSubview(orderView)
        orderView.addSubview(orderNumberLabel)
        orderView.addSubview(orderDateLabel)
        orderView.addSubview(deliveryAddressLabel)
        orderView.addSubview(storeNameLabel)
        orderView.addSubview(totalWeightLabel)
        orderView.addSubview(calendarImageView)
        orderView.addSubview(storeImageView)
        orderView.addSubview(geoImageView)
        orderView.addSubview(weightImageView)
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            mainView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mainView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            mainView.heightAnchor.constraint(equalToConstant: 130),
            
            orderView.topAnchor.constraint(equalTo: mainView.topAnchor),
            orderView.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            orderView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10),
            orderView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            orderView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            
            orderNumberLabel.topAnchor.constraint(equalTo: orderView.topAnchor, constant: 5),
            orderNumberLabel.leadingAnchor.constraint(equalTo: orderView.leadingAnchor, constant: 8),
            orderNumberLabel.trailingAnchor.constraint(equalTo: orderView.trailingAnchor, constant: -8),
            
            orderDateLabel.topAnchor.constraint(equalTo: orderNumberLabel.bottomAnchor, constant: 5),
            orderDateLabel.leadingAnchor.constraint(equalTo: calendarImageView.trailingAnchor),
            orderDateLabel.trailingAnchor.constraint(equalTo: orderView.trailingAnchor, constant: -8),
            
            storeNameLabel.topAnchor.constraint(equalTo: orderDateLabel.bottomAnchor, constant: 6),
            storeNameLabel.leadingAnchor.constraint(equalTo: storeImageView.trailingAnchor),
            storeNameLabel.trailingAnchor.constraint(equalTo: orderView.trailingAnchor, constant: -8),
            
            deliveryAddressLabel.topAnchor.constraint(equalTo: storeNameLabel.bottomAnchor, constant: 6),
            deliveryAddressLabel.leadingAnchor.constraint(equalTo: geoImageView.trailingAnchor),
            deliveryAddressLabel.trailingAnchor.constraint(equalTo: orderView.trailingAnchor, constant: -8),
            
            totalWeightLabel.topAnchor.constraint(equalTo: deliveryAddressLabel.bottomAnchor, constant: 6),
            totalWeightLabel.leadingAnchor.constraint(equalTo: geoImageView.trailingAnchor, constant: 4),
            totalWeightLabel.trailingAnchor.constraint(equalTo: orderView.trailingAnchor, constant: -8),
            
            calendarImageView.widthAnchor.constraint(equalToConstant: 18),
            calendarImageView.heightAnchor.constraint(equalToConstant: 18),
            calendarImageView.topAnchor.constraint(equalTo: orderNumberLabel.bottomAnchor, constant: 4),
            calendarImageView.leadingAnchor.constraint(equalTo: orderView.leadingAnchor, constant: 8),
            calendarImageView.trailingAnchor.constraint(equalTo: orderDateLabel.leadingAnchor, constant: -5),
            
            
            storeImageView.widthAnchor.constraint(equalToConstant: 18),
            storeImageView.heightAnchor.constraint(equalToConstant: 18),
            storeImageView.topAnchor.constraint(equalTo: calendarImageView.bottomAnchor, constant: 4),
            storeImageView.leadingAnchor.constraint(equalTo: orderView.leadingAnchor, constant: 8),
            storeImageView.trailingAnchor.constraint(equalTo: storeNameLabel.leadingAnchor, constant: -5),
            
            geoImageView.widthAnchor.constraint(equalToConstant: 18),
            geoImageView.heightAnchor.constraint(equalToConstant: 18),
            geoImageView.topAnchor.constraint(equalTo: storeImageView.bottomAnchor, constant: 4),
            geoImageView.leadingAnchor.constraint(equalTo: orderView.leadingAnchor, constant: 8),
            geoImageView.trailingAnchor.constraint(equalTo: deliveryAddressLabel.leadingAnchor, constant: -5),
            
            weightImageView.widthAnchor.constraint(equalToConstant: 24),
            weightImageView.heightAnchor.constraint(equalToConstant: 24),
            weightImageView.topAnchor.constraint(equalTo: geoImageView.bottomAnchor, constant: 4),
            weightImageView.leadingAnchor.constraint(equalTo: orderView.leadingAnchor, constant: 8),
            weightImageView.trailingAnchor.constraint(equalTo: totalWeightLabel.leadingAnchor, constant: -5),
            
        ])
    }
}

extension UIColor {
    public class var random: UIColor {
        return UIColor(red: CGFloat(drand48()),
                       green: CGFloat(drand48()),
                       blue: CGFloat(drand48()), alpha: 1.0)
    }
}

extension OrderTableViewCell {
    func configure(with order: OrderModel) {
        orderNumberLabel.text = "Замовлення №\(order.orderNumber)"
        orderDateLabel.text = "Дата замовлення: \(order.orderDate)"
        deliveryAddressLabel.text = "Адреса: \(order.deliveryAddress)"
        storeNameLabel.text = "Магазин: \(order.storeName)"
        totalWeightLabel.text = "Вага: \(order.totalWeight) кг."
    }
}
