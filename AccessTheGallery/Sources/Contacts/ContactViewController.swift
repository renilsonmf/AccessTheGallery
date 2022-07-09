//
//  ViewController.swift
//  AccessTheGallery
//
//  Created by Renilson Moreira on 08/07/22.
//

import Foundation
import UIKit
import CoreData

class ContactViewController: UIViewController {
    
    var contactView: ContactsView?
    var isSearch: Bool = false
    var contextContacts: NSManagedObjectContext!
    var contactsList: [NSManagedObject] = []
    var contactFixed: [NSManagedObject] = []
    var filteredListContacts: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contatos"
        createButtonAdd()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        contextContacts = appDelegate.persistentContainer.viewContext
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        contactView?.tableView.reloadData()
    }
    
    override func loadView() {
        makeView()
        self.view = contactView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        listContactsAdded()
        self.contactView?.tableView.reloadData()
    }
    
    func makeView() {
        contactView = ContactsView(delegateTableView: self, delegateSearchBar: self)
    }
    
    func createButtonAdd() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(actionButtonAdd)
        )
    }
    
    @objc func actionButtonAdd() {
        let controller = AddContactsViewController()
        controller.modalPresentationStyle = .formSheet
        present(controller, animated: true, completion: nil)
    }
    
    func listContactsAdded(){
        let requisicao = NSFetchRequest<NSFetchRequestResult>(entityName: "Contacts")
        do {
            let addedContacts = try contextContacts.fetch(requisicao)
            self.contactsList = addedContacts as! [NSManagedObject]
        } catch let erro {
            print("Erro ao recuperar clintes: \(erro.localizedDescription)")
        }
    }
}

extension ContactViewController: UISearchBarDelegate {
    ///Clique no textfield do seacr
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearch = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        isSearch = false
    }
    
    ///Clique no enter do teclado
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearch = true
    }
    
    ///Pega o que esta sendo digitado
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            isSearch = false
            contactView?.noHasSearchResult(result: true)
            self.contactView?.tableView.reloadData()
        } else {
            isSearch = true
            filteredListContacts = contactsList.filter({ (text) -> Bool in
                let tmp = text as NSManagedObject
                let value = tmp.value(forKey: "name") as! String
                let valueLast = tmp.value(forKey: "lastName") as! String
                let range = value.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                let rangeLast = valueLast.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                return (range != nil) || (rangeLast != nil)
            })
            if filteredListContacts.count == 0 {
                isSearch = false
                contactView?.noHasSearchResult(result: false)
                self.contactView?.tableView.reloadData()
            }else{
                isSearch = true
                contactView?.noHasSearchResult(result: true)
                self.contactView?.tableView.reloadData()
            }
            self.contactView?.tableView.reloadData()
        }
    }
}

extension ContactViewController: TableViewMethodsProtocol {
    func numberOfRowsInSectionDelegate() -> Int {
        if isSearch {
            return filteredListContacts.count
        }else {
            return contactsList.count
        }
    }
    
    func isSearch(_ value: Bool, indexPath: IndexPath, cell: CustomCell) {
        if value {
            let contactsFiltered = self.filteredListContacts[indexPath.row]
            let imageFiltered = contactsFiltered.value(forKey: "imageProfile") as! Data
            let lastNameFiltered = contactsFiltered.value(forKey: "lastName") as! String
            let firtNameFiltered = contactsFiltered.value(forKey: "name") as! String
            let cellNumberFiltered = contactsFiltered.value(forKey: "cellNumber") as! String
            cell.setupCellContacts(dataImage: imageFiltered,
                                   name: firtNameFiltered,
                                   lastName: lastNameFiltered,
                                   cellNumber: cellNumberFiltered)
        }else {
            let contacts = self.contactsList[indexPath.row]
            let imageContact = contacts.value(forKey: "imageProfile") as! Data
            let lastNameContact = contacts.value(forKey: "lastName") as! String
            let firtNameContact = contacts.value(forKey: "name") as! String
            let cellNumberContact = contacts.value(forKey: "cellNumber") as! String
            cell.setupCellContacts(dataImage: imageContact,
                                   name: firtNameContact,
                                   lastName: lastNameContact,
                                   cellNumber: cellNumberContact)
        }
    }
    
    func cellForRowAtDelegate(tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        if isSearch {
            isSearch(true, indexPath: indexPath, cell: cell)
        } else {
            isSearch(false, indexPath: indexPath, cell: cell)
        }
        return cell
    }
    
    func swipeRightToLeftDelegate(indexPath: IndexPath, tableView: UITableView) -> UISwipeActionsConfiguration {
        let actionDelete = UIContextualAction(style: .destructive,
                                              title: "Deletar") { [weak self] (action, view, completionHandler) in
            self?.handleDelete(indexPath: indexPath, tableView: tableView)
            completionHandler(true)
        }
        actionDelete.backgroundColor = .red
        actionDelete.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [actionDelete])
    }
    
    func swipeLeftToRightDelegate(indexPath: IndexPath) -> UISwipeActionsConfiguration {
        let actionFavorite = UIContextualAction(style: .normal,
                                                title: "Fixar") { [weak self] (action, view, completionHandler) in
            self?.handleMarkAsFixed(indexPath: indexPath)
            completionHandler(true)
        }
        actionFavorite.image = UIImage(systemName: "pin")
        actionFavorite.backgroundColor = .systemBlue
        return UISwipeActionsConfiguration(actions: [actionFavorite])
    }
    
    ///Action swift  right to left
    private func handleDelete(indexPath: IndexPath, tableView: UITableView) {
        let indice = indexPath.row
        let cliente = self.contactsList[indice]
        //Removendo do banco de dados
        self.contextContacts.delete(cliente)
        //Removendo do Array
        self.contactsList.remove(at: indice)
        //Remove apenas o campo sem atualizar a tabela
        tableView.deleteRows(at: [indexPath], with: .automatic)
        //confirma que o item vai ser removido
        do {
            try self.contextContacts.save()
        } catch let erro{
            print("Erro ao remover item \(erro)")
        }
    }
    
    ///Action swipe left to right
    private func handleMarkAsFixed(indexPath: IndexPath) {
        let contacts = self.contactsList[indexPath.row]
        contactFixed = [contacts]
        dump(contactFixed)
    }
}

