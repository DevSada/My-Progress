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
//        progress = Time.getProgress()[4]
//        counterType = .show
        // end tmp
        
        safeArea = view.safeAreaLayoutGuide
        previousItem = self.view
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        // MARK: Header
        
        if counterType == .show {
            let headerLabel = setLabel()
            headerLabel.attributedText = NSMutableAttributedString(string: progress.goal, attributes: headerAttributes)
            self.view.addSubview(headerLabel)
            NSLayoutConstraint.activate(getHeadLabelConstraint(to: headerLabel))
            
            let sublineLabel = setLabel()
          //  sublineLabel.text = "Subline_1"
           // sublineLabel.font = sublineFont
            sublineLabel.attributedText = NSMutableAttributedString(string: progress.subGoal, attributes: sublineAttributes)
            self.view.addSubview(sublineLabel)
            NSLayoutConstraint.activate(getHeadLabelConstraint(to: sublineLabel))
        } else {
            let headerTextField = UITextField(frame: .zero)// = setHeadTextField()
            setTextField(for: headerTextField)
            headerTextField.placeholder = "Text your goals here"
            self.view.addSubview(headerTextField)
            NSLayoutConstraint.activate(getHeadTextFieldConstraint(to: headerTextField))
            
            //let sublineTextField = setHeadTextField()
            let sublineTextField = UITextField(frame: .zero)// = setHeadTextField()
            setTextField(for: sublineTextField)
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
            let startedTextField = UITextField(frame: .zero)
            setTextField(for: startedTextField)
            if counterType == .edit {
                startedTextField.placeholder = progress.startDate
            } else {
                startedTextField.placeholder = "Select ending time"
            }
            self.view.addSubview(startedTextField)
            NSLayoutConstraint.activate(getDetailsTextFieldConstraint(to: startedTextField, in: .start))
            

            let endTextField = UITextField(frame: .zero)
            setTextField(for: endTextField)
            if counterType == .edit {
                endTextField.placeholder = progress.finishDate
            } else {
                endTextField.placeholder = "Select ending time"
            }
            
            self.view.addSubview(endTextField)
            NSLayoutConstraint.activate(getDetailsTextFieldConstraint(to: endTextField, in: .end))
        }
        
        
        // MARK: Edit Button
        
        let editButton = setEditButton()
        self.view.addSubview(editButton)
        NSLayoutConstraint.activate(getEditButtonConstraint(to: editButton))
        
        
        
    }
    
    private func setLabel() -> UILabel {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func setTextField(for textfield: UITextField){
        textfield.textAlignment = .center
        textfield.layer.borderWidth = 1
        textfield.layer.cornerRadius = 10
        textfield.font = standartFont
        textfield.translatesAutoresizingMaskIntoConstraints = false
      
    }
    
    private func setDetailsLabel(in stack: CountdownTimeStacks) -> UILabel {
        let label = UILabel(frame: .zero)
        


        
        var attributedString1 = NSMutableAttributedString(string:"STARTED\n", attributes: labelAttributes)
        if stack == .end {
            attributedString1 = NSMutableAttributedString(string:"WILL END\n", attributes: labelAttributes)
        }
        if counterType == .show {
            label.numberOfLines = 2

            var attributedString2 = NSMutableAttributedString(string: progress.startDate, attributes: timeLabelAttributes)
            if stack == .end {
                attributedString2 = NSMutableAttributedString(string: progress.finishDate, attributes: timeLabelAttributes)
            }
            
            attributedString1.append(attributedString2)
        
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 10
            attributedString1.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString1.length))
        }
        
        label.attributedText = attributedString1
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func setEditButton() -> UIButton {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = labelFont
        switch counterType {
        case .edit:
            button.setTitle("GO!", for: .normal)
        case .show:
            button.setTitle("CHANGE", for: .normal)
        case .add:
            button.setTitle("ADD", for: .normal)
        default:
            break
        }
        
        button.setTitleColor(UIColor.gray, for: .normal)
        button.backgroundColor = .green
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        return button
    }
    
    @objc func buttonTap(sender: UIButton) {
        switch counterType {
        case .edit:
            counterType = .show
        case .show:
            counterType = .edit
        case .add:
            counterType = .show
        default:
            break
        }
        view.subviews.forEach({ $0.removeFromSuperview() })
        self.viewDidLoad()

    }
    
    
    
    // MARK: Header Constraints
    
    private func getHeadLabelConstraint(to label: UILabel) -> [NSLayoutConstraint] {
        let contraint = [
            label.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: previousItem.topAnchor, constant: 32)
        ]
        previousItem = label
        return contraint
    }
    
    private func getHeadTextFieldConstraint(to textField: UITextField) -> [NSLayoutConstraint] {
        let contraint = [
            textField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            textField.topAnchor.constraint(equalTo: previousItem.topAnchor, constant: 32),
            textField.heightAnchor.constraint(equalToConstant: 20)
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
            textField.heightAnchor.constraint(equalToConstant: 20),
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
        var contraint = [
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        
        if counterType != .show {
            contraint.append(button.topAnchor.constraint(equalTo: previousItem.topAnchor, constant: 52))
        } else {
            contraint.append(button.topAnchor.constraint(equalTo: previousItem.topAnchor, constant: 82))
        }
        previousItem = button
        return contraint
    }
    
    
}

