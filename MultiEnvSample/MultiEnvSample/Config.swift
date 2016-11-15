//
//  Config.swift
//  MultiEnvSample
//
//  Created by Aleksandr Glagoliev on 2/22/16.
//  Copyright © 2016 io.limlab. All rights reserved.
//

import UIKit

class Config: NSObject {
	static let sharedInstance = Config()
	
	var configs: NSDictionary!
	
	override init() {
		let currentConfiguration = Bundle.main.object(forInfoDictionaryKey: "Config")!
		print(currentConfiguration)
		let path = Bundle.main.path(forResource: "Config", ofType: "plist")!
		configs = NSDictionary(contentsOfFile: path)!.object(forKey: currentConfiguration) as! NSDictionary
        print(configs)
	}
}

extension Config {
	func apiEndpoint() -> String {
		return configs.object(forKey: "APIEndpointURL") as! String
	}
	
	func loggingLevel() -> String {
		return configs.object(forKey: "loggingLevel") as! String
	}
}
