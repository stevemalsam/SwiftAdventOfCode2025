//
//  Day04.swift
//  AdventOfCode
//
//  Created by Steve Malsam on 12/5/25.
//

import Algorithms

struct Day04: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [[String]] {
    data.split(separator: "\n").map {
      Array($0).map{String($0)}
    }
  }

  // We want to walk through the diagram. When we encounter a roll of paper (@),
  // we should check the 8 adjacent spaces using BFS
  func part1() -> Any {
    var movableRolls = 0
    
    for (yIndex, y) in entities.enumerated() {
      for (xIndex, x) in entities[yIndex].enumerated() {
        if x == "@" {
          let surroundingRolls = checkSurroundingsInGrid(grid: entities, x: xIndex, y: yIndex)
          if surroundingRolls < 4 {
            movableRolls += 1
          }
        }
      }
    }
    
    return movableRolls
  }
  
  // Checks the adjacent things, and returns the number of rolls next to them
  // Assumes a rectangular grid
  func checkSurroundingsInGrid(grid: [[String]], x: Int, y: Int) -> Int {
    var numberOfSurroundingRolls = 0
    
    let neighbors = findNeighbors(x: x, y: y, xMax: grid.count, yMax: grid[0].count)
    
    for neighbor in neighbors {
      if grid[neighbor.1][neighbor.0] == "@" {
        numberOfSurroundingRolls += 1
      }
    }
    

    
    return numberOfSurroundingRolls
  }
  
  func findNeighbors(x: Int, y:Int, xMax: Int, yMax: Int) -> [(Int, Int)] {
    var neighbors = [(Int, Int)]()
    
    // Define offsets for cardinal neighbors
    let cardinalOffsets = [
        (dx: -1, dy: 0), // Up
        (dx: 1, dy: 0),  // Down
        (dx: 0, dy: -1), // Left
        (dx: 0, dy: 1)   // Right
    ]

    // Define offsets for diagonal neighbors
    let diagonalOffsets = [
        (dx: -1, dy: -1), // Top-left
        (dx: -1, dy: 1),  // Top-right
        (dx: 1, dy: -1),  // Bottom-left
        (dx: 1, dy: 1)    // Bottom-right
    ]
    
    var allOffsets = cardinalOffsets
    allOffsets.append(contentsOf: diagonalOffsets)
    
    for offset in allOffsets {
      let neighborX = x + offset.dx
      let neighborY = y + offset.dy
      
      if neighborX >= 0 && neighborX < xMax && neighborY >= 0 && neighborY < yMax {
        neighbors.append((neighborX, neighborY))
      }
    }
    
    return neighbors
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    var movableRolls = 0
    var grid = entities
    
    while(true) {
      var rollsToRemove = [(Int, Int)]()
      for (yIndex, y) in grid.enumerated() {
        for (xIndex, x) in grid[yIndex].enumerated() {
          if x == "@" {
            let surroundingRolls = checkSurroundingsInGrid(grid: grid, x: xIndex, y: yIndex)
            if surroundingRolls < 4 {
              rollsToRemove.append((xIndex, yIndex))
            }
          }
        }
      }
      if(rollsToRemove.isEmpty) {
        break
      }
      
      movableRolls += rollsToRemove.count
      for roll in rollsToRemove {
        grid[roll.1][roll.0] = "."
      }
      
    }
    return movableRolls
  }
}
