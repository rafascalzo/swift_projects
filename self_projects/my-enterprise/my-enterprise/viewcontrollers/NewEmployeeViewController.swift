import UIKit

class NewEmployeeViewController: UIViewController {
    
    var delegate:AddAnEmployeeDelegate?
    
    init(delegate: AddAnEmployeeDelegate) {
        super.init(nibName: "NewEmployeeViewController", bundle: nil)
        self.delegate = delegate
        }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    @IBOutlet var birthdayTextField: UITextField?
    @IBOutlet var nameTextField: UITextField?
    @IBOutlet var lastnameTextField: UITextField?
    @IBOutlet var experienceLevelTextField: UITextField?
    
    @IBAction func experienceLevelSlider(_ sender: UISlider) {
        
        experienceLevelTextField!.text = String(Int(sender.value))
    }
    
    private let roles = ["Development","Administrative","Technical Support","Commercial"]
    
    @IBOutlet weak var roleTextField: UITextField?
    @IBOutlet weak var rolePickerView: UIPickerView?
    
    private var datePicker:UIDatePicker?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "My Company"
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        
        rolePickerView!.dataSource = self
        rolePickerView!.delegate = self
        
        datePicker?.addTarget(self, action: #selector(NewEmployeeViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(NewEmployeeViewController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
        birthdayTextField!.inputView = datePicker
        }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker : UIDatePicker){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyy"
        
        birthdayTextField!.text = dateFormatter.string(from: datePicker.date)
       
    }
    
    
   @IBAction func  addNewEmployee() {
    
        let name = nameTextField!.text
        let lastname = lastnameTextField!.text
        let birthday = birthdayTextField!.text
        let role = roleTextField!.text
        let experienceLevel = Float(experienceLevelTextField!.text!)
        
        if (name == nil || lastname == nil || birthday == nil || role == nil || experienceLevel == nil || delegate == nil){
            return
        }
        
        let employeeModel = EmployeeModel(name: name!, lastname: lastname!, birthday: birthday!, role: role!, experienceLevel: experienceLevel!)
      
        delegate?.createData(employeeModel)
        
       if let navigation = navigationController{
            navigation.popViewController(animated: true)
        }
    }

}

extension NewEmployeeViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return roles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        roleTextField!.text = roles[row]
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return roles[row]
    }
}
