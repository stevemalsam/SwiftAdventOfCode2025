//
//  Day03.swift
//  AdventOfCode
//
//  Created by Steve Malsam on 12/4/25.
//

import Algorithms

struct Day03: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [String] {
    data.split(separator: "\n").compactMap {
      String($0)
    }
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    var outputVoltage = 0
    
    for batteryBank in entities {
      var leftIndex = batteryBank.startIndex
      var rightIndex = batteryBank.index(leftIndex, offsetBy: 1)
      var largestCharge = 0
      
      while leftIndex != batteryBank.index(before: batteryBank.endIndex) {
        while rightIndex != batteryBank.endIndex {
          guard let potentialBattery = Int("\(batteryBank[leftIndex])\(batteryBank[rightIndex])") else {
            continue
          }
          if potentialBattery > largestCharge {
            largestCharge = potentialBattery
          }
          
          rightIndex = batteryBank.index(after: rightIndex)
        }
        
        leftIndex = batteryBank.index(after: leftIndex)
        rightIndex = batteryBank.index(after: leftIndex)
      }
      
      outputVoltage += largestCharge
    }
    
    return outputVoltage
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    // Sum the maximum entries in each set of data
    entities.first
  }
}
