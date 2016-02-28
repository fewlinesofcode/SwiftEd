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
		let currentConfiguration = NSBundle.mainBundle().objectForInfoDictionaryKey("Config")!
		print(currentConfiguration)
		let path = NSBundle.mainBundle().pathForResource("Config", ofType: "plist")!
		configs = NSDictionary(contentsOfFile: path)!.objectForKey(currentConfiguration) as! NSDictionary
	}
}

extension Config {
	func apiEndpoint() -> String {
		return configs.objectForKey("APIEndpointURL") as! String
	}
	
	func loggingLevel() -> String {
		return configs.objectForKey("loggingLevel") as! String
	}
}
