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

        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 256
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.dataSource = self
        tableView.register(PackCell.self, forCellReuseIdentifier: PackCell.reuseIdentifier)
    }
}

// MARK: - Actions
private extension PackListController {
    private func loadPacks() {
        packNetworking.getPacks { [weak self] result in
            if case .success(let packs) = result {
                self?.packs = packs
            } else {
                self?.packs = []
            }

            self?.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource
extension PackListController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        packs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PackCell.reuseIdentifier, for: indexPath)

        if let packCell = cell as? PackCell {
            packCell.set(pack: packs[indexPath.row])
        }

        return cell
    }
}
