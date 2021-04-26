//import UIKit
//
//var str = "Hello, playground"
//    // needs implement mapviewdelegate
// // customView.map.register(PinView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
//
////use to configure annotations
////    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
////
////        guard let annotation = annotation as? Pin else { return nil }
////        let identifier = "pinIdentyfier"
////        var view: MKMarkerAnnotationView
////
////        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
////            as? MKMarkerAnnotationView {
////            dequeuedView.annotation = annotation
////            view = dequeuedView
////        } else {
////            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
////            view.canShowCallout = true
////            view.calloutOffset = CGPoint(x: -5, y: 5)
////            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
////        }
////        return view
////    }
//
//let name = "    Rafael       rafael      rafael        "
//
//print(name.trimmingCharacters(in: .whitespacesAndNewlines))
//var formatedName : String = ""
//for char in name {
//    if char != " " {
//        formatedName.append(char)
//    }
//}
//print(formatedName)
//print(name.trimmingCharacters(in: .init(charactersIn: " ")))
//extension String {
//    func condenseWhitespace() -> String {
//        let components = self.components(separatedBy: .whitespacesAndNewlines)
//        return components.filter { !$0.isEmpty }.joined(separator: " ")
//    }
//}
//print(name.trimmingCharacters(in: .whitespacesAndNewlines).condenseWhitespace())
//print(name.condenseWhitespace())
//
//
//func validate(value: String) -> Bool {
//    let PHONE_REGEX = "^((\\+)|(00))[0-9]{6,14}$"
//    let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
//    let result =  phoneTest.evaluate(with: value)
//    return result
//}
//
//print(validate(value: "+5514996863258"))
//
//
print("\\p\\u\\s\\s\\y")
print(#"\p\u\s\s\y"#)

var `var` = "puusy"
print(`var`)

