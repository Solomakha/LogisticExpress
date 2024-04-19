//
//  SimplexMethod.swift
//  LogisticExpress
//
//  Created by Дмитрий Соломаха on 20.03.2024.
//

import Foundation

// Симплекс-метод для решения транспортной задачи
func simplexMethod(costMatrix: [[Int]], supply: [Int], demand: [Int]) -> [[Int]] {
    let numRows = costMatrix.count
    let numCols = costMatrix[0].count

    var tableau = Array(repeating: Array(repeating: 0, count: numCols + numRows + 1), count: numRows + 1)
    var basicVariables = Set<Int>()

    for i in 0..<numRows {
        for j in 0..<numCols {
            tableau[i][j] = costMatrix[i][j]
        }
        tableau[i][numCols + i] = 1
        tableau[i][numCols + numRows] = supply[i]
        basicVariables.insert(numCols + i)
    }

    for j in 0..<numCols {
        tableau[numRows][j] = 0
        var count = 0
        for i in 0..<numRows {
            if basicVariables.contains(numCols + i) && tableau[i][j] == 1 {
                count += 1
            }
        }
        if count == 1 {
            if let rowIndex = (0..<numRows).first(where: { basicVariables.contains(numCols + $0) && tableau[$0][j] == 1 }) {
                tableau[numRows][j] = costMatrix[rowIndex][j]
            }
        }
    }

    var enteringColumn = 0
    var leavingRow = 0

    while let pivotColumn = tableau[numRows].enumerated().dropLast().first(where: { $0.element > 0 })?.offset {
        enteringColumn = pivotColumn

        var minRatio = Int.max
        for i in 0..<numRows {
            guard tableau[i][enteringColumn] > 0 else { continue }

            let ratio = tableau[i][numCols + numRows] / tableau[i][enteringColumn]
            if ratio < minRatio {
                minRatio = ratio
                leavingRow = i
            }
        }

        basicVariables.remove(enteringColumn)
        basicVariables.insert(numCols + leavingRow)

        let pivotElement = tableau[leavingRow][enteringColumn]
        for j in 0..<numCols + numRows + 1 {
            tableau[leavingRow][j] /= pivotElement
        }

        for i in 0..<numRows + 1 {
            if i != leavingRow {
                let factor = tableau[i][enteringColumn]
                for j in 0..<numCols + numRows + 1 {
                    tableau[i][j] -= factor * tableau[leavingRow][j]
                }
            }
        }
    }

    var resultMatrix = Array(repeating: Array(repeating: 0, count: numCols), count: numRows)
    for i in 0..<numRows {
        for j in 0..<numCols {
            if basicVariables.contains(numCols + i) {
                resultMatrix[i][j] = tableau[i][numCols + numRows]
            }
        }
    }

    return resultMatrix
}

//// Пример использования
//let costMatrix = [
//    [3, 2, 7],
//    [2, 4, 5],
//    [5, 1, 2]
//]
//
//let supply = [100, 150, 200]
//let demand = [120, 80, 170]
//
//let result = simplexMethod(costMatrix: costMatrix, supply: supply, demand: demand)
//print(result)
