//
//  SimplexMethod.swift
//  LogisticExpress
//
//  Created by Дмитро Соломаха on 20.03.2024.
//

import Foundation

class TransportationSolver {
    // Функция для решения транспортной задачи методом потенциалов
    func solveTransportProblem(supply supplyConst: [Double], demand demandConst: [Double], costs: [[Double]]) -> ([[Double]], Double) {
        var supply = supplyConst
        var demand = demandConst
        var result = Array(repeating: Array(repeating: 0.0, count: demand.count), count: supply.count)
        var u = Array(repeating: 0.0, count: supply.count)
        var v = Array(repeating: 0.0, count: demand.count)
        
        // Начальное приближение
        for i in 0..<supply.count {
            for j in 0..<demand.count {
                let x = min(supply[i], demand[j])
                result[i][j] = x
                supply[i] -= x
                demand[j] -= x
            }
        }
        
        // Расчет потенциалов u и v
        while true {
            var done = true
            for i in 0..<supply.count {
                for j in 0..<demand.count {
                    if result[i][j] > 0 {
                        if u[i] == 0 && v[j] == 0 {
                            continue
                        }
                        if u[i] == 0 {
                            u[i] = costs[i][j] - v[j]
                            done = false
                        } else if v[j] == 0 {
                            v[j] = costs[i][j] - u[i]
                            done = false
                        }
                    }
                }
            }
            if done {
                break
            }
        }
        
        // Проверка на оптимальность и корректировка решения
        while true {
            var minDelta: Double?
            var deltaFound = false
            
            for i in 0..<supply.count {
                for j in 0..<demand.count {
                    if result[i][j] == 0 {
                        let delta = u[i] + v[j] - costs[i][j]
                        if delta > 0 {
                            if let existingMinDelta = minDelta {
                                minDelta = min(existingMinDelta, delta)
                            } else {
                                minDelta = delta
                            }
                            deltaFound = true
                        }
                    }
                }
            }
            
            if !deltaFound {
                break
            }
            
            for i in 0..<supply.count {
                for j in 0..<demand.count {
                    if result[i][j] == 0 {
                        let delta = u[i] + v[j] - costs[i][j]
                        if delta == minDelta {
                            result[i][j] = min(supply[i], demand[j])
                            supply[i] -= result[i][j]
                            demand[j] -= result[i][j]
                        }
                    }
                }
            }
        }
        
        // Расчет стоимости перевозки
        var totalCost = 0.0
        for i in 0..<supplyConst.count {
            for j in 0..<demandConst.count {
                totalCost += result[i][j] * costs[i][j]
            }
        }
        
        return (result, totalCost)
    }
    
    // Функция для добавления фиктивного поставщика или потребителя для балансировки задачи
    func balanceTransportProblem(supply: inout [Double], demand: inout [Double], costs: inout [[Double]]) {
        let totalSupply = supply.reduce(0, +)
        let totalDemand = demand.reduce(0, +)
        
        if totalSupply > totalDemand {
            // Добавляем фиктивного потребителя
            let difference = totalSupply - totalDemand
            demand.append(difference)
            for i in 0..<costs.count {
                costs[i].append(0.0) // Стоимость перевозки к фиктивному потребителю равна 0
            }
        } else if totalDemand > totalSupply {
            // Добавляем фиктивного поставщика
            let difference = totalDemand - totalSupply
            supply.append(difference)
            let newCostsRow = Array(repeating: 0.0, count: demand.count)
            costs.append(newCostsRow) // Стоимость перевозки от фиктивного поставщика равна 0
        }
    }
    
    // Функция для решения транспортной задачи методом северо-западного угла
    func northwestCornerMethod(_ costs: [[Double]], supplies: [Double], demands: [Double]) -> [[Double]]? {
        let numSources = supplies.count
        let numDestinations = demands.count
        var allocation = Array(repeating: Array(repeating: 0.0, count: numDestinations), count: numSources)
        var supply = supplies
        var demand = demands
        
        var row = 0
        var col = 0
        
        while row < numSources && col < numDestinations {
            if supply[row] < demand[col] {
                allocation[row][col] = supply[row]
                demand[col] -= supply[row]
                supply[row] = 0
                row += 1
            } else {
                allocation[row][col] = demand[col]
                supply[row] -= demand[col]
                demand[col] = 0
                col += 1
            }
        }
        
        return allocation
    }
    
    // Функция для вычисления относительных стоимостей
    func computeRelativeCosts(_ costs: [[Double]], allocation: [[Double]]) -> [Double] {
        let numSources = costs.count
        let numDestinations = costs[0].count
        var relativeCosts = Array(repeating: Double.infinity, count: numSources * numDestinations)
        
        for i in 0..<numSources {
            for j in 0..<numDestinations {
                if allocation[i][j] == 0 {
                    relativeCosts[i * numDestinations + j] = costs[i][j]
                }
            }
        }
        
        return relativeCosts
    }
    
    // Функция для решения транспортной задачи методом симплекса
    func simplexMethod(_ costs: [[Double]], supplies: [Double], demands: [Double]) -> [[Double]]? {
        let numSources = supplies.count
        let numDestinations = demands.count
        var allocation = northwestCornerMethod(costs, supplies: supplies, demands: demands)
        var relativeCosts = computeRelativeCosts(costs, allocation: allocation!)
        
        while let minCostIndex = relativeCosts.firstIndex(where: { $0 < 0 }) {
            let row = minCostIndex / numDestinations
            let col = minCostIndex % numDestinations
            
            var deltas = Array(repeating: Double.infinity, count: numSources * numDestinations)
            var visited = Array(repeating: false, count: numSources * numDestinations)
            var queue = [minCostIndex]
            
            while !queue.isEmpty {
                let current = queue.removeFirst()
                visited[current] = true
                
                let currentRow = current / numDestinations
                let currentCol = current % numDestinations
                
                for i in 0..<numSources {
                    let nextIndex = i * numDestinations + currentCol
                    
                    if !visited[nextIndex] {
                        deltas[nextIndex] = relativeCosts[nextIndex] - relativeCosts[current] + costs[i][currentCol]
                        queue.append(nextIndex)
                    }
                }
                
                for j in 0..<numDestinations {
                    let nextIndex = currentRow * numDestinations + j
                    
                    if !visited[nextIndex] {
                        deltas[nextIndex] = relativeCosts[nextIndex] - relativeCosts[current] - costs[currentRow][j]
                        queue.append(nextIndex)
                    }
                }
            }
            
            guard let minDeltaIndex = deltas.firstIndex(where: { $0 != Double.infinity }) else {
                return nil
            }
            
            let minDelta = deltas[minDeltaIndex]
            let minDeltaRow = minDeltaIndex / numDestinations
            let minDeltaCol = minDeltaIndex % numDestinations
            
            if minDelta < 0 {
                if allocation![minDeltaRow][minDeltaCol] == 0 {
                    let cycleIndices = computeCycleIndices(minCostIndex, minDeltaIndex, visited, numDestinations)
                    var minAllocation = Double.infinity
                    
                    for index in cycleIndices {
                        let row = index / numDestinations
                        let col = index % numDestinations
                        
                        if (row, col) != (minDeltaRow, minDeltaCol) {
                            minAllocation = min(minAllocation, allocation![row][col])
                        }
                    }
                    
                    allocation![minDeltaRow][minDeltaCol] = minAllocation
                } else {
                    let minValue = min(allocation![minDeltaRow][minDeltaCol], -minDelta)
                    allocation![minDeltaRow][minDeltaCol] += minValue
                }
            }
            
            relativeCosts = computeRelativeCosts(costs, allocation: allocation!)
        }
        
        return allocation
    }
    
    // Функция для вычисления индексов цикла
    func computeCycleIndices(_ start: Int, _ end: Int, _ visited: [Bool], _ numDestinations: Int) -> [Int] {
        var current = end
        var cycleIndices = [end]
        
        while current != start {
            for i in 0..<numDestinations {
                let nextIndex = current - i
                
                if nextIndex >= 0 && !visited[nextIndex] {
                    cycleIndices.append(nextIndex)
                    current = nextIndex
                    break
                }
                
                let prevIndex = current + i
                
                if prevIndex < visited.count && !visited[prevIndex] {
                    cycleIndices.append(prevIndex)
                    current = prevIndex
                    break
                }
            }
        }
        
        return cycleIndices
    }

    
    func analyzeTransportationProblem(supply: [Double], demand: [Double], costs: [[Double]]) -> ([[Double]], Double)? {
        let totalSupply = supply.reduce(0, +)
        let totalDemand = demand.reduce(0, +)
        
        if totalSupply == totalDemand {
            // Если суммарный запас равен суммарной потребности, это закрытая задача
            print("Обнаружена закрытая транспортная задача.")
            let solver = TransportationSolver()
            let (solution, totalCost) = solver.solveTransportProblem(supply: supply, demand: demand, costs: costs)
            return (solution, totalCost)
        } else {
            // Если суммарный запас не равен суммарной потребности, это открытая задача
            print("Обнаружена открытая транспортная задача.")
            var mutableSupply = supply
            var mutableDemand = demand
            var mutableCosts = costs
            // Балансируем задачу
            balanceTransportProblem(supply: &mutableSupply, demand: &mutableDemand, costs: &mutableCosts)
            
            // Проверяем, каким методом решать балансированную задачу
            let numSources = mutableSupply.count
            let numDestinations = mutableDemand.count
            
            // Если размерность меньше 3x3, используем метод северо-западного угла
            if numSources < 3 || numDestinations < 3 {
                let solver = TransportationSolver()
                if let solution = solver.northwestCornerMethod(mutableCosts, supplies: mutableSupply, demands: mutableDemand) {
                    return (solution, computeTotalCost(solution, costs: mutableCosts))
                } else {
                    return nil
                }
            } else {
                // Иначе используем метод симплекса
                let solver = TransportationSolver()
                if let solution = solver.simplexMethod(mutableCosts, supplies: mutableSupply, demands: mutableDemand) {
                    return (solution, computeTotalCost(solution, costs: mutableCosts))
                } else {
                    return nil
                }
            }
        }
    }

    // Функция для вычисления общей стоимости перевозки на основе решения и стоимостей
    func computeTotalCost(_ solution: [[Double]], costs: [[Double]]) -> Double {
        var totalCost = 0.0
        for i in 0..<solution.count {
            for j in 0..<solution[i].count {
                totalCost += solution[i][j] * costs[i][j]
            }
        }
        return totalCost
    }
}
