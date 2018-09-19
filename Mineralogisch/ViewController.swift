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
    var filaAleatoria: Int
    var columnaAleatoria: Int
    
    @IBOutlet var buttons: [UIButton]!
    
    @IBAction var startButton(_ sender: UIButton) {
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
    
    }//end startButton
    
    override func viewDidLoad() {
        var a = 0
        var b = 0
        
        super.viewDidLoad()
        
        for i in buttons{
            i.setX(a)
            i.setY(b)
            if b < 5 {
                b += 1
            } else {
                b = 0
                a += 1
            }
            print(i.titleLabel)
        } //end for
        
    } //end viiewDidLoad

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    } //end didReceiveMemoryWarning


} //end ViewController

