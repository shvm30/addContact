//
//  EditingViewController.swift
//  m20
//
//  Created by Владимир on 21.03.2023.
//

import UIKit

class EditingViewController: UIViewController {
    weak var delegate: ExecutorDelegate?
    let vc = MainViewController()
    private lazy var FormStackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    private lazy var nameLabel:UILabel = {
        let label = UILabel()
        label.text = "Имя"
        return label
    }()
    private lazy var lastnameLabel:UILabel = {
        let label = UILabel()
        label.text = "Фамилия"
        return label
    }()
    private lazy var birthLabel:UILabel = {
        let label = UILabel()
        label.text = "Дата рождения"
        return label
    }()
    private lazy var countryLabel:UILabel = {
        let label = UILabel()
        label.text = "Страна"
        return label
    }()
    private lazy var nameTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Имя"
        return textField
    }()
    private lazy var lastnameTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Фамилия"
        return textField
    }()
    private lazy var birthTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Дата рождения"
        textField.keyboardType = .numberPad
        return textField
    }()
    private lazy var countryTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "Страна"
        return textField
    }()
    private lazy var editButton:UIButton = {
        let button = UIButton()
        button.setTitle("Добавить", for: .normal)
        button.addTarget(self, action: #selector(edit), for: .touchUpInside)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    var l1: String = ""
    var l2: String = ""
    var l3: String = ""
    var l4: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addElements()
        setConstraints()
        nameTextField.text = l1
        lastnameTextField.text = l2
        countryTextField.text = l3
        birthTextField.text = l4
        
    }

    private func addElements() {
        FormStackView.addArrangedSubview(nameLabel)
        FormStackView.addArrangedSubview(nameTextField)
        FormStackView.addArrangedSubview(birthLabel)
        FormStackView.addArrangedSubview(birthTextField)
        FormStackView.addArrangedSubview(lastnameLabel)
        FormStackView.addArrangedSubview(lastnameTextField)
        FormStackView.addArrangedSubview(countryLabel)
        FormStackView.addArrangedSubview(countryTextField)
        FormStackView.addArrangedSubview(editButton)
        view.addSubview(FormStackView)
    }
    
    private func setConstraints() {
        FormStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    @objc func edit() {
        if let name = nameTextField.text, let lastname = lastnameTextField.text, let birthday = birthTextField.text, let country = countryTextField.text {
            let executor = Executor(name: name, lastName: lastname, birthday: birthday, country: country)
            self.delegate?.update(executor: executor)
            navigationController?.popViewController(animated: true)
        }
    }
}
