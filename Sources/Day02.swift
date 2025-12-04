import Algorithms
import Foundation

struct Day02: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [[Int]] {
    data.split(separator: "\n\n").map {
      $0.split(separator: "\n").compactMap { Int($0) }
    }
  }
  
  func parseInput(input: String) -> [(Int, Int)] {
    var output = [(Int, Int)]()
    let deliminators = CharacterSet(charactersIn:"-,\n")
    let values = input.components(separatedBy: deliminators)
    
    for i in stride(from: 0, to: values.count, by: 2) {
      guard let lowerBound = Int(values[i]), let upperBound = Int(values[i+1]) else {
        continue
      }
      output.append((lowerBound, upperBound))
    }
    
    return output
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    let ranges = parseInput(input: data)
    var invalidIDTotal = 0
    
    for range in ranges {
      for i in range.0 ... range.1 {
        let stringID = String(i)
        if (stringID.count % 2) != 0 {
          continue
        }
        
        let firstHalf = stringID.prefix(stringID.count/2)
        let secondHalf = stringID.suffix(stringID.count/2)
        
        if(firstHalf.elementsEqual(secondHalf)) {
          invalidIDTotal += i
        }
      }
    }
    
    return invalidIDTotal
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    let ranges = parseInput(input: data)
    var invalidIDTotal = 0
    
    for range in ranges {
      for i in range.0 ... range.1 {
        let stringID = String(i)
        let testString = (stringID + stringID).dropFirst().dropLast()
        
        if(testString.contains(stringID)) {
          invalidIDTotal += i
        }
      }
    }
    
    return invalidIDTotal
  }
}
