//
//  AddContactsViewController.swift
//  AccessTheGallery
//
//  Created by Renilson Moreira on 08/07/22.
//

import UIKit
import CoreData
class AddContactsViewController: UIViewController {
    
    var addContactsView = AddContactsView(frame: .zero)
    var photosGallery: NSData?
    var contextContacts: NSManagedObjectContext!
    var contactsList: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addContactsView.delegateSelectButton = self
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        contextContacts = appDelegate.persistentContainer.viewContext
    }
    
    override func loadView() {
        self.view = addContactsView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presentingViewController?.viewWillDisappear(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presentingViewController?.viewWillAppear(true)
    }
    
    func saveContacts(){
        //Criando objeto para clientes
        let newContact = NSEntityDescription.insertNewObject(forEntityName: "Contacts", into: contextContacts)
        let img = photosGallery ?? UIImage(named: "profile")?.pngData() as NSData?
        
        //Configurando objeto cliente
        newContact.setValue(addContactsView.nameTextField.text, forKey: "name")
        newContact.setValue(addContactsView.cellNumberTextField.text, forKey: "cellNumber")
        newContact.setValue(addContactsView.lastNameTextField.text, forKey: "lastName")
        newContact.setValue(img, forKey: "imageProfile")
        
        do {
            try contextContacts.save()
            print("Sucesso ao salvar o Lote")
            print(newContact)
        } catch let erro {
            print("Erro ao salvar cliente \(erro.localizedDescription)")
        }
    }
}

extension AddContactsViewController: ButtonSelectDelegate {
    func didTapCancellButton() {
        dismiss(animated: true, completion: nil)
    }
    
    func didTapAddImageButton() {
        let pickerImage = ChooseImage()
        pickerImage.selecionadorImagem(self) { imagem in
            self.photosGallery = imagem.pngData() as NSData?
            self.addContactsView.profileImage.image = imagem
        }
    }
    
    func didTapButtonAddContact() {
        self.saveContacts()
        dismiss(animated: true, completion: nil)
    }
}
