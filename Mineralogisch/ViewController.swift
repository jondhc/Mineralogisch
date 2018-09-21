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
    var contador: Int! = 0
    
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet var buttons: [Button]!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBAction func startButton(_: UIButton) {
        for i in buttons{
            i.setTitleColor(UIColor.blue, for: UIControlState.normal)
        }
        contador = 0
        pointsLabel.text = "Points: \(contador!)"
        for i in 0...5{
            for j in 0...5{
                tablero[i][j] = 0
            }
        }
        statusLabel.text=""
        for i in buttons{
            i.isEnabled = true
            i.setTitle("-", for: UIControlState.normal)
        }
        for _ in 0 ... 3 { // Numero de minas
            repeat {
                filaAleatoria = Int(arc4random_uniform(5))
                coluAleatoria = Int(arc4random_uniform(5))
            } while tablero[filaAleatoria][coluAleatoria] == 9

            tablero[filaAleatoria][coluAleatoria] = 9

            for fila in max(0, filaAleatoria - 1) ..< min(6, filaAleatoria + 2) {
                for col in max(0, coluAleatoria - 1) ..< min(6, coluAleatoria + 2) {
                    if tablero[fila][col] != 9 {
                        tablero[fila][col] += 1
                    } //end if
                } //end for
            } //end for
        } // end for
        print(tablero)
    } // startButton

    @IBAction func boardButton(_ sender: Button) {
        sender.isEnabled=false
        var a, b: Int

        a = sender.getX()
        b = sender.getY()

        print(a, b)
        print(tablero[a][b])
        sender.setTitle(("\(tablero[a][b])"), for: UIControlState.normal)
        sender.setTitleColor(UIColor.black, for: UIControlState.normal)
        if tablero[a][b] == 9 {
            statusLabel.text = "LOSER!"
            for i in buttons{
                i.isEnabled = false
                if(tablero[i.getX()][i.getY()] == 9){
                    i.setTitle("💣", for: UIControlState.normal)
                } //end if
            } //end for
        } //end if
        else if tablero[a][b] == 0 {
            contador = contador+1
            pointsLabel.text = "Points: \(contador!)"
            if contador == 32{
                statusLabel.text = "WINNER!"
                for i in buttons{
                    i.isEnabled = false
                    if(tablero[i.getX()][i.getY()] == 9){
                        i.setTitle("💣", for: UIControlState.normal)
                    } //end if
                } //end for
            } //end if
            //eliminarCeros(x: a, y: b, button: sender)
        } //end else if
        else {
            print("\(tablero[a][b])")
            contador = contador+1
            pointsLabel.text = "Points: \(contador!)"
            if contador == 32{
                statusLabel.text = "WINNER!"
                for i in buttons{
                    i.isEnabled = false
                    if(tablero[i.getX()][i.getY()] == 9){
                        i.setTitle("💣", for: UIControlState.normal)
                    } //end if
                } //end for
            } //end if
        } // end else
    } // end boardbutton

    func eliminarCeros(x: Int, y: Int, button: Button) {
        for i in x - 1 ... x + 1 {
            for j in y - 1 ... y + 1 {
                if i >= 0 && j >= 0 && i < 6 && j < 6 && (i != x || j != y) {
                    if tablero[i][j] >= 0 && tablero[i][j] < 9 {
                        button.isEnabled = false
                        if tablero[i][j] == 0 {
                            //button.setTitle("", for: UIControlState.normal)
                        } //end if
                        else {
                            // El boton tendra su correspondiente numero
                        } //end else
                    } //end if
                    if tablero[i][j] == 0 {
                        eliminarCeros(x: i, y: j, button: button)
                    } //end if
                } //end if
            } //end for
        } //end for
    } //end eliminarCeros

    func checarGanar() -> Bool {
        var contador: Int = 0
        for i in buttons {
            if i.isEnabled {
                contador = contador + 1
            } // end if
        } // end for
        if contador == 3 {
            return true
        } //end if
        else {
            return false
        } //end else
    } //end checarGanar

    override func viewDidLoad() {
        var a = 0
        var b = 0

        super.viewDidLoad()
        statusLabel.text="Press the start button"

        for i in buttons {
            i.setX(x: a)
            i.setY(y: b)
            if b < 5 {
                b += 1
            } //end if
            else {
                b = 0
                a += 1
            } //end else
            //print(i.titleLabel?.text as Any)
        } // end for

        for i in buttons {
            print(i.getX(), terminator: "-")
            print(i.getY())
        } //end for
    } // end viewDidLoad

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    } // end didReceiveMemoryWarning
} // end ViewController
