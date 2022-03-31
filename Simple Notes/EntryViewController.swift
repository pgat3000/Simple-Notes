//
//  EntryViewController.swift
//  Simple Notes
//
//  Created by Pablo Gatgens on 3/26/22.
//

import UIKit

class EntryViewController: UIViewController {
    
    @IBOutlet var titleField: UITextField!
    
    @IBOutlet var notefield: UITextView!
    
    public var completion: ((String,String)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.becomeFirstResponder()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTTapSave))
    
    }
    @objc func didTTapSave(){
        if let text = titleField.text,!text.isEmpty, !notefield.text.isEmpty{
            completion?(text,notefield.text)
        }
    }
}
