import Foundation

/*struct BirdId {
    var text = "Hello, World!"
}
*/
//
//  Seed.swift
//  BirdId
//
//  Created by Antonio Silva on 16/05/19.
//  Copyright © 2019 Antonio Silva. All rights reserved.
//

import UIKit


public class Seed: NSObject, NSCoding, Codable {

   // MARK: Types

   enum Keys {
       static let name: String = "name"
       static let issuer: String = "issuer"
       static let secret: String = "secret"
       static let timeBased: String = "timeBased"
       static let emissionServerIndex: String = "serverIndex"
   }

   // MARK: Parameters

   public var name: String?
   public var issuer: String?
   public var secretEncrypted: String?
   public var timeBased: Bool?

   /// The index of the emission server from which this seed belongs.
   public var emissionServerIndex: Int?

   // MARK: Initializers

   public init(name: String, issuer: String, secret: String, timeBased: Bool) {
       super.init()
       self.name = name
       self.issuer = issuer
       self.timeBased = timeBased
       
       /*guard let secretData = secret.base32ToData() else {
           return
       }*/
       
       //let security = Security()
       //let pin = ManagerPINSession.current.pin()
       self.secretEncrypted = secret    //security.encrypt(secret: secretData.bytes, pin: pin)
   }

   // MARK: NSCoding Implementation.
   
    public func encode(with aCoder: NSCoder) {
       aCoder.encode(self.name, forKey: Seed.Keys.name)
       aCoder.encode(self.issuer, forKey: Seed.Keys.issuer)
       aCoder.encode(self.secretEncrypted, forKey: Seed.Keys.secret)
       aCoder.encode(self.timeBased, forKey: Seed.Keys.timeBased)
       aCoder.encode(self.emissionServerIndex, forKey: Seed.Keys.emissionServerIndex)
   }
   
    required public init?(coder aDecoder: NSCoder) {
       if let name = aDecoder.decodeObject(forKey: Seed.Keys.name) as? String {
           self.name = name
       }
       
       if let issuer = aDecoder.decodeObject(forKey: Seed.Keys.issuer) as? String {
           self.issuer = issuer
       }
       
       if let secret = aDecoder.decodeObject(forKey: Seed.Keys.secret) as? String {
           self.secretEncrypted = secret
       }
       
       if let timeBased = aDecoder.decodeObject(forKey: Seed.Keys.timeBased) as? Bool {
           self.timeBased = timeBased
       }

       // Set zero as the default index, in case the server isn't defined.
       emissionServerIndex = (aDecoder.decodeObject(forKey: Seed.Keys.emissionServerIndex) as? Int) ?? 0
   }

   // MARK: Codable Implementation
   
   enum CodingKeys: String, CodingKey {
       case name
       case issuer
       case secretEncrypted
       case timeBased
       case emissionServerIndex
   }

    required public init(from decoder: Decoder) throws {
       let container = try decoder.container(keyedBy: CodingKeys.self)

       name = try container.decode(String?.self, forKey: CodingKeys.name)
       issuer = try container.decode(String?.self, forKey: CodingKeys.issuer)
       secretEncrypted = try container.decode(String?.self, forKey: CodingKeys.secretEncrypted)
       timeBased = try container.decode(Bool?.self, forKey: CodingKeys.timeBased)

       // Set zero as the default index, in case the server isn't defined.
       emissionServerIndex = try? container.decode(Int?.self, forKey: CodingKeys.emissionServerIndex) ?? 0
   }
}

/*extension Seed {

   override func isEqual(_ object: Any?) -> Bool {
       guard let otherSeed = object as? Seed else {
           return false
       }

       return otherSeed.name == name &&
        otherSeed.issuer == issuer &&
        otherSeed.secretEncrypted == secretEncrypted &&
        otherSeed.timeBased == timeBased
   }
}
*/
