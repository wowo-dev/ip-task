//
//  ViewController.swift
//  InPost Interview Coding Task
//
//  Created by Damian Piwowarski on 03/11/2022.
//

import UIKit
import Combine

class PackListController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    private let viewModel = PackListViewModel()
    private var packs = [Pack]()
    private var subscribers = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Lista przesyłek"
        setupView()
        setupBindings()
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

// MARK: - Bindings setup
private extension PackListController {
    func setupBindings() {
        viewModel.$sections
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &subscribers)
    }
}

// MARK: - Actions
private extension PackListController {
    func loadPacks() {
        viewModel.fetchPacks()
    }
}

// MARK: - UITableViewDataSource
extension PackListController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.sections[section].packs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PackCell.reuseIdentifier, for: indexPath)

        guard let packCell = cell as? PackCell else {
            return cell
        }
        
        let packs = viewModel.sections[indexPath.section].packs
        let pack = packs[indexPath.row]
        packCell.set(pack: pack)

        return packCell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.sections[section].title
    }
}
