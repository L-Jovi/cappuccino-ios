//
//  PlayerDetailsViewController.swift
//  Ratings
//
//  Created by L Jovi on 2018/5/1.
//  Copyright © 2018 L Jovi. All rights reserved.
//

import UIKit

class PlayerDetailsViewController: UITableViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var detailLabel: UILabel!
    
    // MARK: - Properties
    var player: Player?
    
    var game: String = "Chess" {
        didSet {
            detailLabel.text = game
        }
    }
    
    // MARK: - Initializers
    required init?(coder aDecoder: NSCoder) {
        print("init PlayerDetailsViewController")
        super.init(coder: aDecoder)
    }
    
    deinit {
        print("deinit PlayerDetailsViewController")
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)  {
        if segue.identifier == "SavePlayerDetail",
            let playerName = nameTextField.text {
            player = Player(name: playerName, game: game, rating: 1)
        }
        
        if segue.identifier == "PickGame",
            let gamePickerViewController = segue.destination as? GamePickerViewController {
            gamePickerViewController.selectedGame = game
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}


// MARK: - UITableViewDelegate
extension PlayerDetailsViewController {
    
    @IBAction func unwindWithSelectedGame(segue: UIStoryboardSegue) {
        if let gamePickerViewController = segue.source as? GamePickerViewController,
            let selectedGame = gamePickerViewController.selectedGame {
            game = selectedGame
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            nameTextField.becomeFirstResponder()
        }
    }
    
}
