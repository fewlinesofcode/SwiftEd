//
//  ViewController.swift
//  MultiEnvSample
//
//  Created by Aleksandr Glagoliev on 2/21/16.
//  Copyright © 2016 io.limlab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		print(Config.sharedInstance.apiEndpoint())
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

