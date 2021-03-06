//
//  CompletedGoalViewController.swift
//  OnePercentWin
//
//  Created by David on 26/1/19.
//  Copyright © 2019 David Lam. All rights reserved.
//

import UIKit

final class CompletedGoalViewController: UIViewController, NotesEntryViewControllerPresenter {
    @IBOutlet private weak var congratulationsLabel: UILabel!
    @IBOutlet private weak var congrulationsSubtitleLabel: UILabel!
    @IBOutlet private weak var goalPrompt: UILabel!
    @IBOutlet private weak var reasonPrompt: UILabel!
    @IBOutlet private weak var lessonsLearntPrompt: UILabel!
    @IBOutlet private weak var lessonsLearntLabel: UILabel!
    @IBOutlet private weak var imageViewHolder: UIView!
    @IBOutlet private weak var addLessonLearntButton: UIButton!
    @IBOutlet private weak var stackViewHolder: UIStackView!
    
    var goal: DailyGoal! {
        didSet {
            if viewModel == nil {
                viewModel = CompletedGoalViewModel(goal: goal)
            }
            viewModel.goal = goal
        }
    }
    var viewModel: CompletedGoalViewModel!
    
    @IBAction func didPressAddNotes(sender: Any) {
        presentNotesEntryViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CompletedGoalViewModel(goal: goal)
        styleElements()
        applyBackgroundColor()
    }
    
    func setup(with goal: DailyGoal) {
        self.goal = goal
        
        if let notes = goal.notes {
            lessonsLearntLabel.isHidden = false
            lessonsLearntPrompt.isHidden = false
            lessonsLearntLabel.text = notes
            addLessonLearntButton.setTitle("Edit Notes", for: .normal)
        } else {
            lessonsLearntLabel.isHidden = true
            lessonsLearntPrompt.isHidden = true
            lessonsLearntLabel.text = nil
            addLessonLearntButton.setTitle("Add Notes", for: .normal)
        }
        congratulationsLabel.text = viewModel.mainLabel
        congrulationsSubtitleLabel.text = viewModel.subtitle
        lessonsLearntPrompt.text = viewModel.lessonLearntPrompt
        
        goalPrompt.attributedText = viewModel.goalPromptAttributedText
        reasonPrompt.attributedText = viewModel.reasonPromptAttributedText
        imageViewHolder.isHidden = !viewModel.goal.isCompleted
    }
    
    private func presentNotesEntryViewController(goal: DailyGoal) {
        let sb = UIStoryboard(name: "NotesEntry", bundle: Bundle.main)
        guard let vc = sb.instantiateViewController(withIdentifier: "NotesEntryViewController") as? NotesEntryViewController else {
            fatalError("view controller not found")
        }
        vc.delegate = self
        vc.goal = goal
        present(vc, animated: true)
    }
    
    func styleElements() {
        congratulationsLabel.applyBoldFont(fontSize: .large)
        congrulationsSubtitleLabel.applyFont(fontSize: .large)
        
        let orange = ThemeHelper.defaultOrange()
        
        goalPrompt.attributedText = viewModel.goalPromptAttributedText
        reasonPrompt.attributedText = viewModel.reasonPromptAttributedText
        
        lessonsLearntPrompt.applyFont(fontSize: .medium)
        lessonsLearntLabel.applyFont(fontSize: .medium, color: orange)
        addLessonLearntButton.applyStyle()
    }
    

}

extension CompletedGoalViewController: NotesEntryViewControllerDelegate {
    func userDidAbortNoteTaking() {
        dismiss(animated: true)
    }
    
    func userDidSaveNotes() {
        dismiss(animated: true)
    }
}
