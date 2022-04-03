//
//  NoteViewController.swift
//  Simple Notes
//
//  Created by Pablo Gatgens on 3/26/22.
//

import UIKit

class NoteViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var noteLabel: UITextView!
    public var completion: ((String?,String?)->Void)?
    public var noteTitle: String? = ""
    public var note: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = noteTitle
        noteLabel.text = note
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Update", style: .done, target: self, action: #selector(didtapUpdate))
    }
    @objc func didtapUpdate(){
        completion?(titleLabel.text,noteLabel.text)
        //when the view closes, completion is triggered
        
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
