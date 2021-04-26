import UIKit

// NÚMERO RANDOMICOS

//forma antiga
let numeroRandomico = Int(arc4random_uniform(10))
print(numeroRandomico)
//atualizacao na sintaxe
let novoNumero = Int.random(in: 0..<10)
print(novoNumero)

// SORTEAR OBJETO RANDOMICO

let listaDeMusicas = ["Fear of the dark", "Mistreated", "Smell like Teen Spirit", "You could be mine", "Always with me, Always with you" ]

//detalhe para impressao que sairá como optional.. para resolver  tratar erro etc...
print(listaDeMusicas.randomElement())

// ALTERNAR VALORES VARIAVEIS BOOLEANAS

// exemplo de uma seleçao em uma tableView, estamos pintando a linha selecionada e alterando uma booleana da classe

extension ListaMusicasViewController : UITableViewDelegate{
    
    func tableView (_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let musicaSelecionada = listaDeMusicas[indexPath.row]
        
        // maneira antiga... negar o estado anterior
        //musicaSelecionada.estaSelecionado = !musicaSelecionada.estaSelecionado
        // maneira nova.. uso do toggle
        //toggle alterna o valor.. igual no cs hehehe
        //musicaSelecionada.estaSelecioado.toggle()
        tableView.reloadData()
        
        // alterando o background na funcao cellForRowAr (metodo que exibe nossa celula com os dados)
        
        celula.backgroundColor = musica.selecionado ? UIColor.cyan : UIColor.white
        
    }
}

// EMBARALHAR ELEMENTOS LISTA

func carregaMusicas() {
    //metodo shuffled embaralha nossa lista caso desejarmos
    listaDeMusicas = Musica.getMusicas().shuffled()
    musicaTableView.reloadData()
}

