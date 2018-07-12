//
//  ViewController.swift
//  Class0712
//
//  Created by 임건우 on 2018. 7. 12..
//  Copyright © 2018년 lims. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dontKnowUrlButton: UIButton!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var placeholderLabelLeadingCOnstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        underlineStyleByProgrammticallyExample()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    // 궁금한 부분 + programmatically 로 검색하면 코드 나옴
    private func underlineStyleByProgrammticallyExample(){
        // Plain
//        let buttonTitle = dontKnowUrlButton.title(fro: .normal)!
//        let mutableAttrStr = NSMutableAttributedString(string: buttonTitle)
        
        // Attributed
        guard let buttonTitle = dontKnowUrlButton.currentAttributedTitle else {return}
        let mutableAttrStr = NSMutableAttributedString(attributedString: buttonTitle)
        let attrKeys: [NSAttributedStringKey: Any] = [
            .foregroundColor: UIColor.darkText,
            .underlineStyle: NSUnderlineStyle.styleSingle.rawValue,
            .underlineColor: UIColor.darkGray
        ]
        mutableAttrStr.addAttributes(attrKeys, range: NSRange(location: 0, length: buttonTitle.string.count))
        dontKnowUrlButton.setAttributedTitle(mutableAttrStr, for: .normal)
    }

}


// MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = textField.text ?? ""
        let replacedText = (text as NSString).replacingCharacters(in: range, with: string)
        guard replacedText.count < 35 else { return false }
        
        let textFieldAttr = [NSAttributedStringKey.font: textField.font!]
        let textWidthSize = (replacedText as NSString).size(withAttributes: textFieldAttr).width
        placeholderLabelLeadingCOnstraint.constant = textWidthSize
        placeholderLabel.text = replacedText.isEmpty ? "workspace-url.slack.com" : ".slack.com"
        
        return true
    }
}
