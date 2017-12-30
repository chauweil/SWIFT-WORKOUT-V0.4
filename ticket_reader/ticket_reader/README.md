#  Receipt scanner & management

### Configuration des droits dans la fiche produit Info.plist

On peut utiliser la caméra et aux photos. Il faut l'ajouter dans Info.plist et 
```
<key>NSCameraUsageDescription</key>
<string>This app will use camera.</string>
<key>NSPhotoLibraryAddUsageDescription</key>
<string>You can select photos to attach to reports.</string>
```
Et cette commande pour les requêtes sans http
```
<key>NSAppTransportSecurity</key>
<dict>
<key>NSAllowsArbitraryLoads</key>
<true/>
</dict>
```
### Installation de alamofire pour effectuer les requêtes API

Créer un fichier Podfile: se placer dans le répertoire dans lequel se trouve le fichier .xcodeproj et faire en ligne de commande=

```
pod init
```

Ouvrir le fichier Podfile en tapant cette ligne de commande

```
open -a Xcode Podfile
```
Ajouter cette ligne dans le pod file
```
pod 'Alamofire', '~> 4.5'
```
Il devrait contenir ces lignes dorénavent :
```
# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'ticket_reader' do
# Comment the next line if you're not using Swift and don't want to use dynamic frameworks
use_frameworks!

# Pods for ticket_reader
pod 'Alamofire', '~> 4.5'
end

```
Installer le tout en tapant cette ligne de commande

```
pod install

```
S'il le faut, faire un pod update

```
pod update
```
En cas d'ajout de pod, il  faut juste ajouter la ligne qu'il faut et faire également un
```
pod install

```


Il faut maintenaint ouvrir le fichier à travers le fichier ```.xcworkspace``` et plus le fichier ```.xcodeproj```.

### Documentation

Concernant le framework utilisé:
https://developer.apple.com/documentation/uikit/uiimagepickercontroller

Concernant les liens utiles:
https://stackoverflow.com/questions/40854886/swift-take-a-photo-and-save-to-photo-library

### Service: requête API

###### Ce bout de code permet de réccupérer des données encodées en BASE64 (image) et de le restituer


```
func getAPI() {
                let url = URL(string: "http://vps447991.ovh.net:5000/im")
                var request = URLRequest(url: url!)
                request.httpMethod = "GET"

                let task=URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error != nil
                {print("error")}
                else{
                        if let content = data {
                                                do {
                                                                let myjson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject!

                                                                let serie = myjson as! NSDictionary
                                                                let ee:String = serie.value(forKey:"im") as! String
                                                                let dataDecoded : Data = Data(base64Encoded: ee, options: .ignoreUnknownCharacters)!
                                                                let decodedimage = UIImage(data: dataDecoded)
                                                                self.imageTake.image  = decodedimage

                                                                }
                                                catch{print("bug")}

                                                }

                        }
                }
                task.resume()
}
```
###### La documentation officielle sur les requêtes http 
https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory

