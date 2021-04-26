import UIKit
import Foundation

var str = "Hello, playground"

struct Carro: Codable {
    var modelo: String
}

let corola = Carro(modelo: "Corolla 2017")

struct Aviao: Codable {
    var modelo: String
}

let boeing = Aviao(modelo: "Boeing")

let boeing747 = Aviao(modelo: "boeing 747")

struct Frota<Element: Any> {
    var vehicles: [Element]
}

let frota = Frota(vehicles: [corola, boeing, boeing747])

for vehicle in frota.vehicles {
    if vehicle is Carro {
        print(vehicle, "é um carro")
    } else if vehicle is Aviao {
        print(vehicle, "é um aviao")
    }
}


