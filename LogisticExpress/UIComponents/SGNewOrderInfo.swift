import Foundation
import UIKit

class SGNewOrderInfo: UIView {
    
    var dateString: String = ""
    var newOrderString: String = ""
    
    let dateTimeLabel = UILabel()
    let boxImageView = UIImageView(frame: CGRectMake(10, 30, 30, 30))
    
    let newOrderTextLabel = UILabel()
    let numberNewOrderLabel = UILabel()
    
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
        addSubview(dataView)
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
        //-------
        newOrderTextLabel.text = "Нових замовлень"
        newOrderTextLabel.textAlignment = .left
        newOrderTextLabel.font = UIFont.boldSystemFont(ofSize: 16)
        newOrderTextLabel.textColor = .blue
        newOrderTextLabel.translatesAutoresizingMaskIntoConstraints = false
        newOrderTextLabel.sizeToFit()//If required
        //-------
        numberNewOrderLabel.text = newOrderString
        numberNewOrderLabel.textAlignment = .left
        numberNewOrderLabel.font = UIFont.boldSystemFont(ofSize: 24)
        numberNewOrderLabel.textColor = .blue
        numberNewOrderLabel.translatesAutoresizingMaskIntoConstraints = false
        numberNewOrderLabel.sizeToFit()//If required
    }
    
    lazy var dataView: UIView = {
        let dataView = UIView()
        dataView.backgroundColor = UIColor(red: 0, green: 0, blue: 255, alpha: 0.1)
        dataView.layer.cornerRadius = 10
        dataView.layer.borderWidth =  0.1
        dataView.layer.borderColor = UIColor.lightGray.cgColor
        dataView.translatesAutoresizingMaskIntoConstraints = false
        dataView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        dataView.addSubview(dateTimeLabel)
        dataView.addSubview(boxImageView)
        dataView.addSubview(newOrderTextLabel)
        dataView.addSubview(numberNewOrderLabel)
        return dataView
    }()
    
    func updateNumberOfOrders(_ numberOfOrders: Int) {
        // Обновите значение в вашем представлении, например:
        numberNewOrderLabel.text = "\(numberOfOrders)"
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            dataView.topAnchor.constraint(equalTo: self.topAnchor),
            dataView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            dataView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            dataView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            dataView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            dateTimeLabel.topAnchor.constraint(equalTo: dataView.topAnchor, constant: 5),
            dateTimeLabel.leftAnchor.constraint(equalTo: dataView.leftAnchor, constant: 12),
            
            newOrderTextLabel.topAnchor.constraint(equalTo: dateTimeLabel.bottomAnchor, constant: 7),
            newOrderTextLabel.leftAnchor.constraint(equalTo: boxImageView.rightAnchor, constant: 7),
            
            numberNewOrderLabel.centerYAnchor.constraint(equalTo: dataView.centerYAnchor),
            numberNewOrderLabel.trailingAnchor.constraint(equalTo: dataView.trailingAnchor, constant: -10)
        ])
    }
}
