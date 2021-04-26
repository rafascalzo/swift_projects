import UIKit
/*
var str = "Hello, playground"

let nome:String = "ëggyplant-brownnie"
let calories:Double = 50.5
let hapiness:Int = 5

func helloCalories() {
    let product = "brownie"
    print("hello Calories \(product)")
}

let eggyplantIsAVegetable:Bool = false //boolean

helloCalories()

func add(name:String, calories:Double){
    print ("adding \(name) with \(calories)")
}

add (name: "Brownie", calories: 30.15)
add(name: "Eggplant", calories: 50.5)

let totalCalorias =   [50.5,100, 300, 500]

// nestas duas maneiras de escrever for, a variavel i vai de 0 até 3
for i in 0...3 {
    print("Calories are \(totalCalorias[i])")
}

for i in 0...(totalCalorias.count - 1){
    print(i)
}


//neste for o que será percorrido serao os valores das posicoes do array e nao o i de fato
//for direto no eslementos do array
//for each
for cal in totalCalorias{
    print(cal)
}


let calories1 = [50.5,100,200,400]

//quando o array nao for inicializado deve-se deixar explicito o seu tipo
let calories2:Array<Double> = []


//deve-se tomar cuidado ao utilizar variaveis implicitas em alguns casos, como no exemplo abaixo
//caso fosse declarado inicialmente com valor 0 a aplicacao iria crashar pois seria reconhecido como Int
//deve-se ou declarar explicitamente ou inicializar com algum valor que a defina como um tipo especifico

//para informar que a funcao tem retorno utiliza-se -> direcionado para o tipo do retorno como no exemplo abaixo
func allCalories(calories:Array<Double>) -> Double{
    var total = 0.0
    for c in calories {
        total+=c
    }
    return total
}

/*
 
 exemplo de uma funcao que deveria ter um resultado double mas compilou um resultado int devido à variavel nao ter sido informada explicitamente e o compilador interpretou como int
 
 var values = [1,2]
 var total = 0
 for v in values {
 total += v
 }
 print(total / values.count)
 */


/* exemplo com erro
func calculaSoma(valores:Array<Double>) -> Double {
    var soma = 0
    for valor in valores {
        soma += valor
    }
    return soma
}*/

//exemplo corrigido
func calculaSoma(valores:Array<Double>) -> Double {
    var soma = 0.0
    //ou var soma:Double = 0
    for valor in valores {
        soma += valor
    }
    return soma
}

/*

class Meal {
    var hapiness = 5
    var name = "eggyplant-brownie"
}

var brownie = Meal()

print(brownie.name)
print(brownie.hapiness)

var sundubu = Meal()
sundubu.hapiness = 4
sundubu.name = "Sundubu"
print(sundubu.name)
print(sundubu.hapiness)
*/



class Meal {
    //utiliza-se o ponto de interrogacao para informar que esta variavel é opcional
    //variavel opcional é uma variavel que nao foi inicializada e por precaucao o swift nao compila, para evitar o acesso a uma variavel nula
    var name:String?
    var hapiness:Int?
}

var brownie = Meal()
// o ponto de exclamacao serve para dizer ao swift que temos ciencia de que estaremos correndo risco ao acessar a variavel (sabendo da possibilidade de o valor ser nulo e a aplicacao crashar
// portanto deve-se dicionar o ponto de exclamacao para poder acessa-la

//explicitando que a variavel name é opcional (é opcional explicitar essa informacao hahahah)

brownie.name = Optional("eggyplant brownie")

print(brownie.hapiness!)


//caso nao tenha o ponto de exclamacao para acessar a varivel, a aplicacao nao ira compilar
print(brownie.name!.uppercased())

//para declarar ? para acessar !

*/


/*class Meal{
    var name:String?
    var hapiness:Int?
}

var brownie = Meal()

print(brownie.hapiness)
print(brownie.name)

/*
if (brownie.name != nil){
    print(brownie.name!.uppercased())
}
 primeira maneira de declarar um if (comum em outras linguagens)
 */

if let name = brownie.name{
    print(name.uppercased())
}*/

//outra forma

/*
 if pedro.nome == nil {
 return
 }
 print(pedro.nome!)
 */

//BOAS PRATICAS: se existe uma variavel OPCIONAL, na hora de acessá-la deve-se optar por usar o if let em vez de usar o ! para extrair seu valor
//BOAS PRATICAS: sempre que possível, nao utilizar variaveis opcionais
//BOAS PRATICAS: sempre que possível, utilizar variaveis finais (let)


//quanto mais próximo do let, mais facil de entender se torna o código

// é possivel também declarar variaveis opcionais com o ! em vez do ?, como na classe do ViewController.swift, porém seu funcionamento é ligeiramente diferente



//var name:String!
//print(name)

// ! -> nao compila, aplicacao crasha na hora caso a variavel seja nula
//erro de explosao
// ? -> compila, porem nao da crash na aplicacao, apenas retorna o valor de nulo caso tenha

// em suma, ! significa criar um opcional ao extremo de nao precisar de nenhuma verificacao para aplicacao


//metodos com retorno opcional

//let numero = Int("5")

//Adicionamos a constante numero e passamos a String 5. O retorno deveria ser um Int, no entanto, ele será um Int Optional.

//solucao, tratar a exception

/*if let num = numero {
    print(num)
} else {
    print("vazio")
}
*/

/*
 class Meal {
 var happiness:Int?
 var name:String?
 }
 
 var brownie = Meal()
 brownie.name = "eggplant brownie"
 
 print(brownie.happiness)
 print(brownie.name)
 
 if let name = brownie.name {
 print(name.uppercased())
 }
 
 let numero:Int = Int("5")

 */
/*
/*
 A função Int() retorna um valor opcional, ou seja, ele pode retornar nulo caso o valor passado como parâmetro seja inválido, ocorrendo um erro pois o tipo da variável idade está sendo declarado explicitamente como um Int obrigatório. O correto seria declarar o tipo da variável implicitamente, como em let idade = Int("34").
 
 O método Int() retorna um Int opcional quando o valor passado como parâmetro for inválido para conversão, sendo necessário que a variável que receberá o retorno desse método seja declardo implicitamente ou como opcinal.
 */


//solucao para o ! e ?, criar "construtor" init
//good citizen policies
//construtor serve para evitar exceptions
//evitar opcionais, getters e setters aleatorios, variaveis nao inicializadas

class Meal {
    var name:String
    var hapiness:Int
    var items = Array<Item>()
    
    init(name:String, hapiness:Int) {
        self.name=name
        self.hapiness = hapiness
    }
    
    func allCalories() ->Double{
        var total = 0.0
        
        for i in items{
            total += i.calories
        }
        return total
    }
}

class Item {
    var name:String
    var calories:Double
    
    init(name:String, calories:Double) {
        self.name=name
        self.calories=calories
    }
}

let brownie = Meal(name: "eggyplant brownie", hapiness: 5)
print(brownie.name)

//classe com construtor inicializado, assegurando que as variaveis da classe nao serao opcionais e nao tera valor nulo

let item1 = Item(name: "brownie", calories: 115)
let item2 = Item(name: "vegan cream", calories: 40)
brownie.items.append(item1)
brownie.items.append(item2)

print(brownie.allCalories())



//maneira antiga de escrever um metodo
func preparaParaSegue( segue : UIStoryboardSegue){
   
}
var segue: UIStoryboardSegue!
preparaParaSegue(segue: segue)


//opcao 1, omitir nome do parametro externo  utilizando o _

func preparaPara(_ segue : UIStoryboardSegue){
    
}
var segue1:UIStoryboardSegue!
preparaPara(segue1)

//nova maneira, definir nome do parametro externo -> para

func prepara(para segue: UIStoryboardSegue){
}

prepara(para: segue)










//classe ViewControler > herda de UIViewControler (UI = user interfafce)

//para criar um tableview separado, implementar protocolo UITableViewDataSource

class ViewController: UIViewController, AddAnItemDelegate{
    
    //variavel criada referencia da classe Mealstable... para acessar o metodo add (delegate)
    //variavel tem que ser opcional pois so e feita na inicializacao
    //quem inicializa o nosso controller é a interface builder, o interface builder é feito de uma maneira que nao podemos trabalhar com o inicializador, portanto a variavel deve-se ser opcional
    //delegate = protocoloco para receber assinatura de metodos comuns entre classes
    var delegate : AddAMealDelegate?
    
    //variavel para receber os itens marcados com checkmark
    var selected = Array<Item>()
    
    var items = [
        Item(name: "Eggplant", calories: 10),
        Item(name: "Brownie", calories: 10),
        Item(name: "Zucchini", calories: 10),
        Item(name: "Muffin", calories: 10),
        Item(name: "Coconut oil", calories: 500),
        Item(name: "Chocolate frosting", calories: 1000),
        Item(name: "Chocolate chip", calories: 1000)
    ]
    
    @IBOutlet var tableView : UITableView?
    
    func add(_ item: Item) {
        items.append(item)
        
        //optional chaining, "se existe, chama"
        //tableView?.reloadData()
        
        
        //menos utilizado pois temos que nos lembrar de extrair o valor
        //if tableView != nil {
        //tableView!.reloadData()
        //}
        
        //menos utilizados pois temos que nos lembrar de extrair o valor
        //if (tableView == nil) {
        //    return
        //}
        //tableView!.reloadData()
        
        //opcional if let
        //vantagem do if let: para nao precisar extrair o valor da variavel com ? ou !, compilador nos força a verificar com o if, nos lembrando (talvez) que existe o else
        
        if let table = tableView{
            table.reloadData()
        }else{
            Alert(controller: self).show("Unable to update the itens table")
        }
        
    }
    
    //funcao que carrega  a view
    override func viewDidLoad() {
        
        // usar #selector em vez de Selector, passar classe.metodo e fazer notacao @objc na frente do metodo que deseja chamar. swift4
        let newItemButton = UIBarButtonItem(title: "New Item", style: UIBarButtonItem.Style.plain, target: self, action: #selector(ViewController.showNewItem))
        navigationItem.rightBarButtonItem = newItemButton
    }
    
    //metodo a ser chamado caso o usuario tenha clicado no botao que criamos
    @objc func showNewItem () {
        // NewItemViewController tem a opcao de passar o arquivo xib para qual sera direcionado
        let newItem = NewItemViewController(delegate:self)
        if let navigation = navigationController{
            navigation.pushViewController(newItem, animated: true)
        } else{
            Alert(controller: self).show()
        }
    }
    
    
    
    
    //Interface Builder, responsavel pela criacao da interface
    // anotacao @IBOutlet para ligar com a view (informa que é um plug)
    // é necessario adicionar um valor inicial para a variavel pois o sistema entende que se nao estiver iniciado a aplicacao pode crashar. para solucionar este problema adicionamos ! como no exemplo abaixo, para avisar que esta variavel é opcional
    //! para quando nao quer verificar a possibilidade de numeros nulos (codigo antigo), ? para forcar uma verificacao
    @IBOutlet var nameField : UITextField?
    @IBOutlet var hapinessField : UITextField?
    
    //notacao @IBAction para informar que é uma acao e vincular com a view visualmente (nedcessario)
    @IBAction func add (){
        /* metodo explicito, informando que a string é uma string. nao é necessario explicitar uma variavel no swift
         também náo é necessario terminar a instrucao com ; a menos que esteja executando 2 funcoes a mesmo tempo (caso abaixo comentado)
         caso uma variavel tenha um valor imutavel, é uma variavel final e deve ser declarada com let e nao var
         var name:String = "eggyplant-brownnie";
         var hapiness:String = "5";
         usase o \(variavel) para concatenar
         maneiras de declarar
         var nome = "meu nome" - variável explicita
         var nome:String = "meu nome" - variavel explícita
         let nome = "meu nome" - variavel final
         quando a variavel é imutável, por questao de boas práticas é declarada como let*/
        
        
        /*
         
         
         metodo 1, libera geral!, ! para poder acessar a variavel, porem caso no campo de Int se o usuario digitar uma String, a aplicacao ira crashar!!!
         
         
         let name:String! = nameField.text!
         let hapiness:Int! = Int(hapinessField.text!)
         
         let meal = Meal(name: name, hapiness: hapiness)
         
         print ("eaten \(meal.name) with hapiness \(meal.hapiness)!")
         */
        
        
        /*
         let name:String! = nameField.text!
         
         //metodo 2, utilizando ? no lugar de !, para que o swift nao compile a aplicacao e nos force a fazer uma verificacao antes de acessar o valor
         
         //verificaco simples poderia ser um if let.... ou como no exemplo abaixo
         let hapiness:Int? = Int(hapinessField.text!)
         
         if (hapiness == nil){
         return
         }
         //apos fazer a verificacao adiciona ! na variavel hapiness na linha abaixo
         let meal = Meal(name: name, hapiness: hapiness!)
         
         print ("eaten \(meal.name) with hapiness \(meal.hapiness)!")
         */
        
        //1 opcao < segunda opcao < 3 opcao
        
        
        //3 opcao, uso do if let
        
        /* if(hapinessField == nil || nameField == nil){
         return
         }
         
         let name:String = nameField!.text!
         
         //if let já extrai o valor de um optional e devolve um optional?
         //pode-se explicitar a variavel hapinnes caso queira...
         if let hapiness = Int(hapinessField!.text!){
         
         
         let meal = Meal(name: name, hapiness: hapiness, items: selected)
         
         print ("eaten \(meal.name) with hapiness \(meal.hapiness)! with \(meal.items)")*/
        
        //if (delegate == nil){
        // return
        //}
        // meal : meal -> deve-se informar qual o nome do argumento meal : meal
        // no metodo add foi incluido _ na frente do nome do parametro, tornando-se desnecessario informar o nome do argumento
        //delegate!.add(meal)
        
        if let meal:Meal = getMealFromForm(){
            
            if let meals = delegate {
                
                meals.add(meal)
                // criar variavel navigation do tipo navigationController para navegar entre telas
                //chamar metodo pop
                //metodo push serve para empilhar telas, pop para desempilhar
                
                if let navigation = navigationController{
                    navigation.popViewController(animated: true)
                    return
                }else{
                    Alert(controller: self).show(message: "Unable to go back, but the meal was added.")
                }
                //early return
                return
            }
        }
        Alert(controller: self).show()
        
        
        
        /*}*/
        
    }
    
    func convertToInt(_ text:String?) -> Int? {
        if let number = text {
            return Int(number)
        }
        return nil
    }
    
    func getMealFromForm() -> Meal? {
        
        /* if let nameF:UITextField = nameField{
         let nameT:String? = nameF.text
         if let name:String = nameT {
         
         }
         }*/
        
        
        if let name = nameField?.text {
            if let hapiness = convertToInt(hapinessField?.text){
                let meal = Meal(name: name, hapiness: hapiness, items: selected)
                print ("eaten \(meal.name) with hapiness \(meal.hapiness)! with \(meal.items)")
                return meal
            }
            
        }
        
        return nil
        
        
        /*if (nameField == nil || hapinessField == nil){
         return nil
         }
         
         let name:String = nameField!.text!
         
         if let hapiness = Int(hapinessField!.text!){
         let meal = Meal(name: name, hapiness: hapiness, items: selected)
         print ("eaten \(meal.name) with hapiness \(meal.hapiness)! with \(meal.items)")
         return meal
         }
         return nil*/
    }
    
}

extension ViewController : UITableViewDataSource , UITableViewDelegate{
    //retorna tamanho da tabela
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    //adiciona elementos a serem visualizados na tabela
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let item = items[row]
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: nil)
        cell.textLabel!.text = item.name
        
        
        
        return cell
    }
    //marcar em lista com checkmark
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath){
            
            if (cell.accessoryType == UITableViewCell.AccessoryType.none){
                cell.accessoryType = UITableViewCell.AccessoryType.checkmark
                let item = items[indexPath.row]
                selected.append(item)
                
            } else{
                cell.accessoryType = UITableViewCell.AccessoryType.none
                let item = items[indexPath.row]
                //metodo lastIndex retorna a ultima posicao que contem o objeto informado (item)
                if let position = selected.lastIndex(of: item){
                    
                    selected.remove(at: position)
                } else{
                    Alert(controller: self).show()
                }
                
            }
            
        } else{
            Alert(controller: self).show()
        }
        
    }
    
}
*/

var name = 0
print(name)

