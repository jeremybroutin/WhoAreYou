//
//  ResultsViewController.swift
//  WhoAreYou
//
//  Created by Jeremy Broutin on 2/6/17.
//  Copyright © 2017 Jeremy Broutin. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
	
	@IBOutlet var quizView: UIView!
	@IBOutlet var resultView: UIView!
	@IBOutlet var resultTitleLabel: UILabel!
	@IBOutlet var resultDescLabel: UILabel!

	
	// Variable to get results
	var currentResults: [String] = []
	var currentPoints: [Int] = []
	
	// Prepare content
	var resultTitles = [
		"Passionate crazy",
		"Lazy player",
		"Control freak"
	]
	var resultContents = [
		"You are a people person, and really don't like to spend time alone. Your family and friends are everything to you and you would always put them first. You are an energetic person, who usually like to talk... A LOT!. You don't trust people who don't openly speak their mind, but will always try to get their opinions anyway, because you value everyone in the room.",
		"You are a lazy ass but in a smart way. You always measure the necessity of accomplishing a task before jumping into it, and always check if someone else can take it on instead (after all, why do it all right?!). You can definitely be put under the spotlight and you would probably nail it, but again: only in absolute necessity. You love your own fun time over the seriousness of this world.",
		"You are methodic, organized, and tend to put emotions aside: kind of like a robot! If people appreciate working with you thanks to your leadership and process oriented decisions, they often reproach you a lack of creativity, flexibility and even... a lack of FUN. You would not openly express your feeling but you do value people and relationships, you will always be there to help fix your friends or family problem. However, you are definitely not there to hear them complaining without thinking about solutions!"
	]
	
	// MARK: - View Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Basic check
		if resultTitles.count != resultContents.count {
			fatalError("resultTitles and resultContents arrays must be of the same size")
		}
		
		// Set basic UI
		setShadows(views: [quizView,resultView])
		
		// Get score and show results
		let totalPoints = calculatePoints(points: currentPoints)
		showResults(points: totalPoints)
		
	}
	
	// MARK: - IBActions
	
	@IBAction func startAgainTapped(_ sender: RaisedButton) {
		
		// Get back to the root view controller
		performSegue(withIdentifier: SegueIDs.Root.rawValue, sender: sender)
		
	}
	
	// MARK: - Helper methods
	
	func setShadows(views: [UIView]) {
		
		for view in views {
			view.layer.shadowColor = UIColor.black.cgColor
			view.layer.shadowOpacity = 0.3
			view.layer.shadowOffset = CGSize(width: 0.2, height: 0.5)
			view.layer.shadowRadius = 3
		}
	}
	
	func calculatePoints(points: [Int]) -> Int {
		return points.reduce(0, +)
	}
	
	func showResults(points: Int){
		
		// Show results based on the range of points
		switch points {
		case 5..<9:
			resultTitleLabel.text = resultTitles[2]
			resultDescLabel.text = resultContents[2]
		case 9..<12:
			resultTitleLabel.text = resultTitles[1]
			resultDescLabel.text = resultContents[1]
		case 12...15:
			resultTitleLabel.text = resultTitles[0]
			resultDescLabel.text = resultContents[0]
		default:
			break
		}
	}
	
}
