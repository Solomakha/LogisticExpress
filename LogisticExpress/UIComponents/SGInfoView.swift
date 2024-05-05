import Foundation
import UIKit

class SGInfoView: UIView {
    
    var storageNumber: String = ""
    var truckNumber: String = ""
    var weightNumber: String = ""
    
    let storageNumberLabel = UILabel()
    let truckNumberLabel = UILabel()
    let weightNumberLabel = UILabel()
    
    let storageImageView = UIImageView(frame: CGRectMake(32.5, 15, 35, 35))
    let truckImageView = UIImageView(frame: CGRectMake(50, 15, 45, 45))
    let weightImageView = UIImageView(frame: CGRectMake(27.5, 15, 45, 45))
    
    let storageView = UIView()
    let truckView = UIView()
    let dataView3 = UIView()
    
    let stroke = UIView()
    let stroke2 = UIView()
    
    init(storageNumber:String, truckNumber:String, weightNumber:String) {
        self.storageNumber = storageNumber
        self.truckNumber = truckNumber
        self.weightNumber = weightNumber
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(infoStackView)
        setupConstraints()
        
        storageView.layer.cornerRadius = 10
        storageView.layer.borderWidth =  0.1
        storageView.layer.borderColor = UIColor.lightGray.cgColor
        storageView.translatesAutoresizingMaskIntoConstraints = false
        storageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        storageNumberLabel.text = storageNumber
        storageNumberLabel.textAlignment = .center
        storageNumberLabel.textColor = .black
        storageNumberLabel.font = UIFont.boldSystemFont(ofSize: 15)
        storageNumberLabel.translatesAutoresizingMaskIntoConstraints = false

        truckNumberLabel.text = truckNumber
        truckNumberLabel.textAlignment = .center
        truckNumberLabel.textColor = .black
        truckNumberLabel.font = UIFont.boldSystemFont(ofSize: 15)
        truckNumberLabel.translatesAutoresizingMaskIntoConstraints = false

        weightNumberLabel.text = weightNumber
        weightNumberLabel.textAlignment = .center
        weightNumberLabel.textColor = .black
        weightNumberLabel.font = UIFont.boldSystemFont(ofSize: 15)
        weightNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stroke.translatesAutoresizingMaskIntoConstraints = false
        stroke.backgroundColor = .gray
        stroke2.translatesAutoresizingMaskIntoConstraints = false
        stroke2.backgroundColor = .gray
        
        truckView.layer.cornerRadius = 10
        truckView.layer.borderWidth =  0.1
        truckView.layer.borderColor = UIColor.lightGray.cgColor
        truckView.translatesAutoresizingMaskIntoConstraints = false
        truckView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        dataView3.layer.cornerRadius = 10
        dataView3.layer.borderWidth =  0.1
        dataView3.layer.borderColor = UIColor.lightGray.cgColor
        dataView3.translatesAutoresizingMaskIntoConstraints = false
        dataView3.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        storageImageView.layer.masksToBounds = false
        storageImageView.clipsToBounds = true
        storageImageView.image =  UIImage(named: "warehouse")
        //-------
        truckImageView.layer.masksToBounds = false
        truckImageView.clipsToBounds = true
        truckImageView.image =  UIImage(named: "truck")
        //-------
        weightImageView.layer.masksToBounds = false
        weightImageView.clipsToBounds = true
        weightImageView.image =  UIImage(named: "weight-3")
        
    }
    
    lazy var infoStackView: UIStackView = {
        let infoStackView = UIStackView()
        infoStackView.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        infoStackView.isLayoutMarginsRelativeArrangement = true
        // Установить положение компонентов внутри Stack
        infoStackView.axis = .horizontal
        infoStackView.alignment = .center
        infoStackView.distribution = .fillProportionally
       // infoStackView.spacing = 10
        infoStackView.backgroundColor = .white
        infoStackView.layer.cornerRadius = 10
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.layer.shadowColor = UIColor.black.cgColor
        infoStackView.layer.shadowOpacity = 0.2
        infoStackView.layer.shadowOffset = CGSize(width: 0, height: 2)
        infoStackView.layer.shadowRadius = 5
        infoStackView.layer.borderWidth = 0.2
        infoStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        infoStackView.addArrangedSubview(storageView)
        infoStackView.addArrangedSubview(stroke)
        infoStackView.addArrangedSubview(truckView)
        infoStackView.addArrangedSubview(stroke2)
        infoStackView.addArrangedSubview(dataView3)

        storageView.addSubview(storageNumberLabel)
        storageView.addSubview(storageImageView)
        truckView.addSubview(truckNumberLabel)
        truckView.addSubview(truckImageView)
        dataView3.addSubview(weightNumberLabel)
        dataView3.addSubview(weightImageView)
        
        return infoStackView
    }()
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            infoStackView.topAnchor.constraint(equalTo: self.topAnchor),
            infoStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            infoStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            infoStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            infoStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            storageView.centerXAnchor.constraint(equalTo: infoStackView.centerXAnchor),
            storageView.topAnchor.constraint(equalTo: infoStackView.topAnchor, constant: 5),
            storageView.leftAnchor.constraint(equalTo: infoStackView.leftAnchor, constant: 5),
            storageView.rightAnchor.constraint(equalTo: stroke.leftAnchor, constant: -5),
            storageView.bottomAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: -5),

            stroke.widthAnchor.constraint(equalToConstant: 0.25),
            stroke.topAnchor.constraint(equalTo: infoStackView.topAnchor, constant: 20),
            stroke.bottomAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: -20),
            stroke.leftAnchor.constraint(equalTo: storageView.rightAnchor, constant: 5),
            stroke.rightAnchor.constraint(equalTo: truckView.leftAnchor, constant: -5),
            
            truckView.centerXAnchor.constraint(equalTo: infoStackView.centerXAnchor),
            truckView.centerYAnchor.constraint(equalTo: infoStackView.centerYAnchor),
            truckView.topAnchor.constraint(equalTo: infoStackView.topAnchor, constant: 5),
            truckView.leftAnchor.constraint(equalTo: stroke.rightAnchor, constant: 5),
            truckView.rightAnchor.constraint(equalTo: stroke2.leftAnchor, constant: -5),
            truckView.bottomAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: -5),
            
            stroke2.widthAnchor.constraint(equalToConstant: 0.5),
            stroke2.topAnchor.constraint(equalTo: infoStackView.topAnchor, constant: 20),
            stroke2.bottomAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: -20),
            stroke2.leftAnchor.constraint(equalTo: truckView.rightAnchor, constant: 5),
            stroke2.rightAnchor.constraint(equalTo: dataView3.leftAnchor, constant: -5),
            
            dataView3.centerXAnchor.constraint(equalTo: infoStackView.centerXAnchor),
            dataView3.topAnchor.constraint(equalTo: infoStackView.topAnchor, constant: 5),
            dataView3.leftAnchor.constraint(equalTo: stroke2.rightAnchor, constant: 5),
            dataView3.rightAnchor.constraint(equalTo: infoStackView.rightAnchor, constant: -5),
            dataView3.bottomAnchor.constraint(equalTo: infoStackView.bottomAnchor, constant: -5),
            
            storageNumberLabel.centerXAnchor.constraint(equalTo: storageView.centerXAnchor),
//            storageNumberLabel.topAnchor.constraint(equalTo: storageView.topAnchor, constant: 5),
            storageNumberLabel.bottomAnchor.constraint(equalTo: storageView.bottomAnchor, constant: -15),
            storageNumberLabel.rightAnchor.constraint(equalTo: storageView.rightAnchor, constant: -5),
            storageNumberLabel.leftAnchor.constraint(equalTo: storageView.leftAnchor, constant: 5),

            truckNumberLabel.bottomAnchor.constraint(equalTo: truckView.bottomAnchor, constant: -15),
            truckNumberLabel.rightAnchor.constraint(equalTo: truckView.rightAnchor, constant: -5),
            truckNumberLabel.leftAnchor.constraint(equalTo: truckView.leftAnchor, constant: 5),
            
            weightNumberLabel.bottomAnchor.constraint(equalTo: dataView3.bottomAnchor, constant: -15),
            weightNumberLabel.rightAnchor.constraint(equalTo: dataView3.rightAnchor, constant: -5),
            weightNumberLabel.leftAnchor.constraint(equalTo: dataView3.leftAnchor, constant: 5),
            
            
            
//            newOrderTextLabel.topAnchor.constraint(equalTo: storageNumberLabel.bottomAnchor, constant: 7),
//            newOrderTextLabel.leftAnchor.constraint(equalTo: storageImageView.rightAnchor, constant: 7),
//            
//            numberNewOrderLabel.centerYAnchor.constraint(equalTo: dataView.centerYAnchor),
//            numberNewOrderLabel.trailingAnchor.constraint(equalTo: dataView.trailingAnchor, constant: -10)
        ])
    }
}
