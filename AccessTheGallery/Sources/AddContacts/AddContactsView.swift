//
//  AddContactsView.swift
//  AccessTheGallery
//
//  Created by Renilson Moreira on 08/07/22.
//

import UIKit
import Foundation
protocol ButtonSelectDelegate: AnyObject {
    func didTapAddImageButton()
    func didTapCancellButton()
    func didTapButtonAddContact()
}
class AddContactsView: UIView {
    weak var delegateSelectButton: ButtonSelectDelegate?
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var cancellButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cancelar", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(actionCancellButton), for: .touchUpInside)
        return button
    }()
    lazy var addContactButton: UIButton = {
        let addButton = UIButton()
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setTitle("OK", for: .normal)
        addButton.setTitleColor(.gray, for: .normal)
        addButton.isEnabled = false
        addButton.addTarget(self, action: #selector(actionAddContactButton), for: .touchUpInside)
        return addButton
    }()
    
    lazy var profileView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 100
        return view
    }()
    
    lazy var profileImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleToFill
        img.layer.cornerRadius = 100
        img.clipsToBounds = true
        img.image = UIImage(named: "profile")
        return img
    }()
    
    //MARK: Button select image
    lazy var addImageButton: UIButton = {
        let buttonSelect = UIButton()
        buttonSelect.translatesAutoresizingMaskIntoConstraints = false
        buttonSelect.setTitleColor(.systemBlue, for: .normal)
        buttonSelect.setTitle("Adicionar Foto", for: .normal)
        buttonSelect.addTarget(self, action: #selector(actionAddImageButton), for: .touchUpInside)
        return buttonSelect
    }()
    
    lazy var cardInfoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray3.cgColor
        return view
    }()
    
    lazy var nameTextField: UITextField = {
        let myTextField = UITextField()
        myTextField.translatesAutoresizingMaskIntoConstraints = false
        myTextField.attributedPlaceholder = NSAttributedString(string: "Nome",attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        myTextField.backgroundColor = .white
        myTextField.textColor = .black
        myTextField.setBottomBorder(color: UIColor.systemGray3.cgColor)
        return myTextField
    }()
    
    lazy var lastNameTextField: UITextField = {
        let myTextField = UITextField()
        myTextField.translatesAutoresizingMaskIntoConstraints = false
        myTextField.attributedPlaceholder = NSAttributedString(string: "Sobrenome",attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        myTextField.backgroundColor = .white
        myTextField.textColor = .black
        myTextField.setBottomBorder(color: UIColor.systemGray3.cgColor)
        return myTextField
    }()
    
    lazy var cellNumberTextField: UITextField = {
        let myTextField = UITextField()
        myTextField.translatesAutoresizingMaskIntoConstraints = false
        myTextField.attributedPlaceholder = NSAttributedString(string: "Celular",attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        myTextField.backgroundColor = .white
        myTextField.textColor = .black
        return myTextField
    }()
    
    //MARK: - Action Buttons
    @objc func actionCancellButton() {
        delegateSelectButton?.didTapCancellButton()
    }
    
    @objc func actionAddImageButton() {
        delegateSelectButton?.didTapAddImageButton()
    }
    
    @objc func actionAddContactButton() {
        delegateSelectButton?.didTapButtonAddContact()
    }
    
    func setupAddTargetIsNotEmptyTextFields() {
        nameTextField.addTarget(self, action: #selector(textFieldsIsNotEmpty), for: .editingChanged)
        lastNameTextField.addTarget(self, action: #selector(textFieldsIsNotEmpty),for: .editingChanged)
        cellNumberTextField.addTarget(self, action: #selector(cellNumberTextFieldAction),for: .editingChanged)
    }
    
    @objc func cellNumberTextFieldAction(text: UITextField) {
        guard let cellNumber = cellNumberTextField.text else { return }
        cellNumberTextField.text = cellNumber.applyPatternOnNumbers(pattern: "(##) #####-####", replacementCharacter: "#")
    }
    
    @objc func textFieldsIsNotEmpty(sender: UITextField) {
        ///Desconsidera o espaço
        sender.text = sender.text?.trimmingCharacters(in: .whitespaces)
        guard let name = nameTextField.text else {return}
        if name.isEmpty{
            self.addContactButton.isEnabled = false
            self.addContactButton.setTitleColor(.gray, for: .normal)
        }else{
            self.addContactButton.isEnabled = true
            self.addContactButton.setTitleColor(.systemBlue, for: .normal)
        }
    }
}

extension AddContactsView: ViewCodingProtocol {
    func buildViewHierarchy() {
        addSubview(addContactButton)
        addSubview(cancellButton)
        addSubview(profileView)
        profileView.addSubview(profileImage)
        addSubview(addImageButton)
        addSubview(cardInfoView)
        cardInfoView.addSubview(nameTextField)
        cardInfoView.addSubview(lastNameTextField)
        cardInfoView.addSubview(cellNumberTextField)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            cancellButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            cancellButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            cancellButton.heightAnchor.constraint(equalToConstant: 40),
            addContactButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            addContactButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            addContactButton.heightAnchor.constraint(equalToConstant: 40),
            
            profileView.topAnchor.constraint(equalTo: addContactButton.bottomAnchor, constant: 10),
            profileView.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileView.widthAnchor.constraint(equalToConstant: 200),
            profileView.heightAnchor.constraint(equalToConstant: 200),
            
            profileImage.topAnchor.constraint(equalTo: profileView.topAnchor),
            profileImage.leftAnchor.constraint(equalTo: profileView.leftAnchor),
            profileImage.rightAnchor.constraint(equalTo: profileView.rightAnchor),
            profileImage.bottomAnchor.constraint(equalTo: profileView.bottomAnchor),
            
            addImageButton.topAnchor.constraint(equalTo: profileView.bottomAnchor),
            addImageButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addImageButton.heightAnchor.constraint(equalToConstant: 30),
            
            cardInfoView.topAnchor.constraint(equalTo: addImageButton.bottomAnchor, constant: 15),
            cardInfoView.leftAnchor.constraint(equalTo: leftAnchor),
            cardInfoView.rightAnchor.constraint(equalTo: rightAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: cardInfoView.topAnchor),
            nameTextField.leftAnchor.constraint(equalTo: cardInfoView.leftAnchor, constant: 10),
            nameTextField.rightAnchor.constraint(equalTo: cardInfoView.rightAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            lastNameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 1),
            lastNameTextField.leftAnchor.constraint(equalTo: cardInfoView.leftAnchor, constant: 10),
            lastNameTextField.rightAnchor.constraint(equalTo: cardInfoView.rightAnchor),
            lastNameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            cellNumberTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 1),
            cellNumberTextField.leftAnchor.constraint(equalTo: cardInfoView.leftAnchor, constant: 10),
            cellNumberTextField.rightAnchor.constraint(equalTo: cardInfoView.rightAnchor),
            cellNumberTextField.bottomAnchor.constraint(equalTo: cardInfoView.bottomAnchor),
            cellNumberTextField.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func additionalSettings() {
        self.backgroundColor = .systemGray5
        setupAddTargetIsNotEmptyTextFields()
    }
}
