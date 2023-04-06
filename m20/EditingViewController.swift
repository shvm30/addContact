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
    var people: Human?
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
    override func viewDidLoad() {
        super.viewDidLoad()
        if let people = people {
            nameTextField.text = people.name
            lastnameTextField.text = people.lastname
            countryTextField.text = people.country
            birthTextField.text = people.birthday
        }
        view.backgroundColor = .white
        addElements()
        setConstraints()
        nameTextField.text = people?.name
        lastnameTextField.text = people?.lastname
        countryTextField.text = people?.country
        birthTextField.text = people?.birthday
    }
    private func addElements() {
        FormStackView.addArrangedSubview(nameLabel)
        FormStackView.addArrangedSubview(nameTextField)
        FormStackView.addArrangedSubview(lastnameLabel)
        FormStackView.addArrangedSubview(lastnameTextField)
        FormStackView.addArrangedSubview(birthLabel)
        FormStackView.addArrangedSubview(birthTextField)
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
            people?.name = nameTextField.text
            people?.lastname = lastnameTextField.text
            people?.country = countryTextField.text
            people?.birthday = birthTextField.text
            try? people?.managedObjectContext?.save()
            self.delegate?.update()
            navigationController?.popViewController(animated: true)
        }
    }

