//
//  AllProgressViewController.swift
//  My Progress
//
//  Created by Alexander Petrenko on 28.10.2022.
//

import UIKit


class AllProgressViewController: UIViewController {
    
    var progressList = Time.getProgress()
    
    @IBOutlet var progressCollectionView: UICollectionView! {
        didSet {
            progressCollectionView.dataSource = self
            progressCollectionView.delegate = self
            
            progressCollectionView.register(UINib(nibName: "CountdownCell", bundle: nil), forCellWithReuseIdentifier: "countdownCell")
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        //        let urlString = "https://github.com/DevSada/My-Progress/blob/main/My%20Progress/Resources/UsersProgress.json"//https://drive.google.com/file/d/1_dKjoaA7BoWnNDXsi0tiCDQBbEfll8pI"
        //        guard let url = URL(string: urlString) else { return }
        //        let session = URLSession(configuration: .default)
        //        let task = session.dataTask(with: url) { data, response, error in
        //            if let data = data {
        //                self.parseJSON(withData: data)
        //            }
        //        }
        //        task.resume()
        //
        //        if let jsonData = urlString.data(using: .utf8),
        //            let documentDirectory = FileManager.default.urls(for: .documentDirectory,
        //                                                             in: .userDomainMask).first {
        //            let pathWithFileName = documentDirectory.appendingPathComponent("myJsonData")
        //            do {
        //                try {
        //                    jsonData.write(to: pathWithFileName)
        //                    print(pathWithFileName)
        //
        //                }
        //            } catch {
        //                // handle error
        //            }
        //        }
        
        guard let url = URL(string: "https://github.com/DevSada/My-Progress/blob/main/My%20Progress/Resources/UsersProgress.json") else {return}
        
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            do {
                let progress = try JSONDecoder().decode(UsersProgress.self, from: data)
                print(progress)
            } catch {
                print(error)
            }
        }.resume()
        
        
    }
    
    func parseJSON(withData data: Data) {
        let decoder = JSONDecoder()
        do {
            let usersProgress = try decoder.decode(UsersProgress.self, from: data)
            print(usersProgress.users[0].progressDates[0])
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
}

extension AllProgressViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        progressList.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = progressCollectionView.dequeueReusableCell(withReuseIdentifier: "countdownCell", for: indexPath) as! CountdownCell
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cellTap)))
        if indexPath.row == 0 {
            let label = UILabel(frame: CGRect(x: cell.frame.width - 160, y: cell.frame.width - 285, width: 150, height: 21))
            label.center = CGPoint(x: 45, y: 45)
            label.textAlignment = .center
            label.text = "+"
            label.font = UIFont(name: label.font.fontName, size: 32)
            label.restorationIdentifier = "labelCounter"
            cell.addSubview(label)
        } else {
            cell.configure(progress: progressList[indexPath.row - 1])
        }
        
        return cell
    }
    
    @objc func cellTap(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: self.progressCollectionView)
        let indexPath = self.progressCollectionView.indexPathForItem(at: location)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let countdownViewController = storyBoard.instantiateViewController(withIdentifier: "countdownView") as! CountdownViewController
        if indexPath!.row - 1 >= 0 {
            countdownViewController.progress = progressList[indexPath!.row - 1]
            countdownViewController.counterType = .show
        } else{
            countdownViewController.counterType = .add
            
        }
        self.present(countdownViewController, animated: true, completion: nil)
    }
}

extension AllProgressViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/4, height: view.frame.width/4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
