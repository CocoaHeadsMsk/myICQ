//
//  FirstViewController.swift
//  myICQ
//
//  Created by Alexandr Sergeev on 28.06.14.
//  Copyright (c) 2014 alxsrg.com. All rights reserved.
//

import UIKit

class FirstViewController: UITableViewController {
                            
	override func viewDidLoad() {
		super.viewDidLoad()
		MessageManager.sharedInstance().addIncomingMessageObserver(){ messages in
			for msg:Message in messages {

			}
		}
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

