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
    var checar: [[Int]] = Array(repeating: Array(repeating: 0, count: 6), count: 6)
    var filaAleatoria: Int!
    var coluAleatoria: Int!
    var contador: Int! = 0
    var seconds = 0
    var resumeTapped = false
    
    var time = Timer()
    var isTimerRunning = false
    
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var timer: UILabel!
    @IBOutlet var buttons: [Button]!
    @IBOutlet weak var statusLabel: UILabel!
    
    func pause (){
        if self.resumeTapped == false{
            time.invalidate()
            self.resumeTapped = true
        }
        else{
            runTimer()
            self.resumeTapped = false
        }
    }
    
    func timeString (time: TimeInterval) -> String {
        let hours = Int(time)/3600
        let minutes = Int(time)/60%60
        let seconds = Int(time)%60
        return String (format: "%02i:%02i:%02i", hours,minutes,seconds)
    }
    
    func runTimer() {
        time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        seconds = seconds+1
        timer.text = "Time: \(timeString(time: TimeInterval(seconds)))"
    }
    
    func resetTimer () {
        time.invalidate()
        seconds = 0
        timer.text = "Time: \(timeString(time: TimeInterval(seconds)))"
    }
    
    @IBAction func startButton(_: UIButton) {
        resetTimer()
        runTimer()
        for i in buttons{
            i.setTitleColor(UIColor.black, for: UIControlState.normal)
        }
        contador = 0
        pointsLabel.text = "Points: \(100/32*contador!)"
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
        
        for i in 0...5 {
            for j in 0...5 {
                print("\(tablero[i][j])", terminator: " ")
            }
            print( " ")
        }
    } // startButton

    @IBAction func boardButton(_ sender: Button) {
        sender.isEnabled = false
        var a, b: Int

        a = sender.getX()
        b = sender.getY()

        print(a, b)
        print(tablero[a][b])
        sender.setTitle(("\(tablero[a][b])"), for: UIControlState.normal)
        sender.setTitleColor(UIColor.black, for: UIControlState.normal)
        if tablero[a][b] == 9 {                     //Si el jugador presiona una mina
            statusLabel.text = "LOSER!"
            pause()
            for i in buttons{
                i.isEnabled = false
                if(tablero[i.getX()][i.getY()] == 9){
                    i.setTitle("💣", for: UIControlState.normal)
                } //end if
            } //end for
        } //end if
        else {                                      //Si el jugador NO presiona una mina
            contador += 1
            pointsLabel.text = "Points: \(100/32*contador!)"
            if tablero[a][b] == 0 {                             //Si es un cero
                eliminarCeros(x: a, y: b)
            } //end else if
            else {                                              //Si no es un cero
                print("\(tablero[a][b])")
            } // end else
            
            if contador == 32{                      //Checar victoria al final del presionado del boton
                statusLabel.text = "WINNER!"
                pause()
                for i in buttons{
                    i.isEnabled = false
                    if(tablero[i.getX()][i.getY()] == 9){
                        i.setTitle("💣", for: UIControlState.normal)
                    } //end if
                } //end for
            } //end if
        }
    } // end boardbutton

    func eliminarCeros(x: Int, y: Int) {
        for i in x - 1 ... x + 1 {
            for j in y - 1 ... y + 1 {
                if i >= 0 && j >= 0 && i < 6 && j < 6 && (i != x || j != y) {
                    if checar[i][j] == 0 {
                        if tablero[i][j] >= 0 && tablero[i][j] < 9 {
                            for b in buttons {
                                if (b.getX() == i) && (b.getY() == j) {
                                    if b.isEnabled == true {
                                        contador += 1
                                        b.isEnabled = false
                                        b.setTitleColor(UIColor.black, for: UIControlState.normal)
                                        pointsLabel.text = "Points: \(100/32*contador!)"
                                        checar[i][j] = 1
                                    }
                                    if tablero[i][j] == 0 {
                                        b.setTitle(" ", for: UIControlState.normal)
                                    }
                                    else {
                                        b.setTitle("\(tablero[i][j])", for: UIControlState.normal)
                                    }
                                }
                            }
                        } //end if
                        if tablero[i][j] == 0 {
                            eliminarCeros(x: i, y: j)
                        } //end if
                    }
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
            i.isEnabled = false
            i.setX(x: a)
            i.setY(y: b)
            if b < 5 {
                b += 1
            } //end if
            else {
                b = 0
                a += 1
            } //end else

        } // end for

        for i in buttons {
            print(i.getX(), terminator: "-")
            print(i.getY())
        } //end for
        
    } // end viewDidLoad
    
    @IBAction func toggleFlag(_ sender: UILongPressGestureRecognizer) {
        if((sender.view as! UIButton).titleLabel?.text == "🚩"){
            (sender.view as! UIButton).titleLabel?.text = "-"
        } //end if
        else{
            (sender.view as! UIButton).titleLabel?.text = "🚩"
        } //end else
    } //end toggleFlag
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    } // end didReceiveMemoryWarning
    
} // end ViewController
