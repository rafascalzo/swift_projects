import UIKit

//dicionario de string-string
//key = chave = String
//value = valor = String
// merge em dicionarios
var alunos = [
    "Rafael": "Swift",
    "Mario" : "Java",
    "Heidi" : "Android",
    "Letícia": "C#",
    "Lorena":"Node JS",
    "Janaina":"c++"
]

let novosAlunos = [
    "Yudi": "JavaScript",
    "Caio" : "Android",
    "Julia": "Assembly",
    "Janaina" : "React  Native",
    "Rebecca" : "C"
]

/*1 forma, com um foreach
novosAlunos.forEach({
    //print($0)
    if !alunos.keys.contains($0.key){
        alunos[$0.key] = $0.value
    }
})
*/

/*2 forma, utilizando o merge priorizando o dicionario mais antigo
 alunos.merge(novosAlunos) { (alunos, _ ) -> String in
 alunos
 }
 */

//3 forma, utilizando o merge priorizando o dicionario mais novo
alunos.merge(novosAlunos) { (_ , novosAlunos ) -> String in
    novosAlunos
}

//print(alunos)

// estrutura String - Array<String>
var dicionario = [
    "A" : ["Amanda", "Adriano", "Augusto"], "B" : ["Bruna", "Batoré"]
]

// o mesmo que
var dicionarioDeNomes : [String : [String]] = [:]

// forma mais comum para este tipo de problema, agrupando dicionarios

for aluno in alunos {
    if let charachter = aluno.key.first{
        let prefixo = String(charachter)
        if var listaDeNomes = dicionarioDeNomes[prefixo]{
            listaDeNomes.append(aluno.key)
            dicionarioDeNomes[prefixo] = listaDeNomes
        }else{
            dicionarioDeNomes[prefixo] = [aluno.key]
        }
        
    }
}
//print(dicionarioDeNomes)

//melhoria na api para agrupar dicionarios
//numero passado por parametro representa a quantidade de caracteres do prefixo, no caso estamos agrupando pela primeira letra
let novoDicionarioDeNomes = Dictionary(grouping: alunos.keys, by:{ $0.prefix(1) })
//print(novoDicionarioDeNomes)


//para casos de comparar dicionario (dicionario com valores opcionais)
let alunosDeAlgoritimos = ["Amanda" : 7, "Adriano" : 10, "Bianca" : 6, "Janaina" : 10, "Matheus" : 8]
let alunosDeMatematica = ["Amanda" : nil, "Adriano" : 7, "Bianca" : 8, "Janaina" : 8, "Matheus" : 5]

//key = string
//value = int
// dicionario de  String:Int

//segundo dicionario
//key = String
//value = Int?

print(alunosDeAlgoritimos == alunosDeMatematica)

//agora é possivel comparar dicionarios
