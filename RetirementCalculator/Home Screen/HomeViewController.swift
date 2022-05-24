//
//  ViewController.swift
//  RetirementCalculator
//
//  Created by Bhavani Nainala on 3/13/22.
//

import UIKit

class HomeViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var currentAge: UITextField!
    @IBOutlet weak var retirementPlanTextField: UITextField!
    @IBOutlet weak var currentRetirementBalance: UITextField!
    @IBOutlet weak var annualRateOfReturnTextField: UITextField!
    @IBOutlet weak var currentSalaryTextField: UITextField!
    @IBOutlet weak var yearlyContributionTextField: UITextField!
    @IBOutlet weak var estimatedSalaryGrowthTextField: UITextField!
    @IBOutlet weak var retirementAgeTextField: UITextField!
    @IBOutlet weak var desiredIncomeAtAges60to85TextField: UITextField!
    @IBOutlet weak var desiredIncomeAfterAge80TextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Retirement Calculator"
        nameTextField.becomeFirstResponder()
        
    }
    
    
    @IBAction func showChartsTapped(_ sender: UIButton) {
        validateInputs(buttonType: .showCharts)
    }
    
    func validateInputs(buttonType: ButtonType) {
        if !checkIfAnyFieldIsEmpty() {
            
            guard let name = nameTextField.text,
                  let age = Int(currentAge.text ?? "NA"),
                  let plan = retirementPlanTextField.text,
                  let balance = Double(currentRetirementBalance.text ?? "NA"),
                  let ror = Double(annualRateOfReturnTextField.text ?? "NA"),
                  let currentSalary = Double(currentSalaryTextField.text ?? "NA"),
                  let yearlyContribution = Double(yearlyContributionTextField.text ?? "NA"),
                  let estimatedSalaryGrowth = Double(estimatedSalaryGrowthTextField.text ?? "NA"),
                  let retirementAge = Int(retirementAgeTextField.text ?? "NA"),
                  let incomeAtActiveAge = Double(desiredIncomeAtAges60to85TextField.text ?? "NA"),
                  let incomeAbove80Age = Double(desiredIncomeAfterAge80TextField.text ?? "NA") else {
                      showAlert(message: "Type mismatch for inputs")
                      return
                  }
            
            let model = InputData(clientName: name,
                                  currentAge: age,
                                  planType: plan,
                                  currentRetirementBalance: balance,
                                  annualROR: ror,
                                  currentSalary: currentSalary,
                                  yearlyContribution: yearlyContribution,
                                  estimatedSalaryGrowth: estimatedSalaryGrowth,
                                  retirementAge: retirementAge,
                                  desiredIncomeAtActiveAge: incomeAtActiveAge,
                                  desiredIncomeAbove80Age: incomeAbove80Age)
            
            switch buttonType {
            case .calculate:
                let vc = ResultsListViewController.instantiateFromMain()
                //here you can pass any data to the next view controller. for example we have a variable with name `myString` in our next view contoller and we want to pass the data my `self viewController`
                vc.inputData = model
                self.navigationController?.pushViewController(vc, animated: true)
            case .showCharts:
                let vc = ChartsViewController.instantiateFromMain()
                vc.inputData = model
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            showAlert(message: "All input fields are required!!")
        }
    }
    
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        validateInputs(buttonType: .calculate)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: message, message: message, preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func checkIfAnyFieldIsEmpty() -> Bool {
        return nameTextField.text == "" || currentAge.text == "" || currentSalaryTextField.text == "" || retirementAgeTextField.text == "" || retirementPlanTextField.text == "" || yearlyContributionTextField.text == "" || retirementAgeTextField.text == "" || desiredIncomeAfterAge80TextField.text == "" || desiredIncomeAtAges60to85TextField.text == "" || annualRateOfReturnTextField.text == "" || currentRetirementBalance.text == ""
    }
}


