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
        
    } //startButton
    
    @IBAction func boardButton(_ sender: Button) {
                var a,b : Int
        
                a = sender.getX()
                b = sender.getY()
        
                print(a, b)
                print(tablero[a][b])
        
                if tablero[a][b] == 9 {
                    print("Perdiste")
                } //end if
                else if tablero[a][b] == 0 {
                    //funcion recursiva
                } //end else if
                else {
                    print("\(tablero[a][b])")
                } //end else
    } //end boardbutton
    
    func eliminarCeros(x: Int, y: Int)->Void{
        for i in x-1...x+1{
            for j in y-1...y+1{
                if i>=0 && j>=0 && i<6 && j<6 && (i != x || j != y){
                    if tablero[i][j] >= 0 && tablero[i][j] < 9 {
                        //Deshabilitar boton
                        if tablero[i][j] == 0 {
                            //El boton tendra texto vacio
                        }
                        else {
                            //El boton tendra su correspondiente numero
                        }
                    }
                    if tablero[i][j] == 0 {
                        eliminarCeros(x: i,y: j)
                    }
                }
            }
        }
    }
    
    func checarGanar() -> Bool {
        var contador: Int = 0
        for i in buttons{
            if (i.isEnabled){
                contador = contador + 1
            } //end if
        } //end for
        if contador == 3  {
            return true
        }else {
            return false
        }
        
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
        
    } //end viewDidLoad

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    } //end didReceiveMemoryWarning


} //end ViewController

