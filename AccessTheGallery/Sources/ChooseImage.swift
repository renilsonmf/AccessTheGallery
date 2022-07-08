//
//  ChooseImage.swift
//  AccessTheGallery
//
//  Created by Renilson Moreira on 08/07/22.
//

import UIKit

class ChooseImage: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var selecionador = UIImagePickerController();
    var alerta = UIAlertController(title: "Escolha uma opção", message: nil, preferredStyle: .actionSheet)
    var viewController: UIViewController?
    var retornoSelecionador: ((UIImage) -> ())?
    
    ///Deve instanciar a classe e chamar essa função
    func selecionadorImagem(_ viewController: UIViewController, _ retorno: @escaping ((UIImage) -> ())) {
        
        retornoSelecionador = retorno
        self.viewController = viewController
        
        ///Cria o alert e define uma ação que chama o metodo "abrirCamera"
        let camera = UIAlertAction(title: "Camera", style: .default) {
            UIAlertAction in
            self.abrirCamera()
        }
        ///Cria o alert e define uma ação que chama o metodo "abrirGaleria"
        let galeria = UIAlertAction(title: "Galeria", style: .default) {
            UIAlertAction in
            self.abrirGaleria()
        }
        
        ///Cria o alert e ao clicar fecha todos os alerts
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel) {
            UIAlertAction in
        }
        
        ///Declara que o novo delegate do piker são os metodos abaixo
        selecionador.delegate = self
        
        ///Adiciona ações ao alerta
        alerta.addAction(camera)
        alerta.addAction(galeria)
        alerta.addAction(cancelar)
        
        ///Exibe o alerta
        alerta.popoverPresentationController?.sourceView = self.viewController!.view
        viewController.present(alerta, animated: true, completion: nil)
    }
    
    func abrirCamera() {
        ///Aqui verificamos se temos a permissão para acessar a camera
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            ///Define o tipo que queremos selecionar como a câmera
            selecionador.sourceType = .camera
            ///Vai para a tela da Câmera
            self.viewController?.present(selecionador, animated: true, completion: nil)
        } else {
            ///Gera alerta se a pessoa não possui câmera no dispositivo ou caso você rode em um simulador.
            let alerta = UIAlertController(title: "Alerta", message: "Você não tem câmera", preferredStyle: .actionSheet)
            let cancelar = UIAlertAction(title: "Cancelar", style: .cancel){
                UIAlertAction in
            }
            ///Adiciona alerta "cancelar"
            alerta.addAction(cancelar)
            self.viewController?.present(alerta, animated: true, completion: nil)
        }
    }
    
    func abrirGaleria() {
        ///Por default o tipo de abertura do selecionador em cena é a Galeria
        selecionador.sourceType = .photoLibrary
        
        ///Vai para a tela da Galeria
        self.viewController?.present(selecionador, animated: true, completion: nil)
    }
    
    ///Metodo chamado quando o usuario escolhe uma imagem
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        ///Verifica o arquivo aberto é realmente uma imagem
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Esperava-se uma imagem, mas foi dado o seguinte: \(info)")
        }
        
        ///Retorna o callback da função selecionadorImagem
        retornoSelecionador?(image)
        
        ///Desfaz a tela da Galeria que foi gerada
        picker.dismiss(animated: true, completion: nil)
    }
    
}
