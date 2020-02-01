//
//  ReportVC.swift
//  Spells
//
//  Created by Сергей Мельников on 31.01.2020.
//  Copyright © 2020 Sergey Melnikov. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift

class ReportVC: UIViewController {

    @IBOutlet private var sendButton: UIButton!
    @IBOutlet private var messageViewText: UITextView!
    
    var spell: Spell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func sendReport(_ sender: Any) {
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        ref = db.collection("reports").addDocument(data: [
            "uuid": spell.uuid,
            "spellName": spell.name,
            "message": messageViewText.text ?? ""
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
                self.cancel("")
            }
        }
    }
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
}
