//
//  Cep+CoreDataProperties.swift
//  
//
//  Created by rafaeldelegate on 6/25/19.
//
//

import Foundation
import CoreData


extension Cep : Decodable{

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cep> {
        return NSFetchRequest<Cep>(entityName: "Cep")
    }
    
    enum CodingKeys: String, CodingKey {
        case id, cep, street="logradouro", completion="complemento", district="bairro",state="localidade",fU="uf",unity="unidade",ibge,gia
    }

    @NSManaged public var cep: String?
    @NSManaged public var completion: String?
    @NSManaged public var district: String?
    @NSManaged public var fU: String?
    @NSManaged public var gia: String?
    @NSManaged public var ibge: String?
    @NSManaged public var id: UUID?
    @NSManaged public var state: String?
    @NSManaged public var street: String?
    @NSManaged public var unity: String?

}
