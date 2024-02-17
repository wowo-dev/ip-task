//
//  ViewController.swift
//  InPost Interview Coding Task
//
//  Created by Damian Piwowarski on 03/11/2022.
//

import UIKit

class PackListController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let packNetworking = PackNetworking()
    private var packs = [Pack]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Lista przesyłek"
        setupView()
        loadPacks()
    }
}

// MARK: - View setup
private extension PackListController {
    func setupView() {
        setupTableView()
    }

    func setupTableView() {
        view.addSubview(tableView)
        tableView.activate(
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        )
    }
}

// MARK: - Actions
private extension PackListController {
    private func loadPacks() {
        packNetworking.getPacks { [weak self] result in
            if case .success(let packs) = result {
                self?.packs = packs
            }
        }
    }
}
