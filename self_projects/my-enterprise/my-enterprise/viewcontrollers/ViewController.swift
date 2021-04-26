import UIKit
import CoreData

class ViewController: UIViewController, AddAnEmployeeDelegate {
    
    var delegate : AddAnEmployeeDelegate?
    
    @IBOutlet var technicalSupportImageView: UIImageView?
    @IBOutlet var administrativeImageView: UIImageView?
    @IBOutlet var commercialImageView: UIImageView?
    @IBOutlet var developmentImageView: UIImageView?
    
    @IBOutlet var totalDevelopmentLabel: UILabel?
    @IBOutlet var totalSupportLabel: UILabel?
    @IBOutlet var totalAdministrativeLabel: UILabel?
    @IBOutlet var totalCommercialLabel: UILabel?
    @IBOutlet var totalEmployeesLabel: UILabel?
    @IBOutlet var averageExperienceLevelLabel: UILabel?
    @IBOutlet var averageExperienceLevelSlider: UISlider!
    
    @IBOutlet var tableView : UITableView?
    
    var employees:Array<EmployeeModel> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "My Company"
    
        employees = []
        retrieveData()
        reloadEmployeesData()
    
        if let table = tableView{
        table.reloadData()
        }
        
      let newItemButton = UIBarButtonItem(title: "New employee", style: UIBarButtonItem.Style.plain, target: self, action: #selector(ViewController.showNewEmployee))
        navigationItem.rightBarButtonItem = newItemButton
    }
    
    @objc func showNewEmployee(){
        let newEmployee = NewEmployeeViewController(delegate:self)
        if let navigation = navigationController{
            navigation.pushViewController(newEmployee, animated: true)
        }
    }
  
    func reloadEmployeesData(){
        
        var totalDevelopment = 0
        var totalSupport = 0
        var totalAdministrative = 0
        var totalCommercial = 0
        var sum:Float = 0.0
        var media:Float = 0.0
        
        for employee in employees{
            
            if employees.count == 0{
                return
            }
            
            let role = employee.role
            sum += Float(employee.experienceLevel)
            
            switch (role){
                
            case "Development":
                totalDevelopment+=1
                break
            case "Technical Support":
                totalSupport+=1
                break
            case "Administrative":
                totalAdministrative+=1
                break
            case "Commercial":
                totalCommercial+=1
               
            default:
                print("not found...")
            }
        }
        
        if employees.count != 0{
            
            media = (sum/Float(employees.count))
            }
        
        averageExperienceLevelLabel?.text = String(format: "%.2f", media)
        averageExperienceLevelSlider.setValue(media, animated: true)
        totalEmployeesLabel?.text = String(employees.count)
        totalDevelopmentLabel?.text = String(totalDevelopment)
        totalAdministrativeLabel?.text = String(totalAdministrative)
        totalSupportLabel?.text = String(totalSupport)
        totalCommercialLabel?.text = String(totalCommercial)
        
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let employee = employees[row]
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: nil)
        cell.textLabel!.text = (employee.name + " " + employee.lastname)
        
        return cell
    }
    
}

extension ViewController {
    
    func createData(_ employeeModel : EmployeeModel){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let employeeEntity = NSEntityDescription.entity(forEntityName: "Employee", in: managedContext)!
        let employee = NSManagedObject(entity: employeeEntity, insertInto: managedContext)
        
        employee.setValue(employeeModel.name, forKey: "name")
        employee.setValue(employeeModel.lastname, forKey: "lastname")
        employee.setValue(employeeModel.birthday, forKey: "birthday")
        employee.setValue(employeeModel.role, forKey: "role")
        employee.setValue(employeeModel.experienceLevel, forKey: "experienceLevel")
        
        retrieveData()
        reloadEmployeesData()
        if let table = tableView{
            table.reloadData()
        }
        
        do {
            
            try managedContext.save()
            
        }catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func retrieveData(){
        
        employees = []
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            
            for data in result as! [NSManagedObject]{
                
                employees.append(EmployeeModel(name: data.value(forKey: "name") as! String, lastname: data.value(forKey: "lastname") as! String, birthday: data.value(forKey: "birthday") as! String, role: data.value(forKey: "role") as! String, experienceLevel: data.value(forKey: "experienceLevel") as! Float))
            }
        }catch {
            print("failled")
        }
        
    }
    
    func updateData(employeeModel : EmployeeModel){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Employee")
        
        fetchRequest.predicate = NSPredicate(format: "name = %@", "Employee1")
        
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            let objectUpdate = test[0] as! NSManagedObject
            
            objectUpdate.setValue(employeeModel.name, forKey: "name")
            objectUpdate.setValue(employeeModel.lastname, forKey: "lastname")
            objectUpdate.setValue(employeeModel.birthday, forKey: "birthday")
            objectUpdate.setValue(employeeModel.role, forKey: "role")
            objectUpdate.setValue(employeeModel.experienceLevel, forKey: "experienceLevel")
            
            do {
                try managedContext.save()
            }catch {
                print("error")
            }
        }catch{
            print("error")
        }
    }
    
    func deleteData(){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Employee")
        
        fetchRequest.predicate = NSPredicate(format: "name = %@", "Employee3")
        
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            let objectToDelete = test [0] as! NSManagedObject
            try managedContext.delete(objectToDelete)
            
        }catch {
            print("error")
        }catch{
            print("error")
        }
    }
    
}
