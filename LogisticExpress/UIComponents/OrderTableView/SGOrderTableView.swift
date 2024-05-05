//
//  SGOrderTableView.swift
//  LogisticExpress
//
//  Created by Дмитрий Соломаха on 04.04.2024.
//

import Foundation
import UIKit

class SGOrderTableView: UIView {
    weak var orderDelegate: SGOrderTableViewDelegate?
    var tableView: UITableView!
    
    var numberOfCells: Int = 0
    var orders: [OrderModel] = []
    weak var navigationController: UINavigationController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTableView()
        setupConstraints()
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: bounds, style: .plain)
        addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Регистрируем ячейку для использования в таблице
        tableView.register(OrderTableViewCell.self, forCellReuseIdentifier: "OrderCell")
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 65))
        footerView.addSubview(orderButton)
        
        tableView.tableFooterView = footerView
        
        orderButton.translatesAutoresizingMaskIntoConstraints = false
        orderButton.centerXAnchor.constraint(equalTo: footerView.centerXAnchor).isActive = true
        orderButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        orderButton.leadingAnchor.constraint(equalTo: footerView.leadingAnchor).isActive = true
        orderButton.trailingAnchor.constraint(equalTo: footerView.trailingAnchor).isActive = true
        orderButton.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 10).isActive = true
        orderButton.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: -5).isActive = true
        
        orderButton.addTarget(self, action: #selector(planingButtonTapped), for: .touchUpInside)
        
        footerView.bottomAnchor.constraint(equalTo: tableView.bottomAnchor, constant: -10).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.frame = bounds
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    @objc func reloadData() {
        // Обновляем данные в массиве заказов
        // Генерируем случайное количество ячеек, например, от 5 до 15
        numberOfCells = Int.random(in: 2...5)
        
        generateOrders()
        
        // Перезагружаем таблицу
        tableView.reloadData()
        
        // Передаем обновленное количество заказов делегату
           orderDelegate?.didUpdateNumberOfOrders(orders.count)
    }
    
    private func generateOrders() {
        orders.removeAll() // Очищаем массив заказов
        
        // Генерируем случайные заказы и добавляем их в массив
        for _ in 0..<numberOfCells {
            let randomOrder = OrderGenerator.generateRandomOrder()
            orders.append(randomOrder)
        }
    }
    
    @objc func planingButtonTapped() {
        let shopCoordinates = orders.map { $0.shopCoordinates }
        orderDelegate?.receivedCoordinates(shopCoordinates)
        
        let allOrders = orders
        orderDelegate?.receivedData(allOrders)
    }
    
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
    
    func clearData() {
        // Обход всех секций в таблице
        for sectionIndex in 0..<tableView.numberOfSections {
            // Обход всех строк в каждой секции
            for rowIndex in 0..<tableView.numberOfRows(inSection: sectionIndex) {
                // Получаем indexPath для текущей ячейки
                let indexPath = IndexPath(row: rowIndex, section: sectionIndex)
                // Получаем ссылку на ячейку по indexPath
                if let cell = tableView.cellForRow(at: indexPath) {
                    // Очищаем содержимое ячейки
                    cell.textLabel?.text = nil // Пример для ячейки с текстовым меткой
                    // Если ваша ячейка содержит другие элементы, то их также нужно очистить
                    // Например, если у вас есть изображения, то можно установить их в nil
                    // cell.imageView?.image = nil
                }
            }
        }
    }
    
}

protocol SGOrderTableViewDelegate: AnyObject {
    func didSelectOrder(at indexPath: IndexPath, withData data: OrderModel)
    func receivedCoordinates(_ coordinates: [(Double, Double)])
    func receivedData(_ data: [OrderModel])
    func didUpdateNumberOfOrders(_ numberOfOrders: Int)
}

extension SGOrderTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Генерируем случайное количество ячеек, например, от 5 до 15
        return numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Проверяем, есть ли уже сгенерированные заказы в массиве orders
        if indexPath.row < orders.count {
            // Если заказ уже сгенерирован, используем его из массива
            let order = orders[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderTableViewCell
            // Устанавливаем данные заказа в ячейку
            cell.configure(with: order)
            return cell
        } else {
            // Если заказ еще не сгенерирован, генерируем новый и добавляем в массив orders
            let randomOrder = OrderGenerator.generateRandomOrder()
            orders.append(randomOrder) // Добавляем заказ в массив
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderTableViewCell
            // Устанавливаем данные заказа в ячейку
            cell.configure(with: randomOrder)
            return cell
        }
    }
    
    // Добавьте этот метод, который будет вызываться при выборе ячейки
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedOrder = orders[indexPath.row] // Получаем выбранный заказ из массива
        orderDelegate?.didSelectOrder(at: indexPath, withData: selectedOrder)
    }
    
}
