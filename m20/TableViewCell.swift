//
//  cell.swift
//  m18
//
//  Created by Владимир on 10.03.2023.
//

import UIKit
import SnapKit

class ExecutorCell: UITableViewCell {
    
    // MARK: - UI Elements
    
    private let name: UILabel = UILabel()
    private let lastname: UILabel = UILabel()
    private let birthday: UILabel = UILabel()
    private let country: UILabel = UILabel()
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
    
    func configure(with model: Executor) {
        name.text =  model.name
        lastname.text = model.lastName
        birthday.text = model.birthday
        country.text = model.country
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
    

