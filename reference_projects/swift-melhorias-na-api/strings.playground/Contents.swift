import UIKit




var texto = "Vamos começar a estudar as novidades de Swift!!!"

//metodo antigo para separar strings
//este exemplo removemos os !!! do texto da variavel
/*
let indice = texto.index(texto.endIndex, offsetBy: -3)

var textoFormatado = texto.substring(to: indice)

print(textoFormatado)
*/

//nova maneira
print(texto.filter({$0 != "!"}))

let listaDeNomes = [ "Rafael", "Janaina", "Lorena", "Thamirys"]

listaDeNomes.forEach({
    print($0)
})

//texto.forEach {
 //   print($0)
//}

//grande mudança: trabalhar com strings é a mesma coisa que trabalhar com arrays
//temos acesso aos mesmos métodos


let nomes = ["Ana", "Gabriel", "Caio", "Juliana"]
print(nomes.count)


//quebrar a linha apos cada ponto final
let mensagem =  "A linguagem Swift é uma linguagem muito moderna e intuitiva.\n Estamos aprendendo as principais novidades da linguagem.\n Começamos com as novidades na API de dicionários.\n E nessa aula estamos aprendendo sobre Strings."

print(mensagem.count)

for charactere in mensagem {
    print(charactere)
}



print(mensagem)

//quebrar a linha apos cada ponto final (novo metodo)
let novaMensagem = """
A linguagem Swift é uma linguagem muito moderna e intuitiva
Estamos aprendendo as principais novidades da linguagem.
    Começamos com as novidades na API de dicionários.
Nessa aula estamos aprendendo sobre strings.
"""
print(novaMensagem)

//principal novidade continua sendo que podemos trabalhar com Strings da mesma forma que com Arrays


