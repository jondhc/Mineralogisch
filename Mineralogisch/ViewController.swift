//
//  ViewController.swift
//  Mineralogisch
//
//  Created by Jonathan Herrejón on 9/16/18.
//  Copyright © 2018 Jonathan Herrejón. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var tablero: [[Int]] = Array(repeating: Array(repeating: 0, count: 6), count: 6)
    var filaAleatoria: Int!
    var coluAleatoria: Int!
    
    @IBOutlet var buttons: [Button]!
    
    @IBAction func startButton(_ sender: UIButton) {
        for _ in 0...3 { //Numero de minas
            repeat {
                filaAleatoria = Int(arc4random_uniform(5))
                coluAleatoria = Int(arc4random_uniform(5))
            } while tablero[filaAleatoria][coluAleatoria] == 9
            
            tablero[filaAleatoria][coluAleatoria] = 9
            
            for fila in max(0,filaAleatoria-1)..<min(6,filaAleatoria+2) {
                for col in max(0,coluAleatoria-1)..<min(6,coluAleatoria+2) {
                    if tablero[fila][col] != 9 {
                        tablero[fila][col] += 1
                    }
                }
            }
        }//end for
        
    }
    
    override func viewDidLoad() {
        var a = 0
        var b = 0
        
        super.viewDidLoad()
        
        for i in buttons{
            i.setX(x: a)
            i.setY(y: b)
            if b < 5 {
                b += 1
            } else {
                b = 0
                a += 1
            }
            print(i.titleLabel?.text as Any)
        } //end for
        
        for i in buttons{
            print(i.getX(), terminator: "-")
            print(i.getY())
        }
        
    } //end viiewDidLoad

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    } //end didReceiveMemoryWarning


} //end ViewController

