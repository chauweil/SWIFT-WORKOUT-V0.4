//------------------------------------------------------------------------------------------------------------------------------------------------------

// Created By Endor Express : a quick overview of Swift and must-know

//------------------------------------------------------------------------------------------------------------------------------------------------------

import UIKit
import CoreData
import Foundation

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

// array

//------------------------------------------------------------------------------------------------------------------------------------------------------

var arr : [Int] = []
arr.append(1)
arr.append(2)
print(arr)

for i in arr
    {print(i)}

//------------------------------------------------------------------------------------------------------------------------------------------------------

//dictionnary

//------------------------------------------------------------------------------------------------------------------------------------------------------

var dico = [Int: String]()
dico[1]="numero 1"
dico[2]="numero 2"
print(dico)
print(dico[1]!)


struct xyz
    {
        var x = Float()
        var y = Float()
        var z = Float()
    }

var data:[xyz] = []

var gps = xyz()
gps.x=1
gps.y=1
gps.z=1

data.append(gps)


gps.x=2
gps.y=2
gps.z=2

data.append(gps)

var data3 = ["x": [1,2,3],"y":[3,4,5],"z":[3,4,5]]
data3["x"]?.append(4)
let data2 =  try JSONSerialization.data(withJSONObject: data3, options:[])
let decoded = try JSONSerialization.jsonObject(with: data2, options: [])
print(decoded)

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



protocol sentResume{
    func Montant () -> Int
}

class Boss {
    var bill:Bool?
    var secretaryDelegate : sentResume?
    func bilan(){
    var resultat=self.secretaryDelegate?.Montant()
        if(resultat!<30){print("Ok, je paye")}
        if(resultat!>30){print("Non, je ne paye pas")}

    }
}

class Secretary : sentResume{
    var Amount1 : Int?
    var Amount2 : Int?
    func Montant() -> Int {var total = Amount1!+Amount2!;return (total)}
}


var Jeff = Boss()
var Yue = Secretary()
Yue.Amount1=14
Yue.Amount2=9

Jeff.secretaryDelegate=Yue
var resultat=Jeff.secretaryDelegate?.Montant()
print(resultat!)

Jeff.bilan()

Yue.Amount1=14
Yue.Amount2=17

Jeff.bilan()


// Surtout elle permet a une classe A et B d'échanger des informations entre eux dans un sens unique. En fonction de ce que renvoie B, la classe A prend des actions

// En pratique, les UIViews, demandent à la classe de compiler les informations pour savoir comment ils doivent réagir

