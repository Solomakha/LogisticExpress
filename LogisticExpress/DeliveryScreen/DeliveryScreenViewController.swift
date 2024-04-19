//
//  SecondScreenViewController.swift
//  LogisticsExpress
//
//  Created by Admin on 04.02.2024.
//

import UIKit

class DeliveryScreenViewController: UIViewController {

    weak var coordinator: DeliveryScreenCoordinator?
    
    let items = ["Активні","Виконані"]
    
    lazy var segmentedControl: SGSegmentedControl = {
        return SGSegmentedControl(items: items)
    }()
    
    var tableView: UITableView!
       let data = ["Строка 1", "Строка 2", "Строка 3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Відправки"
        view.backgroundColor = .white
        setupSegmentControl()
        setupTableView()
        makeConstraints()
    }
    
    func setupSegmentControl() {
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.segmentedControl.addTarget(self, action: #selector(changeColor), for: .valueChanged)
        
        view.addSubview(segmentedControl)
    }
    
    func setupTableView() {
        // Создаем UITableView
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell") // Регистрируем ячейку
        
        // Добавляем UITableView к родительскому представлению
        view.addSubview(tableView)
        
        // Устанавливаем ограничения
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc fileprivate func changeColor() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            self.view.backgroundColor = .green
            print("Green")
        case 1:
            self.view.backgroundColor = .blue
            print("Blue")
        default:
            break
        }
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([

            segmentedControl.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            segmentedControl.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
            segmentedControl.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)

        ])
    }

}

extension DeliveryScreenViewController: UITableViewDataSource, UITableViewDelegate{
    // MARK: - UITableViewDataSource Methods
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // Возвращаем количество ячеек в таблице
            return data.count
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = data[indexPath.row]
            return cell
        }

        // MARK: - UITableViewDelegate Methods
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // Обработка нажатия на ячейку
            print("Selected row \(indexPath.row)")
        }
    
}
