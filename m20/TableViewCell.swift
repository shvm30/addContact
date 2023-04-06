//
//  cell.swift
//  m18
//
//  Created by Владимир on 10.03.2023.
//

import UIKit
import SnapKit
import CoreData

class ExecutorCell: UITableViewCell {
    
    // MARK: - UI Elements
    
    var name: UILabel = UILabel()
     var lastname: UILabel = UILabel()
     var birthday: UILabel = UILabel()
     var country: UILabel = UILabel()
    private lazy var stackView:UIStackView = {
       let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 30
        stackView.axis = .horizontal
        return stackView
    }()
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commonInit()
        setConstr()
    }

    // MARK: - Internal methods
    
    func configure(fetchedResultContainer:NSFetchedResultsController<Human>, indexPath:IndexPath) {
        let people = fetchedResultContainer.object(at: indexPath)
        name.text =  people.name
        lastname.text = people.lastname
        birthday.text = people.birthday
        country.text = people.country
    }
    
    // MARK: - Private methods
    
    private func commonInit() {
        stackView.addArrangedSubview(name)
        stackView.addArrangedSubview(lastname)
        stackView.addArrangedSubview(birthday)
        stackView.addArrangedSubview(country)
        contentView.addSubview(stackView)
    }
    
    private func setConstr() {
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
    

