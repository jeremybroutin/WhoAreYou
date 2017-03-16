//
//  Q2ViewController.swift
//  WhoAreYou
//
//  Created by Jeremy Broutin on 2/4/17.
//  Copyright © 2017 Jeremy Broutin. All rights reserved.
//

import UIKit

class Q2ViewController: UIViewController {
	
	@IBOutlet var quizView: UIView!
	@IBOutlet var questionView: UIView!
	@IBOutlet var questionLabel: UILabel!
	@IBOutlet var answer1Button: UIButton!
	@IBOutlet var answer1Label: UILabel!
	@IBOutlet var answer2Button: UIButton!
	@IBOutlet var answer2Label: UILabel!
	@IBOutlet var answer3Button: UIButton!
	@IBOutlet var answer3Label: UILabel!
	
	@IBOutlet var nextButton: UIButton!
	@IBOutlet var previousButton: RaisedButton!
	
	// Variable to get and pass results
	var currentResults: [String] = []
	var currentPoints: [Int] = []
	
	let question = "Speaking in public for you is..."
	let answers = [
		"A difficult exercice which you would gladly escape from",
		"Something you enjoy and don't refrain from",
		"An optional task if no one else is available"
	]
	
	var answersButtons: [UIButton]!
	var answersLabels: [UILabel]!
	var selectedAnswer: String!
	var answerPoints: Int!
	
	// MARK: - View Life Cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Set basic UI
		setShadows(views: [quizView,questionView])
		
		// Create arrays of buttons and labels for selection
		answersButtons = [answer1Button, answer2Button, answer3Button]
		answersLabels = [answer1Label, answer2Label, answer3Label]
		
		// Set question and answers labels texts
		setContent()
		
		// Set buttons restorationIDs
		setButtonsRetorationIds(buttons:answersButtons)
		
		// Disable next button until an answer is selected
		nextButton.isEnabled = false
		
		// Hide back button (use Previous instead)
		self.navigationItem.hidesBackButton = true
		
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let vc = segue.destination as? Q3ViewController {
			guard let answer = selectedAnswer, let points = answerPoints else { return }
			currentResults.append(answer)
			currentPoints.append(points)
			vc.currentResults = currentResults
			vc.currentPoints = currentPoints
		}
	}
	
	// MARK: - IBActions
	
	@IBAction func answerSelected(_ sender: UIButton) {
		
		// Highlight related answer if a button restoration id exists
		if let id = sender.restorationIdentifier {
			highlightAnswer(restorationID: id)
		}
		
		// Enable next button
		nextButton.isEnabled = true
	}
	
	@IBAction func nextTapped(_ sender: UIButton) {
		performSegue(withIdentifier: SegueIDs.Next.rawValue, sender: sender)
	}
	
	@IBAction func previousTapped(_ sender: UIButton) {
		
		// Remove last points to avoid over counting
		let _ = currentPoints.popLast()
		
		// Go back to previous question
		let _ = navigationController?.popViewController(animated: true)
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
	
	func setContent(){
		questionLabel.text = question
		if answers.count == answersLabels.count {
			for i in 0..<answers.count {
				answersLabels[i].text = answers[i]
			}
		} else {
			fatalError("Answers array is not the same size as AnswersLabels array")
		}
	}
	
	func setButtonsRetorationIds(buttons: [UIButton]){
		
		// Set a restoration id for each button in the array starting from 0
		for i in 0..<buttons.count {
			buttons[i].restorationIdentifier = String(i)
		}
	}
	
	func highlightAnswer(restorationID id: String){
		
		// Get button identifiers
		if let index = Int(id){
			
			// Loop through the arrays of Buttons and Labels
			for i in 0..<answersButtons.count{
				
				// Find the elements matching the button id
				if i == index {
					
					// Highlight selected
					answersButtons[i].isSelected = true
					answersLabels[i].isHighlighted = true
					
					// Update the selected answer
					selectedAnswer = answersLabels[i].text
					switch i {
					case 0:
						answerPoints = 1
					case 1:
						answerPoints = 3
					default:
						answerPoints = 2
					}
				} else {
					
					// Un highlight others
					answersButtons[i].isSelected = false
					answersLabels[i].isHighlighted = false
				}
			}
		}
	}
	
}
