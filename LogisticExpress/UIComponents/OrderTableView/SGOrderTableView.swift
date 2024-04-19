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
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60))
        footerView.addSubview(orderButton)
        
        tableView.tableFooterView = footerView
        
        orderButton.translatesAutoresizingMaskIntoConstraints = false
        orderButton.centerXAnchor.constraint(equalTo: footerView.centerXAnchor).isActive = true
        orderButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        orderButton.leadingAnchor.constraint(equalTo: footerView.leadingAnchor).isActive = true
        orderButton.trailingAnchor.constraint(equalTo: footerView.trailingAnchor).isActive = true
        orderButton.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 10).isActive = true
        orderButton.bottomAnchor.constraint(equalTo: footerView.bottomAnchor).isActive = true
        
        orderButton.addTarget(self, action: #selector(routePlanningButtonTapped), for: .touchUpInside)
        
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
        orders = (0..<numberOfCells).map { _ in OrderGenerator.generateRandomOrder() }
        // Перезагружаем таблицу
        tableView.reloadData()
    }
    
    @objc func routePlanningButtonTapped() {
        let shopCoordinates = orders.map { $0.shopCoordinates }
        orderDelegate?.receivedCoordinates(shopCoordinates)
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
}

protocol SGOrderTableViewDelegate: AnyObject {
    func didSelectOrder(at indexPath: IndexPath, withData data: OrderModel)
    func receivedCoordinates(_ coordinates: [(Double, Double)])
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
