//
//  ViewController.swift
//  Simple Notes
//
//  Created by Pablo Gatgens on 3/26/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    @IBOutlet var table: UITableView!
    @IBOutlet var label: UILabel!
    
    //var models: [(title: String , note: String)] = []
      private var models = [NoteListItem]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllitems()
        title = "Simple Notes"
        
        table.delegate = self
        table.dataSource = self
        table.reloadData()
        
    }
    @IBAction func didTapNewNote() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "new") as? EntryViewController else {
            return
            
        }
        vc.title = "New Note"
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.completion = {
            noteTitle, note in
            self.navigationController?.popToRootViewController(animated: true)
           // self.models.append((title: noteTitle, note: note))
            self.createItem(title: noteTitle, note: note)
            self.label.isHidden = true
            self.table.isHidden = false
            self.table.reloadData()
        }
        navigationController?.pushViewController(vc, animated: true)
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row].title
        cell.detailTextLabel?.text = models[indexPath.row].note
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = models[indexPath.row]
        //show note controller
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "note") as? NoteViewController else{
            return
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = "Note"
        vc.note = model.note
        
        vc.noteTitle = model.title
        vc.completion = {
            noteTitle, note in
            self.navigationController?.popToRootViewController(animated: true)
           // self.models.append((title: noteTitle, note: note))
            self.updateItem(item: model, newTitle: noteTitle, newNote: note)
            self.label.isHidden = true
            self.table.isHidden = false
            self.table.reloadData()
        }
        navigationController?.pushViewController(vc,animated: true)
        
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            return UISwipeActionsConfiguration(actions: [
                RowActions(forRowAt: indexPath)
            ])
        }
    func RowActions(forRowAt indexPath: IndexPath) -> UIContextualAction {

        //adding more options, requires configuration function
        //let btnEdit = UIContextualAction(style: .normal, title: "Edit") { (action, indexPath, completion) in
          //  print("DELETE HERE")

            //completion(true)
        //}
        let model = models[indexPath.row]
        let btnDelete = UIContextualAction(style: .destructive, title: "Delete"){ (action, indexPath, completion) in
            print("DELETE HERE")
            
            self.deleteItem(item: model)

            completion(true)
        }
               
           
           return btnDelete
    }
//coreData
    func getAllitems(){
        do{
            models = try context.fetch(NoteListItem.fetchRequest())
            DispatchQueue.main.async {
                self.table.reloadData()
                self.table.isHidden = false
            }
        }catch{
            //onError
        }
    }
    
    func createItem(title: String,note: String){
        let newItem = NoteListItem(context: context)
        newItem.note = note
        newItem.title = title
        do{
            try context.save()
            getAllitems()
        }catch{
            //OnError
        }
    }
    func deleteItem(item : NoteListItem){
        context.delete(item)
        do{
            try context.save()
            getAllitems()
        }catch{
            //OnError
        }
    }
        
    func updateItem(item: NoteListItem,newTitle : String? , newNote : String?){
        item.note = newNote
        item.title = newTitle
        do{
            try context.save()
            getAllitems()
        }catch{
            //OnError
        }
        }
}

