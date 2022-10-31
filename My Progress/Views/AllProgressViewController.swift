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
        getProgressData()
    }
    
    func getProgressData(){

        let urlString = "https://drive.google.com/file/d/1_dKjoaA7BoWnNDXsi0tiCDQBbEfll8pI"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                self.parseJSON(withData: data)
            }
        }
        task.resume()
    }


    func parseJSON(withData data: Data) {
        let decoder = JSONDecoder()
        do {
            print(data)
            let usersProgress = try decoder.decode(UsersProgress.self, from: data)
            print(usersProgress.users[0].progressDates[0])
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

}

extension AllProgressViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        progressList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = progressCollectionView.dequeueReusableCell(withReuseIdentifier: "countdownCell", for: indexPath) as! CountdownCell
        cell.configure(progress: progressList[indexPath.row])
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cellTap)))
        return cell
    }
    
    @objc func cellTap(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: self.progressCollectionView)
        let indexPath = self.progressCollectionView.indexPathForItem(at: location)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let countdownViewController = storyBoard.instantiateViewController(withIdentifier: "countdownView") as! CountdownViewController
        countdownViewController.progress = progressList[indexPath!.row]
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
