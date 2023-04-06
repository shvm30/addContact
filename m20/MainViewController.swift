//
//  ViewController.swift
//  m20
//
//  Created by Владимир on 21.03.2023.
//

import UIKit
import SnapKit
import CoreData

struct UserData: Codable {
    var name:String?
    var lastname: String?
    var country: String?
    var birthday: String?
}

class MainViewController: UIViewController {
    var array:[Executor] = []
    private var savedData:UserData = UserData()
    let defaults = UserDefaults.standard
    let persistentContainer = NSPersistentContainer(name: "Model")
    private lazy var fetchedResultContainer: NSFetchedResultsController<Human> = {
        let fetchRequest = Human.fetchRequest()
        fetchRequest.sortDescriptors = []
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
        button.title = "Отсортировать"
        button.style = .plain
        button.target = self
        button.action = #selector(sort)
        return button
    }()
    private lazy var sortButtonItem:UIBarButtonItem = {
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
        persistentContainer.loadPersistentStores { persistentStoreDescription, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                do {
                    try self.fetchedResultContainer.performFetch()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        if let data = UserDefaults.standard.data(forKey: "name") {
            savedData = (try? JSONDecoder().decode(UserData.self, from: data)) ?? UserData()
        }
        musicianTableView.delegate = self
        setViews()
        setConstraints()
        musicianTableView.register(ExecutorCell.self, forCellReuseIdentifier: "cell")
        musicianTableView.dataSource = self
        navigationItem.rightBarButtonItem = addMusicianBarButtonItem
        navigationItem.leftBarButtonItem = sortButtonItem
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
        vc.people = Human.init(entity: NSEntityDescription.entity(forEntityName: "Human", in: persistentContainer.viewContext)!, insertInto: persistentContainer.viewContext)
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func sort() {
        let alert = UIAlertController(title: "Выберете способ", message: nil, preferredStyle: .actionSheet)
        present(alert, animated: true)
        alert.addAction(UIAlertAction(title: "По имени", style: .default, handler: { UIAlertAction in
            
//            self.savedData.typeOfSort = "lastname"
//            self.savedData.asceding = true
//            if let data = try? JSONEncoder().encode(self.savedData) {
//                UserDefaults.standard.set(data, forKey: "name")
//            }
 
//            if self.fetchedResultContainer.fetchRequest.sortDescriptors?.isEmpty == true {
//                self.fetchedResultContainer.fetchRequest.sortDescriptors?.append(NSSortDescriptor(key: "name", ascending: true))
//            } else {
//                self.fetchedResultContainer.fetchRequest.sortDescriptors?.remove(at: 0)
//                self.fetchedResultContainer.fetchRequest.sortDescriptors?.append(NSSortDescriptor(key: "name", ascending: true))
//            }

            do {
                try self.fetchedResultContainer.performFetch()
            } catch {
                print(error.localizedDescription)
            }
            self.musicianTableView.reloadData()
            
        }))
//        alert.addAction(UIAlertAction(title: "По фамилии", style: .default, handler: { UIAlertAction in
//            if self.fetchedResultContainer.fetchRequest.sortDescriptors?.isEmpty == true {
//                self.fetchedResultContainer.fetchRequest.sortDescriptors?.append(NSSortDescriptor(key: "lastname", ascending: true))
//            } else {
//                self.fetchedResultContainer.fetchRequest.sortDescriptors?.remove(at: 0)
//                self.fetchedResultContainer.fetchRequest.sortDescriptors?.append(NSSortDescriptor(key: "lastname", ascending: true))
//            }
//            do {
//                try self.fetchedResultContainer.performFetch()
//            } catch {
//                print(error.localizedDescription)
//            }
//            self.musicianTableView.reloadData()
//        }))
    }
}

//MARK: Extensions

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultContainer.sections{
            return sections[section].numberOfObjects
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultContainer.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ExecutorCell else { return UITableViewCell()}
        let result = fetchedResultContainer.object(at: indexPath)
        array.append(Executor(name: result.name ?? "", lastName: result.lastname ?? "", birthday: result.birthday ?? "", country: result.country ?? ""))
        cell.name.text = array[indexPath.row].name
        cell.lastname.text = array[indexPath.row].lastName
        cell.birthday.text = array[indexPath.row].birthday
        cell.country.text = array[indexPath.row].country
        return cell
    }
}
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = EditingViewController()
        vc.people = fetchedResultContainer.object(at: indexPath)
        navigationController?.pushViewController(vc, animated: true)
        }
    }

extension MainViewController: ExecutorDelegate {
    func update() {
        musicianTableView.reloadData()
        }
    }
extension MainViewController:NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        musicianTableView.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        musicianTableView.endUpdates()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                musicianTableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath {
                musicianTableView.reloadRows(at: [indexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                musicianTableView.deleteRows(at: [indexPath], with: .automatic)
            }
        case .move:
            if let indexPath = indexPath, let newIndexPath = newIndexPath {
                musicianTableView.moveRow(at: indexPath, to: newIndexPath)
            }
        default:
            musicianTableView.reloadData()
        }
    }
}

