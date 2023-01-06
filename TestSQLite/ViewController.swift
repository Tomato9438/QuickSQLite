//
//  ViewController.swift
//  TestSQLite
//
//  Created by Tomato on 2021/04/24.
//

import UIKit

class ViewController: UIViewController {
	// MARK: - Variables
	var optionFile = String()
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		optionFile = folderPath(s: 0, name: "UserOptions")
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		/* user options */
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
		if !appDelegate.defaultFileManager.fileExists(atPath: optionFile) {
			UserOptions.createData(path: optionFile)
		}
		
		let opt6 = UserOptions.readData(path: optionFile, field: "Value6")
		let opt7 = UserOptions.readData(path: optionFile, field: "Value7")
		print("Opt6: \(opt6) Opt7: \(opt7)")
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		//UserOptions.updateData(path: optionFile, field: "Value6", value: "182104301701")
		//UserOptions.updateData(path: optionFile, field: "Value7", value: "546488855")
	}
	
	// MARK: - Functions 1: Files
	func documentPath() -> String {
		let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
		let documentsDirectory = paths.first! as NSString
		return documentsDirectory as String
	}
	
	func libraryPath() -> String {
		let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
		let libraryDirectory = paths.first! as NSString
		return libraryDirectory as String
	}
	
	func folderPath(s: Int, name: String) -> String {
		if s == 0 {
			let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
			let documentsFolder = paths.first! as NSString
			let path = documentsFolder.appendingPathComponent(name)
			return path
		} else {
			let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
			let libraryFolder = paths.first! as NSString
			let path = libraryFolder.appendingPathComponent(name)
			return path
		}
	}
}

