Pod::Spec.new do |s|
  s.name         = "Encrypted-Core-Data"
  s.version      = "1.1"
  s.summary      = "Field-Level AES256 Encryption for Core Data"

  s.description  = <<-DESC
                    Proof of Concept for attribute-level, on-the-fly, passive encryption with Core Data.

                    - Encrypts object attributes with AES256
                    - Uses CommonCrypto for Encryption/Decryption
                    - All encryption is done passively (without any extra method calls)
                    - Once files are added, encryption can be set up on an attribute in the  XCode GUI
                    - No Cryptography knowledge needed to use in projects
                    
                    The project uses NSValueTransformer subclasses to encrypt entity attributes before they are saved into the Core Data sqlite database. The attributes are decrypted automatically when the object is fetched back. You can manipulate the Core Data entities normally, as the encryption will be done behind the scenes.
                   DESC

  s.homepage     = "http://davidbenko.me"
  s.license      = "MIT"
  s.author             = { "David Benko" => "dbenko@prndl.us" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/DavidBenko/Encrypted-Core-Data.git", :tag => "1.1" }
  s.source_files  = "EncryptedCoreData/EncryptedCoreData/Crypto/**/*.{h,m}", "EncryptedCoreData/EncryptedCoreData/Random Data/**/*.{h,m}"
  s.frameworks = "Security", "CoreData"
  s.requires_arc = true
end
