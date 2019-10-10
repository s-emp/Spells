//
//  UIAlertController+defaultError.swift
//  Spells
//
//  Created by Sergey Melnikov on 10.10.2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import UIKit

extension UIAlertController {
    static func showDefaultErrorAlert(_ message: String, vc: UIViewController) {
        let alerVC = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alerVC.addAction(UIAlertAction(title: "ОК", style: .default, handler: { (action) in
            alerVC.dismiss(animated: true, completion: nil)
        }))
        vc.present(alerVC, animated: true, completion: nil)
    }
}
