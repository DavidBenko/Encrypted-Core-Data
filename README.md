Encrypted Core Data
=========

Proof of Concept for attribute-level, on-the-fly, passive encryption with Core Data.

  - Encrypts object attributes with AES256
  - Uses CommonCrypto for Encryption/Decryption
  - All encryption is done passively (without any extra method calls)
  - Once files are added, encryption can be set up on an attribute in the XCode GUI
  - No Cryptography knowledge needed to use in projects

The project uses [NSValueTransformer] subclasses to encrypt entity attributes before they are saved into the Core Data sqlite database. The attributes are decrypted automatically when the object is fetched back. You can manipulate the Core Data entities normally, as the encryption will be done behind the scenes.


Installation
--------------

##### Add the following folders to your project

* Crypto
* Random Data

##### Set the following options on your Entity attributes

* Set `Attribute Type` to `Transformable`
* Set `Name` to `NSStringEncryptionTransformer`

License
----

MIT


[NSValueTransformer]:https://developer.apple.com/library/mac/documentation/cocoa/reference/foundation/Classes/NSValueTransformer_Class/Reference/Reference.html
