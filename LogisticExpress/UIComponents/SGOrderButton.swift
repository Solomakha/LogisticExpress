import UIKit


class SGOrderButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let orderButton : UIButton = {
        let button = UIButton(type: .system)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Побудувати маршрут", for: .normal)
        button.backgroundColor = .red
        
        // Set button properties
        button.tintColor = .white
        
        button.layer.cornerRadius = 17
        
        // Add shadow to the button
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.06).cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 8
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        return button
    }()
    
    private func setupButton() {
        addSubview(orderButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            orderButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            orderButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            orderButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            orderButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            orderButton.topAnchor.constraint(equalTo: self.topAnchor),
            orderButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}
