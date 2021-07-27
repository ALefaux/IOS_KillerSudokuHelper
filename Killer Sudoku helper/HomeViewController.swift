//
//  ViewController.swift
//  Killer Sudoku helper
//
//  Created by Axel Lefaux on 06/07/2021.
//

import UIKit

class HomeViewController: UIViewController, HomeDelegate {

    @IBOutlet weak var sumTextField: UITextField!
    @IBOutlet weak var numberTermsTextField: UITextField!
    @IBOutlet weak var possibleTermsText: UILabel!
    @IBOutlet weak var neededTermsText: UILabel!
    @IBOutlet weak var resultsTitleText: UILabel!
    @IBOutlet weak var resultsTextView: UITextView!

    private var notUsedTerms: [Int] = [Int]()
    private var neededTerms: [Int] = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func findAllResults(_ sender: UIButton) {
        guard let sumText = sumTextField.text else {
            // todo afficher un message d'erreur
            return
        }
        
        guard let numberTermsText = numberTermsTextField.text else {
            // todo afficher un message d'erreur
            return
        }
        
        guard let sumToFind: Int = Int(sumText) else {
            // todo afficher un message d'erreur
            return
        }
        
        guard let numberOfTerms = Int(numberTermsText) else {
            // todo afficher un message d'erreur
            return
        }
        
        let results = findResults(sumToFind: sumToFind, numberOfTerms: numberOfTerms)
        showResults(results)
    }
    
    private func showResults(_ results: [[Int]]) {
        resultsTitleText.isHidden = false
        var textResults = "Pas de résultats"
        
        if !results.isEmpty {
            textResults = results.map({ "\($0)" }).joined(separator: "\n")
        }
        resultsTextView.text = textResults
    }

    // MARK: - Find results
    private func findResults(sumToFind: Int, numberOfTerms: Int) -> [[Int]] {
        var possibleTerms = self.possibleTerms.filter { !notUsedTerms.contains($0) }
        possibleTerms.removeAll(neededTerms)

        var results: [[Int]] = []
        let resultsFind = findResults(
            sumToFind: sumToFind - neededTerms.sum(),
            numberOfTerms: numberOfTerms - neededTerms.count,
            possibleTerms: possibleTerms.map { [$0] }
        )
        for resultFind in resultsFind {
            var result: [Int] = []
            result.addAll(neededTerms)
            result.addAll(resultFind)
            results.append(result)
        }

        return results
    }
    
    private func findResults(sumToFind: Int, numberOfTerms: Int, possibleTerms: [[Int]]) -> [[Int]] {
        var possibleTerms: [[Int]] = possibleTerms
        var termsGoal: [[Int]] = [[Int]]()
        
        if numberOfTerms > 2 {
            let subNumberOfTerms = numberOfTerms - 1
            
            while (possibleTerms.count > 1) {
                if let firstSumFound = possibleTerms.first {
                    possibleTerms.remove(at: 0)
                    let subGoal = sumToFind - firstSumFound.sum()
                    let results = findResults(sumToFind: subGoal, numberOfTerms: subNumberOfTerms, possibleTerms: possibleTerms)
                    for result in results {
                        var goal: [Int] = []
                        goal.addAll(firstSumFound)
                        goal.addAll(result)
                        termsGoal.append(goal)
                    }
                }
            }
        } else if numberOfTerms > 1 {
            while (possibleTerms.count > 1) {
                if var firstNumber = possibleTerms.first {
                    possibleTerms.remove(at: 0)
                    
                    for term in possibleTerms {
                        if (firstNumber.sum() + term.sum() == sumToFind) {
                            firstNumber.addAll(term)
                            termsGoal.append(firstNumber)
                        }
                    }
                }
            }
        } else {
            termsGoal.append([sumToFind])
        }
        
        return termsGoal
    }
    
    // MARK: HomeDelegate
    func setNotUsedTerms(notUsedTerms: [Int]) {
        self.notUsedTerms = notUsedTerms
        var textToShow = "Tous les termes possible"
        
        if !possibleTerms.isEmpty {
            let terms = self.notUsedTerms.map({ String($0) }).joined(separator: ", ")
            textToShow = "Impossibles: \(terms)"
        }
        self.possibleTermsText.text = textToShow
    }
    
    func setNeededTerms(neededTerms: [Int]) {
        self.neededTerms = neededTerms
        var textToShow = "Aucun termes obligatoires"
        
        if !neededTerms.isEmpty {
            let terms = neededTerms.map({ String($0) }).joined(separator: ", ")
            textToShow = "Obligatoires: \(terms)"
        }
        
        self.neededTermsText.text = textToShow
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        sumTextField.resignFirstResponder()
        numberTermsTextField.resignFirstResponder()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let button = sender as? UIButton else {
            return
        }
        var termsSelected: [Int]
        var termsType: TermsChoiceViewController.TermsType
        var dialogTitle: String
        
        if button.tag == 1 {
            dialogTitle = "Termes impossible"
            termsSelected = notUsedTerms
            termsType = .notUsed
        } else {
            dialogTitle = "Termes obligatoires"
            termsSelected = neededTerms
            termsType = .needed
        }
        
        if segue.destination is TermsChoiceViewController {
            let destination = segue.destination as! TermsChoiceViewController
            destination.terms = termsSelected
            destination.termsType = termsType
            destination.delegate = self
            destination.title = dialogTitle
        }
    }

    // MARK: - Data
    private let possibleTerms: [Int] = [1,2,3,4,5,6,7,8,9]

}

