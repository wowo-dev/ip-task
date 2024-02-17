//
//  IPNavigationController.swift
//  InPost Interview Coding Task
//
//  Created by Damian Piwowarski on 03/11/2022.
//

import UIKit

class IPNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundEffect = nil
        appearance.backgroundColor = .commonBackground
        appearance.shadowImage = UIImage()
        appearance.shadowColor = .clear

        let typography = Typography.headline
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.text,
            .kern: typography.kern
        ]
        appearance.titleTextAttributes[.font] = UIFont(typography: typography)

        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
}
