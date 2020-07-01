//
//  SPStorkTransitioningDelegate+Default.swift
//  Spells
//
//  Created by Sergey Melnikov on 07/10/2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

import SPStorkController

extension SPStorkTransitioningDelegate {
    static var `default`: SPStorkTransitioningDelegate {
        let transitionDelegate = SPStorkTransitioningDelegate()
        transitionDelegate.cornerRadius = 30
        transitionDelegate.hapticMoments = []
        transitionDelegate.showCloseButton = false
        return transitionDelegate
    }
}
