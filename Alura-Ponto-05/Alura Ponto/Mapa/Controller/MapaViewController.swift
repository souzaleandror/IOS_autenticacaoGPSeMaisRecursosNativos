//
//  MapaViewController.swift
//  Alura Ponto
//
//  Created by Leandro Rodrigues on 27.08.23.
//

import UIKit
import MapKit

class MapaViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var Mapa: MKMapView!
    
    // MARK: - Attributes
    private var recibo: Recibo?
    
    // MARK: - Instanciar
    
    class func instanciar(_ recibo: Recibo) -> MapaViewController {
        let controller = MapaViewController(nibName: "MapaViewController", bundle: nil)
        
        controller.recibo = recibo
        
        return controller
    }
    
    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setRegiao()
        adicionarPino()
    }
    
    // MARK: - Methods
    func setRegiao() {
        guard let latitude = recibo?.latitude, let longitude = recibo?.longitude else { return }
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        
        let regiao = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
        
        Mapa.setRegion(regiao, animated: true)
    }
    
    func adicionarPino() {
        let annotation = MKPointAnnotation()
        
        annotation.title = "Registro de Ponto"
        annotation.title = "Subtitle - Registro de Ponto"
        
        annotation.coordinate.latitude = recibo?.latitude ?? 0.0
        annotation.coordinate.longitude = recibo?.longitude ?? 0.0
        
        Mapa.addAnnotation(annotation)
        
        // Teste
        
//        let geoCoder = CLGeocoder()
//
//        geoCoder.geocodeAddressString("Avenida Paulista", completionHandler: { locaisEncontrados, error in
//
//            let localizacao = locaisEncontrados?.first
//
//            let latitude = localizacao?.location?.coordinate.latitude
//            let longitude = localizacao?.location?.coordinate.longitude
//
//            }
//        )
    }
    
}
