//
//  ViewController.swift
//  ImageCaching
//
//  Created by Jageloo Yadav on 28/10/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var image: UIImageView?
    var widthAnchorConstraint: NSLayoutConstraint?
    @IBOutlet weak var tableView: UITableView?
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL.init(string: "https://source.unsplash.com/user/c_v_r/1600x900") else {
            return
        }
        image?.download(url: url, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView?.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100000
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let url = URL.init(string: "https://source.unsplash.com/user/c_v_r/1600x900")!
        if widthAnchorConstraint == nil {
            widthAnchorConstraint = cell.imageView?.widthAnchor.constraint(equalToConstant: 150.0)
            widthAnchorConstraint?.isActive = true
            cell.imageView?.heightAnchor.constraint(equalToConstant: 150.0).isActive = true
        }
        cell.imageView?.download(url: url, completion: { operation in
            guard let data = operation.data else { return }
            cell.imageView?.image = UIImage.init(data: data)
            print("operation state == \(operation.state)")
            if operation.state == .finished {
                self.tableView?.reloadData()
            }
        })
        widthAnchorConstraint?.constant = 150.0
        return cell
    }

}

