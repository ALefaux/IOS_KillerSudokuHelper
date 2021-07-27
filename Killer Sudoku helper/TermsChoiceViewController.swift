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

    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var eightButton: UIButton!
    @IBOutlet weak var nineButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleText.text = title

        oneButton.backgroundColor = getBackgroundColor(element: 1)
        twoButton.backgroundColor = getBackgroundColor(element: 2)
        threeButton.backgroundColor = getBackgroundColor(element: 3)
        fourButton.backgroundColor = getBackgroundColor(element: 4)
        fiveButton.backgroundColor = getBackgroundColor(element: 5)
        sixButton.backgroundColor = getBackgroundColor(element: 6)
        sevenButton.backgroundColor = getBackgroundColor(element: 7)
        eightButton.backgroundColor = getBackgroundColor(element: 8)
        nineButton.backgroundColor = getBackgroundColor(element: 9)
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
        case 4:
            fourButton.backgroundColor = getBackgroundColor(element: 4)
        case 5:
            fiveButton.backgroundColor = getBackgroundColor(element: 5)
        case 6:
            sixButton.backgroundColor = getBackgroundColor(element: 6)
        case 7:
            sevenButton.backgroundColor = getBackgroundColor(element: 7)
        case 8:
            eightButton.backgroundColor = getBackgroundColor(element: 8)
        case 9:
            nineButton.backgroundColor = getBackgroundColor(element: 9)
        default:
            break
        }
    }
    
    @IBAction func valider(_ sender: UIButton) {
        if termsType == .notUsed {
            delegate.setNotUsedTerms(notUsedTerms: terms)
        } else if termsType == .needed {
            delegate.setNeededTerms(neededTerms: terms)
        }
        
        dismiss(animated: true) {
            
        }
    }
    
    @IBAction func erase(_ sender: Any) {
        self.terms.removeAll()
        
        oneButton.backgroundColor = getBackgroundColor(element: 1)
        twoButton.backgroundColor = getBackgroundColor(element: 2)
        threeButton.backgroundColor = getBackgroundColor(element: 3)
        fourButton.backgroundColor = getBackgroundColor(element: 4)
        fiveButton.backgroundColor = getBackgroundColor(element: 5)
        sixButton.backgroundColor = getBackgroundColor(element: 6)
        sevenButton.backgroundColor = getBackgroundColor(element: 7)
        eightButton.backgroundColor = getBackgroundColor(element: 8)
        nineButton.backgroundColor = getBackgroundColor(element: 9)
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
        case notUsed, needed
    }
    
}
