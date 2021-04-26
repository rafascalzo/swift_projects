import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var name: String?
    @NSManaged public var lastname: String?
    @NSManaged public var birthday: String?
    @NSManaged public var role: String?
    @NSManaged public var experienceLevel: Float

}
