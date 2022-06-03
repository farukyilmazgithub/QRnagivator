//
//  QRScanner.swift
//  tab
//
//  Created by Faruk Yılmaz on 23.05.2022.
//

import Foundation
import SwiftUI
import CodeScanner
import MapKit

struct QRScanner: View {
    
    @ObservedObject var data = TargetLocation()
    @State var isPresentingScanner = false
    @State var isScanComplete = false
    @State public var scannedQR: String = "Scan a QR code to get location"
    @State var lat: Double = 0.0
    @State var lng: Double = 0.0
    @State private var mapView = false
    
    var scannerSheet: some View {
        CodeScannerView(
            codeTypes: [.qr],
            completion: { result in
                if case let . success(code) = result {
                    self.scannedQR = code.string
                    self.isPresentingScanner = false
                    self.isScanComplete = true
                }
            }
        )
    }
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            if (self.isScanComplete == true) {
                Text("The scanned QR information is :")
                Text(scannedQR)
                
            }
            
            if (self.isScanComplete == true) { Button("Open location on maps ") { action: do {
                
                let locArr = scannedQR.components(separatedBy: ", ")
                self.lat = Double(locArr[0])!
                self.lng = Double(locArr[1])!
                data.targetLat = self.lat
                data.targetLon = self.lng
                print("TARGET LOCATION LAT LON")
                print(lat)
                print(lng)
                openMaps(lat: lat, lng: lng)
                }
            }
            }
           
            Button("Scan QR Code") {
                self.isPresentingScanner = true
            }
            .sheet(isPresented: $isPresentingScanner) {
                self.scannerSheet
            }
        }        
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            QRScanner()
        }
    }
    
    
    
    func openMaps(lat: Double, lng: Double) {
        if let googleMapsUrl = URL(string: "comgooglemaps://?saddr=&daddr=\(lat),\(lng)&directionsmode=driving"), UIApplication.shared.canOpenURL(googleMapsUrl) { UIApplication.shared.open(googleMapsUrl)
        } else {
            let placemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lng), addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = "Scanned Target location"
            mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
        }
    }

}
