//
//  RetirementModel.swift
//  RetirementCalculator
//
//  Created by Bhavani Nainala on 3/13/22.
//

import Foundation

struct InputData {
    var clientName: String
    var currentAge: Int
    var planType: String
    var currentRetirementBalance: Double
    var annualROR: Double
    var currentSalary: Double
    var yearlyContribution: Double
    var estimatedSalaryGrowth:Double
    var retirementAge: Int
    var desiredIncomeAtActiveAge: Double
    var desiredIncomeAbove80Age: Double
}

struct DisplayDataModel: Identifiable {
    var id: Int {
        return year
    }
    
    var year: Int
    var age: Int
    var startingBalance: Double //starting savings
    var startingSalary: Double  //starting salary for calculation
    
    // previousSalary + (previousSalary * (salaryIncreasePercent / 100))
    var currentSalary: Double {
        (startingSalary + (startingSalary * (salaryIncreasePercent / 100)))
    }
    
    // (begining bal + (begining bal * ROR / 100))
    var interestGrowth: Double {
        return (startingBalance + (startingBalance * (rateOfReturnPercent / 100)))
    }
   
    var retirementContribution: Double {
        currentSalary * (optInPercentageForRetirement / 100)
    }
    // (interest growth + retirementContribution + beginning balance)
    var yearEndBalance: Double {
        interestGrowth + retirementContribution + startingBalance
    }
    
    // non UI data
    var salaryIncreasePercent: Double
    var rateOfReturnPercent: Double
    var optInPercentageForRetirement: Double
}

enum ButtonType {
    case calculate
    case showCharts
}
