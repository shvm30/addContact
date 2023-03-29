//
//  ViewController.swift
//  m20
//
//  Created by Владимир on 21.03.2023.
//

import UIKit
import SnapKit
import CoreData


class MainViewController: UIViewController {
    var executorsArray:[Executor] = []
    let persistentContainer = NSPersistentContainer(name: "Model")
    private lazy var fetchedResultContainer:NSFetchedResultsController<Peoples> = {
        let fetchRequest = Peoples.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        return fetchedResultController
    }()
    // MARK: UI Elements
    
    private lazy var musicianTableView:UITableView = {
       let tableView = UITableView()
        return tableView
    }()
    private lazy var addMusicianBarButtonItem: UIBarButtonItem = {
       let button = UIBarButtonItem()
        button.title = "Добавить"
        button.style = .plain
        button.target = self
        button.action = #selector(addExecutor)
        return button
    }()
    
    //MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        musicianTableView.delegate = self
        setViews()
        setConstraints()
        musicianTableView.register(ExecutorCell.self, forCellReuseIdentifier: "cell")
        musicianTableView.dataSource = self
        navigationItem.rightBarButtonItem = addMusicianBarButtonItem
        }

    //MARK: Private Funcs
    
    private  func setViews() {
        view.addSubview(musicianTableView)
    }
    private func setConstraints() {
        musicianTableView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    //MARK: #Selectors
    @objc func addExecutor() {
        let vc = EditingViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: Extensions

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return executorsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ExecutorCell else { return UITableViewCell()}
        cell.configure(with: executorsArray[indexPath.row])
        return cell
    }
}
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = EditingViewController()
        vc.l1 = executorsArray[indexPath.row].name
        vc.l2 = executorsArray[indexPath.row].lastName
        vc.l3 = executorsArray[indexPath.row].birthday
        vc.l4 = executorsArray[indexPath.row].country
        navigationController?.pushViewController(vc, animated: true)
        }
    }

extension MainViewController: ExecutorDelegate {
    func update(executor: Executor) {
            self.executorsArray.append(executor)
            self.musicianTableView.reloadData()
        }
    }


