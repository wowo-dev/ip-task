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
    private let refreshControl = UIRefreshControl()
    private let activityIndicator = UIActivityIndicatorView(style: .large)

    private let viewModel = PackListViewModel()
    private var packs = [Pack]()
    private var subscribers = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "pack_list_title".localized
        setupView()
        setupBindings()
        loadPacks()
    }
}

// MARK: - View setup
private extension PackListController {
    func setupView() {
        view.backgroundColor = .listBackground
        setupTableView()
        setupRefreshControl()
        setupActivitiIndicator()
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
        tableView.delegate = self
        tableView.refreshControl = refreshControl

        tableView.register(cell: PackCell.self)
        tableView.register(headerFooter: PackHeader.self)
    }

    func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(loadPacks), for: .valueChanged)
    }

    func setupActivitiIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activate(
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        )
    }

    func setState(_ state: PackListState) {
        switch state {
        case .loading:
            activityIndicator.startAnimating()
        case .list:
            activityIndicator.stopAnimating()
        }
    }
}

// MARK: - Bindings setup
private extension PackListController {
    func setupBindings() {
        viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.setState(state)
            }
            .store(in: &subscribers)

        viewModel.$sections
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
                self?.refreshControl.endRefreshing()
            }
            .store(in: &subscribers)
    }
}

// MARK: - Actions
private extension PackListController {
    @objc
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
        let cell = tableView.dequeue(cell: PackCell.self, for: indexPath)

        guard let packCell = cell as? PackCell else {
            return cell
        }
        
        let packs = viewModel.sections[indexPath.section].packs
        let model = packs[indexPath.row]
        packCell.setup(model: model, isLast: indexPath.row == packs.count - 1)

        return packCell
    }
}

// MARK: - UITableViewDelegate
extension PackListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeue(headerFooter: PackHeader.self) as? PackHeader
        header?.set(title: viewModel.sections[section].title)
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        48
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        .leastNonzeroMagnitude
    }
}
