import Foundation

class EmployeeModel{
    
    let name: String
    let lastname: String
    let birthday:String
    let role:String
    let experienceLevel:Float
    
    init(name:String, lastname:String, birthday:String, role:String, experienceLevel:Float) {
        self.name=name
        self.lastname=lastname
        self.birthday = birthday
        self.role = role
        self.experienceLevel=experienceLevel
    }
    
    
}
