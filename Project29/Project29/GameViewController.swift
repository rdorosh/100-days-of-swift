//
//  GameViewController.swift
//  Project29
//
//  Created by Ruslan Dorosh on 27.10.2023.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    var currentGame: GameScene?
    
    @IBOutlet var angleSlider: UISlider!
    @IBOutlet var angleLabel: UILabel!
    @IBOutlet var velocitySlider: UISlider!
    @IBOutlet var velocityLabel: UILabel!
    @IBOutlet var launchButton: UIButton!
    @IBOutlet var playerNumber: UILabel!
    
    
    @IBOutlet var player1ScoreLabel: UILabel!
    @IBOutlet var player2ScoreLabel: UILabel!
    @IBOutlet var gameOverLabel: UILabel!
    @IBOutlet var newGameButton: UIButton!
    
    var player1Score = 0 {
        didSet {
            player1ScoreLabel.text = "Score: \(player1Score)"
        }
    }
    
    var player2Score = 0 {
        didSet {
            player2ScoreLabel.text = "Score: \(player2Score)"
        }
    }
    
    var isGameOver = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player1Score = 0
        player2Score = 0
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
                
                currentGame = scene as? GameScene
                currentGame?.viewController = self
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
        
        angleChanged(self)
        velocityChanged(self)
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func angleChanged(_ sender: Any) {
        angleLabel.text = "Angle: \(Int(angleSlider.value))°"
    }
    
    @IBAction func velocityChanged(_ sender: Any) {
        velocityLabel.text = "Velocity: \(Int(velocitySlider.value))"
    }
    
    @IBAction func launch(_ sender: Any) {
        angleSlider.isHidden = true
        angleLabel.isHidden = true
        
        velocitySlider.isHidden = true
        velocityLabel.isHidden = true
        
        launchButton.isHidden = true
        
        currentGame?.launch(angle: Int(angleSlider.value), velocity: Int(velocitySlider.value))
        
    }
    
    func activatePlayer(number: Int) {
        if number == 1 {
            playerNumber.text = "<<< PLAYER ONE"
        } else {
            playerNumber.text = "PLAYER TWO >>>"
        }
        
        angleSlider.isHidden = false
        angleLabel.isHidden = false
        
        velocitySlider.isHidden = false
        velocityLabel.isHidden = false
        
        launchButton.isHidden = false
    }
    
    func updateScore(player: Int) {
        if player == 1 {
            player1Score += 1
        } else {
            player2Score += 1
        }
        
        if player1Score == 3 {
            player1ScoreLabel.text = "WINNER"
            toggleGame(bool: true)
        } else if player2Score == 3{
            player2ScoreLabel.text = "WiNNER"
            toggleGame(bool: true)
        }
    }
    
    @IBAction func newGameTapped(_ sender: Any) {
        toggleGame(bool: false)
        player1Score = 0
        player2Score = 0
        currentGame?.setupNewGame()
    }
    
    func toggleGame(bool: Bool) {
        isGameOver = bool
        angleLabel.isHidden = bool
        angleSlider.isHidden = bool
        velocitySlider.isHidden = bool
        velocityLabel.isHidden = bool
        playerNumber.isHidden = bool
        launchButton.isHidden = bool
        gameOverLabel.isHidden = !bool
        newGameButton.isHidden = !bool
    }
    
}
