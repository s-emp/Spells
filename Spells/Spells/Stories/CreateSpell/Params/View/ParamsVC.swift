//
//  ParamsVC.swift
//  Spells
//
//  Created by Sergey Melnikov on 11.10.2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit

class ParamsVC: UIViewController {

    // MARK: - Properties
    private var presenter: ParamsOutput!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ParamsPresenter(self)
    }
    
    // MARK: - Methods
    @IBAction func touchCancel() {
        
    }
}

// MARK: - Input
extension ParamsVC: ParamsInput {
    
}
