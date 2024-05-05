//
//  TruckViewController.swift
//  LogisticExpress
//
//  Created by Дмитрий Соломаха on 24.04.2024.
//

import UIKit

class TruckViewController: UIViewController {
    
    let carSpecs = [
        "Дизель",
        "Механіка",
        "Сидінь 3",
        "11,4 л/100 км.",
        "2194 кг.",
        "Висота в.в. 2,025 м."
    ]
    let imageName = ["gas","gearbox","car-seat","fuel","kilogram","height"]
    
    let titleLabel = UILabel()
    let orderImageView = UIImageView(frame: CGRectMake(10, 2, 30, 30))
    let stroke = UIView()
    
    let carImageView : UIImageView = {
        let imageView = UIImageView()
        //imageView.frame = CGRect(x:  0, y:  0, width:  0, height:  300)
        imageView.image = UIImage(named: "ford-transit")
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let logoImageView : UIImageView = {
        let imageView = UIImageView()
        //imageView.frame = CGRect(x:  0, y:  0, width:  0, height:  300)
        imageView.image = UIImage(named: "Ford-Logo")
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // Создание UICollectionView
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    lazy var titleOrderView: UIView = {
        let titleOrderView = UIView()
        titleOrderView.backgroundColor = .clear
        titleOrderView.layer.cornerRadius = 10
        titleOrderView.translatesAutoresizingMaskIntoConstraints = false
        titleOrderView.addSubview(orderImageView)
        titleOrderView.addSubview(titleLabel)
        titleOrderView.addSubview(stroke)
        return titleOrderView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(stackView)
        stackView.addArrangedSubview(logoImageView)
        stackView.addArrangedSubview(carImageView)
        stackView.addArrangedSubview(titleOrderView)
        stackView.addArrangedSubview(collectionView)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        orderImageView.layer.masksToBounds = false
        orderImageView.clipsToBounds = true
        orderImageView.image =  UIImage(named: "book")
        
        titleLabel.text = "Специфікація"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stroke.translatesAutoresizingMaskIntoConstraints = false
        stroke.backgroundColor = .gray
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            logoImageView.topAnchor.constraint(equalTo: stackView.topAnchor),
            logoImageView.centerXAnchor.constraint(equalTo: stackView.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 50),
            logoImageView.widthAnchor.constraint(equalToConstant: 70),
            
            carImageView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 5),
            carImageView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            carImageView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            carImageView.heightAnchor.constraint(equalToConstant: 250),
            
            titleOrderView.topAnchor.constraint(equalTo: carImageView.bottomAnchor, constant: 10),
            titleOrderView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 10),
            titleOrderView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -10),
            
            titleLabel.topAnchor.constraint(equalTo: titleOrderView.topAnchor, constant: 5),
            titleLabel.leftAnchor.constraint(equalTo: orderImageView.rightAnchor, constant: 6),
            
            stroke.centerXAnchor.constraint(equalTo: titleOrderView.centerXAnchor),
            stroke.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            stroke.leftAnchor.constraint(equalTo: titleOrderView.leftAnchor, constant: 10),
            stroke.rightAnchor.constraint(equalTo: titleOrderView.rightAnchor, constant: -10),
            stroke.heightAnchor.constraint(equalToConstant: 1),
            
            // Constraints for UICollectionView
            collectionView.heightAnchor.constraint(equalToConstant: 250), // Set a specific height for the collection view
            collectionView.topAnchor.constraint(equalTo: stroke.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -10)
        ])
    }
}

extension TruckViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        cell.backgroundColor = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 0.08)
        
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 0.2
        cell.layer.borderColor = UIColor.gray.cgColor
        
        // Clear existing content
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        // Create and add image view
        let imageSize: CGFloat = 40 // Customize image size as needed
        let imageView = UIImageView(frame: CGRect(x: (cell.contentView.frame.width - imageSize) / 2, y: (cell.contentView.frame.height - imageSize) / 4, width: imageSize, height: imageSize)) // Adjust frame as needed
        imageView.image = UIImage(named: imageName[indexPath.item]) // Use image name from the array
        imageView.contentMode = .scaleAspectFit
        cell.contentView.addSubview(imageView)
        
        // Create and add label
        let label = UILabel(frame: CGRect(x: 0, y: cell.contentView.frame.height - 50, width: cell.contentView.frame.width - 5, height: 50)) // Adjust frame as needed
        label.text = carSpecs[indexPath.item] // You can customize label text as needed
        label.textAlignment = .center
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 16) // Adjust font size as needed
        cell.contentView.addSubview(label)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Calculate the size based on your requirements
        let cellWidth: CGFloat = (collectionView.frame.width - 20) / 3 // Subtracting the spacing between cells
        let cellHeight: CGFloat = 120 // Fixed height for each cell
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
