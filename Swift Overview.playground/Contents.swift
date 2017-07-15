//------------------------------------------------------------------------------------------------------------------------------------------------------

// Created By Endor Express : a quick overview of Swift and must-know

//------------------------------------------------------------------------------------------------------------------------------------------------------

import UIKit
import CoreData

//------------------------------------------------------------------------------------------------------------------------------------------------------

// define variables

//------------------------------------------------------------------------------------------------------------------------------------------------------

var  str = "Hello World en déclaration usuelle"
var  str2 : String = "Hello World en déclaration typée"
let  str3 = "pas mutable"

str+=", et ils sont mutables"
print(str);
print(str2)


//------------------------------------------------------------------------------------------------------------------------------------------------------

// array and dictionnary

//------------------------------------------------------------------------------------------------------------------------------------------------------

var arr : [Int] = []
arr.append(1)
arr.append(2)
print(arr)

for i in arr
    {print(i)}

//------------------------------------------------------------------------------------------------------------------------------------------------------

// understand delegation

//-----------------------------------------------------------------------------------------------------------------------------------------------------


protocol saver{
    func caller(_ data :String) -> String
}
protocol ended {
    func passData(_ data: String)
}

class serie:saver{
        var exercice: String?
        var rep: Int?
        func caller(_ data :String)-> String { let exo=exercice!;return("Done"+exo) }
        var delegate :ended?
    var fauxdelegate :user?

    // caller : bug si on ajoute pas la function du protocole
    // _ pour ne pas avoir déclarer 
    // ! pour unwrapper une valeur
        }


class user:ended{
    
    init(_ nom: String){
    email=nom
    }
    
    var email: String?
    func printer(){print("Done printer")}
    func passData(_ data: String){let user=email! ; print( user+" a fini sa série")}

}

// Création des clases
var serie1=serie()
serie1.exercice="Pompe"
serie1.rep=30
var res:String=serie1.caller("Ok")
print(res)

var jeff=user("Jeff QIN")

// J'ai une vie du délégué 
serie1.delegate=jeff
let emailer = serie1.delegate!
emailer.passData("ee")

// Je n'ai pas besoin de délégué réellement mais ici, je peux changer la valeur de jeff ce qui est mauvais...la délégation sert juste à mieux scoper l'accès aux variables. 


serie1.fauxdelegate=jeff
var res2=serie1.fauxdelegate!.email!
print(res2)

serie1.fauxdelegate!.email="Qin Yue"
var res3=serie1.fauxdelegate!.email!
print(res3)
print(jeff.email!)

// La conclusion est que la délégation évite de passer les références d'une classe..trop dangeureux. 

