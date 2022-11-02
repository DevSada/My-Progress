//
//  CountdownViewController.swift
//  My Progress
//
//  Created by Alexander Petrenko on 28.10.2022.
//

import UIKit


class CountdownViewController: UIViewController {
    
    var progress: Time!
    var counterType: CounterViewTypes!
    var previousItem: UIView!
    var safeArea: UILayoutGuide!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// tmp
        progress = Time.getProgress()[4]
        counterType = .show
        
        
        // end tmp
        
        safeArea = view.safeAreaLayoutGuide
        previousItem = self.view
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        // MARK: Header
        
        if counterType == .show {
            let headerLabel = setHeadLabel()
            headerLabel.text = "Header_1"
            self.view.addSubview(headerLabel)
            NSLayoutConstraint.activate(getHeadLabelConstraint(to: headerLabel))
            
            let sublineLabel = setHeadLabel()
            sublineLabel.text = "Subline_1"
            self.view.addSubview(sublineLabel)
            NSLayoutConstraint.activate(getHeadLabelConstraint(to: sublineLabel))
        } else {
            let headerTextField = setHeadTextField()
            headerTextField.placeholder = "Text your goals here"
            self.view.addSubview(headerTextField)
            NSLayoutConstraint.activate(getHeadTextFieldConstraint(to: headerTextField))
            
            let sublineTextField = setHeadTextField()
            sublineTextField.placeholder = "Text your subgoals here"
            self.view.addSubview(sublineTextField)
            NSLayoutConstraint.activate(getHeadTextFieldConstraint(to: sublineTextField))
        }
        
        // MARK: Countdown View
        
        let countdownView = CountdownView().configure(progress: progress, frameView: self.view, counterType: counterType)
        let countdownConstraint = [
            countdownView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0),
            countdownView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            countdownView.topAnchor.constraint(equalTo: previousItem.topAnchor, constant: 0)
        ]
        countdownView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(countdownView)
        
        NSLayoutConstraint.activate(countdownConstraint)
        
        
        
        
        // MARK: StartedStack
        
        let startedLabel = setDetailsLabel(in: .start)
        self.view.addSubview(startedLabel)
        NSLayoutConstraint.activate(getDetailsLabelConstraint(to: startedLabel, in: .start))
        
        let endLabel = setDetailsLabel(in: .end)
        self.view.addSubview(endLabel)
        NSLayoutConstraint.activate(getDetailsLabelConstraint(to: endLabel, in: .end))
        
        
        // MARK: EndStack
        
        if counterType != .show {
            let startedTextField = setDetailsTextField(in: .start)
            startedTextField.placeholder = "Select start time"
            self.view.addSubview(startedTextField)
            NSLayoutConstraint.activate(getDetailsTextFieldConstraint(to: startedTextField, in: .start))
            
            let endTextField = setDetailsTextField(in: .end)
            endTextField.placeholder = "Select ending time"
            self.view.addSubview(endTextField)
            NSLayoutConstraint.activate(getDetailsTextFieldConstraint(to: endTextField, in: .end))
        }
        
        
        // MARK: Edit Button
        
        let editButton = setEditButton()
        self.view.addSubview(editButton)
        NSLayoutConstraint.activate(getEditButtonConstraint(to: editButton))
        
        
        
    }
    
    private func setHeadLabel() -> UILabel {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func setHeadTextField() -> UITextField {
        let textfield = UITextField(frame: .zero)
        textfield.textAlignment = .center
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }
    
    private func setDetailsLabel(in stack: CountdownTimeStacks) -> UILabel {
        let label = UILabel(frame: .zero)
        let attrs1 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : UIColor.green]
        var attributedString1 = NSMutableAttributedString(string:"STARTED\n", attributes:attrs1)
        if stack == .end {
            attributedString1 = NSMutableAttributedString(string:"WILL END\n", attributes:attrs1)
        }
        if counterType == .show {
            label.numberOfLines = 2
            let attrs2 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : UIColor.black]
            var attributedString2 = NSMutableAttributedString(string: progress.startDate, attributes:attrs2)
            if stack == .end {
                attributedString2 = NSMutableAttributedString(string: progress.finishDate, attributes:attrs2)
            }
            attributedString1.append(attributedString2)
        }
        label.attributedText = attributedString1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    
    private func setDetailsTextField(in stack: CountdownTimeStacks) -> UITextField {
        let textfield = UITextField(frame: .zero)
        
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }
    
    private func setEditButton() -> UIButton {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitle("Edit", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .green
        button.layer.cornerRadius = 15
        return button
        
    }
    
    
    
    // MARK: Header Constraints
    
    private func getHeadLabelConstraint(to label: UILabel) -> [NSLayoutConstraint] {
        let contraint = [
            label.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: previousItem.topAnchor, constant: 48)
        ]
        previousItem = label
        return contraint
    }
    
    private func getHeadTextFieldConstraint(to textField: UITextField) -> [NSLayoutConstraint] {
        let contraint = [
            textField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            textField.topAnchor.constraint(equalTo: previousItem.topAnchor, constant: 48)
        ]
        previousItem = textField
        return contraint
    }
    
    // MARK: Details Constraints
    
    private func getDetailsLabelConstraint(to label: UILabel, in stack: CountdownTimeStacks) -> [NSLayoutConstraint] {
        var contraint = [
            label.widthAnchor.constraint(equalToConstant: 170),
            label.topAnchor.constraint(equalTo: previousItem.topAnchor, constant: self.view.frame.width)
        ]
        if stack != .end {
            contraint.append(label.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16))
        } else {
            contraint.append(label.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16))
            previousItem = label
        }
        return contraint
    }
    
    private func getDetailsTextFieldConstraint(to textField: UITextField, in stack: CountdownTimeStacks) -> [NSLayoutConstraint] {
        var contraint = [
            textField.widthAnchor.constraint(equalToConstant: 150),
            textField.topAnchor.constraint(equalTo: previousItem.topAnchor, constant: 32)
        ]
        
        if stack != .end {
            contraint.append(textField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16))
        } else {
            contraint.append(textField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16))
            previousItem = textField
        }
        return contraint
    }
    
    // MARK: Edit Button Constraints
    
    private func getEditButtonConstraint(to button: UIButton) -> [NSLayoutConstraint] {
        let contraint = [
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.topAnchor.constraint(equalTo: previousItem.topAnchor, constant: 82)
        ]
        previousItem = button
        return contraint
    }
    
    
}

