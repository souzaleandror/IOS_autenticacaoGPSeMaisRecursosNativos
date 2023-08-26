//
//  Perfil.swift
//  Alura Ponto
//
//  Created by Leandro Rodrigues on 24.08.23.
//

import Foundation
import UIKit

class Perfil {
    
    private let nomeDaFoto = "perfil.png"
    
    func salvarImagem(_ imagem: UIImage) {
        guard let diretorio = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let urlDoArquivo = diretorio.appendingPathComponent(nomeDaFoto)
        
        if FileManager.default.fileExists(atPath: urlDoArquivo.path) {
            removerImagemAntiga(urlDoArquivo.path)
        }
        
        guard let imagemData = imagem.jpegData(compressionQuality: 1) else { return }
        
        do {
            try imagemData.write(to: urlDoArquivo)
        } catch {
            print(error)
        }
    }
    
    private func removerImagemAntiga(_ url: String) {
        do {
          try FileManager.default.removeItem(atPath: url)
        } catch let error {
            print(error)
        }
    }
    
    func carregarImagem() -> UIImage? {
        
        let diretorio = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        
        let urlDoArquivo = NSSearchPathForDirectoriesInDomains(diretorio, userDomainMask, true)
        
        print(urlDoArquivo)
        
        if let caminho = urlDoArquivo.first {
            let urlDaImagem = URL(fileURLWithPath: caminho).appendingPathComponent(nomeDaFoto)
            
            let imagem = UIImage(contentsOfFile: urlDaImagem.path)
            
            return imagem
        }
        
        return nil
    }
    
}
