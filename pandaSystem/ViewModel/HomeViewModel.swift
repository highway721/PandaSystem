//
//  HomeViewModel.swift
//  pandaSystem
//
//  Created by Yusuke Tomatsu on 2020/11/23.
//

import SwiftUI
import CoreLocation
import Firebase

class HomeViewModel: NSObject,ObservableObject,CLLocationManagerDelegate {
    @Published var search = ""
    @Published var locationManager = CLLocationManager()
    @Published var userLocation : CLLocation!
    @Published var userAddress = ""
    @Published var noLocation = false
    //menu
    @Published var showMenu = false
    //item deta
    @Published var items: [Item] = []
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            print("authorized")
            manager.requestLocation()
            self.noLocation = false
        case .denied:
            print("denied")
            self.noLocation = true
        default:
            print("unknown")
            self.noLocation = false
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        print(error.localizedDescription)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.userLocation = locations.last
        self.extractLocation()
        self.login()
    }
    func extractLocation() {
        CLGeocoder().reverseGeocodeLocation(self.userLocation) {(res, err) in
            guard let safeData = res else{return}
            var address = ""
            
            address += safeData.first?.name ?? ""
            address += ","
            address += safeData.first?.locality ?? ""
            
            self.userAddress = address
        }
    }
    func login(){
        Auth.auth().signInAnonymously{(res, err) in
            if err != nil{
                print(err?.localizedDescription)
                return
            }
            print("success = \(res!.user.uid)")
        }
        //we will fetch the data after the user login
        self.fetchdata()
    }
    //fetching the data from firestore
    func fetchdata() {
        let db = Firestore.firestore()
        db.collection("Items").getDocuments { (snap, err) in
                   
                   guard let itemData = snap else{return}
                   
                   self.items = itemData.documents.compactMap({ (doc) -> Item? in
                       //sを変更
                       let id = doc.documentID
                       let name = doc.get("item_name") as! String
                       let cost = doc.get("item_cost") as! NSNumber
                       let rating = doc.get("item_rating") as! String
                       let image = doc.get("item_image") as! String
                       let detail = doc.get("item_detail") as! String
                       
                       return Item(id: id, item_name: name, item_cost: cost, item_detail: detail, item_image: image, item_rating: rating)
                   })
                   
//                   self.filtered = self.items
               }
    }
}
