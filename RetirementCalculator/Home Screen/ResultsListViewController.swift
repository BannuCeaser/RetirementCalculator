//
//  ResultsListViewController.swift
//  RetirementCalculator
//
//  Created by Bhavani Nainala on 3/13/22.
//

import UIKit

class ResultsListViewController: UIViewController, Storyboarded {
    
    var inputData: InputData? {
        didSet {
            guard let userData = inputData else {
                return
            }
            retirementDataSource = getRetirementResults(userData: userData)
        }
    }
    
    lazy var retirementDataSource: [DisplayDataModel] = []
    
    @IBOutlet weak var resultsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

extension ResultsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let currentAge = inputData?.currentAge ?? 0
//        let range = currentAge...100
        return retirementDataSource.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = resultsTableView.dequeueReusableCell(withIdentifier: "ResultsCell") as? ResultsCell else {
            return UITableViewCell()
        }
         let obj = retirementDataSource[indexPath.row] 
        
        cell.d1.text = String(obj.year)
        cell.d2.text = String(obj.age)
        cell.d3.text = String(obj.startingBalance)
        cell.d4.text = String(obj.interestGrowth)
        cell.d5.text = String(obj.currentSalary)
        cell.d6.text = String(obj.retirementContribution)
        cell.D7.text = String(obj.yearEndBalance)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableCell(withIdentifier: "ResultsCell") as? ResultsCell else {
            return UIView()
        }
        header.d1.text = "Year"
        header.d2.text = "Age"
        header.d3.text = "Beginning Retirement Balance"
        header.d4.text = "Interest Growth"
        header.d5.text = "Salary"
        header.d6.text = "Retirement Savings contribution"
        header.D7.text = "Total Year End Retirement Balance"
        
        return header
    }
    
}
