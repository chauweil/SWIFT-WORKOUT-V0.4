# SWIFT-WORKOUT-V0.3

## Install pods

### install cocoa pods

sudo gem install cocoapods
pod setup --verbose

### install pods
get to where the .xcode project is with cd
pod init
open -a Xcode Podfile

### write these lines in the Podfile
pod 'Charts'
pod 'RealmSwift'

### write these lines in the Podfile
pod install
