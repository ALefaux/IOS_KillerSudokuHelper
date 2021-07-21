//
//  TermsChoiceViewController.swift
//  Killer Sudoku helper
//
//  Created by Axel Lefaux on 20/07/2021.
//

import UIKit

class TermsChoiceViewController: UIViewController {
    
    var terms: [Int]!
    var termsType: TermsType!
    var delegate: HomeDelegate!

    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        oneButton.backgroundColor = getBackgroundColor(element: 1)
        twoButton.backgroundColor = getBackgroundColor(element: 2)
        threeButton.backgroundColor = getBackgroundColor(element: 3)
    }

    @IBAction func numberButtonClick(_ sender: UIButton) {
        addOrRemove(term: sender.tag)
        
        switch sender.tag {
        case 1:
            oneButton.backgroundColor = getBackgroundColor(element: 1)
        case 2:
            twoButton.backgroundColor = getBackgroundColor(element: 2)
        case 3:
            threeButton.backgroundColor = getBackgroundColor(element: 3)
        default:
            break
        }
    }
    
    @IBAction func valider(_ sender: UIButton) {
        if termsType == .possible {
            delegate.setPossibleTerms(possibleTerms: terms)
        } else if termsType == .needed {
            delegate.setNeededTerms(neededTerms: terms)
        }
        
        dismiss(animated: true) {
            
        }
    }
    
    private func getBackgroundColor(element: Int) -> UIColor {
        return terms.contains(element) ? UIColor.green : UIColor.clear
    }
    
    private func addOrRemove(term: Int) {
        if terms.contains(term) {
            let index: Int = terms.firstIndex(of: term)!
            terms.remove(at: index)
        } else {
            terms.append(term)
        }
    }
    
    enum TermsType {
        case possible, needed
    }
    
}
