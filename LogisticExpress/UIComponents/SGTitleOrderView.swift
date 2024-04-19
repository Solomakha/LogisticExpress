import Foundation
import UIKit

class SGTitleOrderView: UIView {
    
    let titleLabel = UILabel()
    let orderImageView = UIImageView(frame: CGRectMake(10, 10, 18, 18))
    let stroke = UIView()
    
    // Создаем изображение для кнопки
    let buttonImage = UIImage(named: "reload")
    
    // Создаем кнопку и устанавливаем изображение
    let reloadDataButton = UIButton(type: .custom)
    // Устанавливаем размер кнопки
    let buttonSize = CGSize(width: 20, height: 20)
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(titleOrderView)
        setupConstraints()

        orderImageView.layer.masksToBounds = false
        orderImageView.clipsToBounds = true
        orderImageView.image =  UIImage(named: "clipboard")
        
        titleLabel.text = "Замовлення"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        stroke.translatesAutoresizingMaskIntoConstraints = false
        stroke.backgroundColor = .gray

        reloadDataButton.setImage(buttonImage, for: .normal)
        // Добавляем обработчик нажатия на кнопку
        //reloadDataButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        
        
    }
    
    lazy var titleOrderView: UIView = {
        let titleOrderView = UIView()
    
        titleOrderView.backgroundColor = .clear
        titleOrderView.layer.cornerRadius = 10
        titleOrderView.translatesAutoresizingMaskIntoConstraints = false

        titleOrderView.addSubview(orderImageView)
        titleOrderView.addSubview(titleLabel)
        titleOrderView.addSubview(stroke)
        titleOrderView.addSubview(reloadDataButton)
        
        reloadDataButton.frame = CGRect(x: titleOrderView.center.x + 335, y: 10, width: buttonSize.width, height: buttonSize.height)
        
        return titleOrderView
    }()
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleOrderView.topAnchor.constraint(equalTo: self.topAnchor),
            titleOrderView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleOrderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleOrderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleOrderView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            titleLabel.topAnchor.constraint(equalTo: titleOrderView.topAnchor, constant: 5),
            titleLabel.leftAnchor.constraint(equalTo: orderImageView.rightAnchor, constant: 6),
            
            stroke.centerXAnchor.constraint(equalTo: titleOrderView.centerXAnchor),
            stroke.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            stroke.leftAnchor.constraint(equalTo: titleOrderView.leftAnchor, constant: 10),
            stroke.rightAnchor.constraint(equalTo: titleOrderView.rightAnchor, constant: -10),
            stroke.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    @objc func buttonTapped() {
        print("Кнопка была нажата")
        // Ваш код обработки нажатия на кнопку
    }
}

