import Foundation

// protocolo deve conter as funcoes que serao usadas nos controllers
// protocolo de comunicacao entre as viewcontroller
//interface de comunicacao entre as pontas, com intuito de que o viewcontroller nao precise saber necessariamente quem o observer esta notificando
// protocolo fica ouvindo eventos -> padrao do observer
// a ideia do observer nao é saber quem esta notificando mas saber que pode notificar

protocol AddAMealDelegate {
    
    func add(_ meal : Meal)
}

