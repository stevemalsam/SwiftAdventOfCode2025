import Algorithms
import Foundation
import OSLog

struct Day01: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  var lines:[String] {
    data.components(separatedBy: .newlines)
  }

  let logger = Logger(subsystem: "com.stevemalsam.adventofcode", category: "general")

  enum Rotation {
    case Left(rotationAmount:Int)
    case Right(rotationAmount:Int)

    init?(turn: String) {
      guard let turnAmount = Int(turn.dropFirst()),
        let direction = turn.first else {
          return nil
        }

      switch direction.uppercased() {
        case "L": self = .Left(rotationAmount: turnAmount)
        case "R": self = .Right(rotationAmount: turnAmount)
        default: return nil
      }
    }
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
    var dialPosition = 50
    let minDial = 0
    let maxDial = 100

    var numberOfZeros = 0

    logger.info("The dial starts at \(dialPosition)")

    for line in lines {
        guard let rotation = Rotation(turn: line) else {
          logger.error("Couldn't parse turn \(line)")
          continue
        }

        switch rotation {
          case .Left(let rotationAmount):
            dialPosition -= rotationAmount

            while dialPosition < minDial {
              dialPosition += maxDial
            }

          case .Right(let rotationAmount):
            dialPosition += rotationAmount
            while dialPosition >= maxDial {
              dialPosition -= maxDial
            }
        }

        if(dialPosition == 0) {
          numberOfZeros += 1
        }

        logger.info("The dial is rotated \(line) to land on \(dialPosition)")
    }

    return numberOfZeros
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
    var dialPosition = 50
    let minDial = 0
    let maxDial = 100

    var numberOfZeros = 0

    logger.info("The dial starts at \(dialPosition)")

    for line in lines {
        guard let rotation = Rotation(turn: line) else {
          logger.error("Couldn't parse turn \(line)")
          continue
        }


        switch rotation {
          case .Left(let rotationAmount):

            let fullLoops = rotationAmount / maxDial
            let remainingDistance = rotationAmount % maxDial

            numberOfZeros += fullLoops

            let prevDialPosition = dialPosition

            if(remainingDistance > 0) {
              dialPosition -= remainingDistance
              if(dialPosition <= 0) {
                if(prevDialPosition != 0) {
                  numberOfZeros += 1
                }
                if(dialPosition < 0) {
                  dialPosition += maxDial
                }
              }
            }

          case .Right(let rotationAmount):
            let fullLoops = rotationAmount / maxDial
            let remainingDistance = rotationAmount % maxDial

            numberOfZeros += fullLoops

            let prevDialPosition = dialPosition
            if(remainingDistance > 0) {
              dialPosition += remainingDistance
              if(dialPosition >= maxDial) {
                dialPosition -= maxDial
                numberOfZeros += 1
              }
            }
        }

        logger.info("The dial is rotated \(line) to land on \(dialPosition)")
    }

    return numberOfZeros
  }

  func realMod(a: Int, b: Int) -> Int {
    (a%b+b)%b
  }
}