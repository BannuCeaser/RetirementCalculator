//
//  ChartsViewController.swift
//  RetirementCalculator
//
//  Created by Bhavani Nainala on 3/14/22.
//

import UIKit
import Charts

class ChartsViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var barChartView: BarChartView!
    
    var inputData: InputData? {
        didSet {
            guard let userData = inputData else {
                return
            }
            retirementDataSource = getRetirementResults(userData: userData)
        }
    }
    
    lazy var retirementDataSource: [DisplayDataModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        showBarChart()
    }
    
    func showBarChart() {
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<retirementDataSource.count {
            let dataEntry = BarChartDataEntry(x: Double(retirementDataSource[i].year), y: Double(retirementDataSource[i].retirementContribution))
          dataEntries.append(dataEntry)
        }
        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "retirement contributions")
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData
    }
    
    func getRetirementResults(userData: InputData) -> [DisplayDataModel] {
        let year = Calendar.current.component(.year, from: Date())
        var count = 0
        var previousResult: DisplayDataModel?
        
        var tempStartBal: Double = 0
        var tempStartSalary: Double = 0
        
        for _ in userData.currentAge...100 {
            let model = DisplayDataModel(year: year + count,
                                         age: userData.currentAge + count,
                                         startingBalance: ((previousResult?.startingBalance ?? userData.currentRetirementBalance) + tempStartBal) ,
                                         startingSalary: ((previousResult?.startingSalary ?? userData.currentSalary) + tempStartSalary),
                                         salaryIncreasePercent: userData.estimatedSalaryGrowth,
                                         rateOfReturnPercent: userData.annualROR,
                                         optInPercentageForRetirement: userData.yearlyContribution)
            
           
            retirementDataSource.append(model)
            previousResult = model
            tempStartBal = model.startingBalance
            tempStartSalary = model.startingSalary
            count += 1
        }
        
        return retirementDataSource
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
