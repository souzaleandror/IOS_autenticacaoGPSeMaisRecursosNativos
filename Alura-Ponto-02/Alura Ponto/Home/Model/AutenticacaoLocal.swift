//
//  AutenticacaoLocal.swift
//  Alura Ponto
//
//  Created by Leandro Rodrigues on 25.08.23.
//

import Foundation
import LocalAuthentication

class AutenticacaoLocal {
    private let authenticatorContext = LAContext()
    private var error: NSError?
    
    func autorizaUsuario(comletion: @escaping(_ autenticacao: Bool) -> Void) {
        if authenticatorContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            authenticatorContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "E necessario autenticacao para apagar um recibo") {
                 sucesso, error in
                comletion(sucesso)
            }
        }
    }
}
