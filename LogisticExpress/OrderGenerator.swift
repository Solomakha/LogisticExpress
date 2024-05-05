//
//  OrderGenerator.swift
//  LogisticExpress
//
//  Created by Дмитрий Соломаха on 08.04.2024.
//

import Foundation

class OrderGenerator {
    
    // Создаем функцию для генерации случайного магазина
    func getRandomShop() -> (ShopData, (Double, Double)) {
        let randomIndex = Int.random(in: 0..<streetNamesKharkiv.count)
        let randomShop = streetNamesKharkiv[randomIndex]
        
        let shopName = randomShop["Магазин"] as? String ?? ""
        let shopAddress = "\(randomShop["вул."] ?? "") \(randomShop["буд."] ?? "")"
        
        guard let coordinates = randomShop["координати"] as? (Double, Double) else {
            fatalError("Координаты магазина не найдены")
        }
        
        // Создаем экземпляр ShopData
        let shopData = ShopData(name: shopName, address: shopAddress, coordinates: coordinates)
        
        // Возвращаем ShopData и координаты
        return (shopData, coordinates)
    }
    
    // Метод для генерации случайного номера заказа
    static func generateOrderNumber() -> String {
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let numbers = "0123456789"
        
        let prefix = String((0..<2).map{ _ in letters.randomElement()! })
        let middle = String((0..<8).map{ _ in numbers.randomElement()! })
        let suffix = String((0..<2).map{ _ in letters.randomElement()! })
        
        return "\(prefix)\(middle)\(suffix)"
    }
    
    // Метод для генерации случайной даты заказа
    static func generateOrderDate() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        
        // Установка формата вывода даты и времени
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        // Получение строки с текущей датой и временем
        let formattedDate = dateFormatter.string(from: currentDate)
        
        return "\(formattedDate)"
    }
    
    // Метод для генерации случайного адреса доставки
    static func generateDeliveryAddress() -> String {
        // Создаем экземпляр класса OrderGenerator
        let orderGenerator = OrderGenerator()
        
        // Пример использования метода
        let (shopData, _) = orderGenerator.getRandomShop()
        
        // Возвращаем строку с данными о случайном магазине и его адресе
        return "\(shopData.address)"
    }
    
    // Метод для генерации случайного названия магазина
    static func generateStoreName() -> String {
        // Создаем экземпляр класса OrderGenerator
        let orderGenerator = OrderGenerator()
        
        // Пример использования метода
        let (shopData, _) = orderGenerator.getRandomShop()
        return "\(shopData.name)"
    }
    
    // Метод для генерации случайного названия магазина
    static func generateShopCoordinate() -> (Double, Double) {
        // Создаем экземпляр класса OrderGenerator
        let orderGenerator = OrderGenerator()
        
        // Пример использования метода
        let (_, coordinates) = orderGenerator.getRandomShop()
        
        return coordinates
    }
    
   
    
    
    static func generateRandomOrder() -> OrderModel {
        let (_, products) = MainScreenViewController.generateOrders()
        let orderDetailVC = OrderDetailsViewController()

        // Вычисляем общий вес заказа
        var totalWeight = 0.0
        for product in products {
            totalWeight += Double(product.quantity)
        }

        return OrderModel(orderNumber: generateOrderNumber(),
                          orderDate: generateOrderDate(),
                          deliveryAddress: generateDeliveryAddress(),
                          storeName: generateStoreName(),
                          totalWeight: Int(totalWeight), // Передаем общий вес
                          shopCoordinates: generateShopCoordinate(),
                          productsText: orderDetailVC.formatProductsText(from: products))
    }
}

