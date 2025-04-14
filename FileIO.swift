//
// FileIO.swift
//
// Created by Santiago Hewett
// Created on 2025/03/21
// Version 1.0
// Copyright (c) 2025 Santiago Hewett. All rights reserved.
//
// This program reads from an input file (Unit2-02-input.txt), extracts integers from each line, 
// and calculates their sum. 
//
// If a value is not a valid integer, an error message is displayed.
// If a line contains no valid integers, an error message is shown.
// The results are printed to the console and saved in an output file (Unit2-02-output.txt).
//

import Foundation

// Display a welcome message
print("Welcome to the file input/output program!")

// Define an error type for invalid file operations
enum InputError: Error {
    case invalidInput
}

// Use a do-catch block to handle errors
do {
    // String to store the output that will be written to the output file
    var outputStr = ""

    // Initialize variables for sum and count of valid integers
    var sum = 0
    var numValidInt = 0

    // Define file paths
    let inputFile = "./Unit2-02-input.txt"
    let outputFile = "./Unit2-02-output.txt"

    // Attempt to open the input file for reading
    guard let input = FileHandle(forReadingAtPath: inputFile) else {
        throw InputError.invalidInput
    }

    // Attempt to open the output file for writing
    guard let output = FileHandle(forWritingAtPath: outputFile) else {
        throw InputError.invalidInput
    }

    // Read the entire content of the input file
    let inputData = input.readDataToEndOfFile()

    // Convert the data into a string
    guard let inputStr = String(data: inputData, encoding: .utf8) else {
        throw InputError.invalidInput
    }

    // Split the file contents into lines
    let inputLines = inputStr.components(separatedBy: "\n")

    // Process each line in the file
    for line in inputLines {
        // Reset sum and valid integer count for each line
        sum = 0
        numValidInt = 0

        // Split the line into words/numbers
        let numbers = line.components(separatedBy: " ")

        // Process each value in the line
        for numStr in numbers {
            if let numInt = Int(numStr) {
                // Add valid integers to the sum
                sum += numInt
                numValidInt += 1
            } else {
                // Log an error message for non-integer values
                outputStr += "\(numStr) is not a valid integer.\n"
            }
        }

        // Check if there were any valid integers on the line
        if numValidInt == 0 {
            outputStr += "Error: No integers found on this line.\n\n"
        } else {
            outputStr += "The sum of the valid integers is \(sum).\n\n"
        }
    }

    // Write the processed output to the output file
    output.write(outputStr.data(using: .utf8)!)

    // Display success message
    print("Successfully wrote to the output file.")

    // Close the file handles
    output.closeFile()
    input.closeFile()

} catch InputError.invalidInput {
    // Handle file read/write errors
    print("Error: Unable to read from or write to the file.")
}
