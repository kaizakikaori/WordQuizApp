//
//  ViewController.swift
//  WordQuizApp
//
//  Created by VERTEX21 on 2019/08/15.
//  Copyright © 2019 k-kougi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var TextView: UITextView!
    @IBOutlet weak var StackView: UIStackView!
    @IBOutlet weak var NavigationItem: UINavigationItem!
    
    let question: [String] = [
    "問１ 日本の世界遺産『富士山－信仰の対象と芸術の源泉』は、2013年に（ ）として世界遺産登録されました。 1. 文化遺産 2. 自然遺産 3. 山岳遺産 4. 伝統遺産",
    "問2 イタリア共和国の世界遺産『フィレンツェの歴史地区』のあるフィレンツェを中心に、17世紀に栄えた芸術運動は何でしょうか。1. シュルレアリスム 2. アバンギャルド 3. ルネサンス",
    "問3 2016年のオリンピック開催地であるリオ・デ・ジャネイロで、ブラジル独立100周年を記念して作られたキリスト像が立つ場所として、正しいものはどれか。1. コパカバーナの山 2. コルコバードの丘"
    ]
    //問題の答え
    let answers: [Int] = [1,3,2]
    //現在の問題番号を格納する変数
    var questionNumber: Int = 1
    
    var sam: [Bool] = []
    
    //
    //
    var correctOrlncorrect: [Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        TextView.text = question[0]
    }
    func checkAnswer(playerAnswer: Int){
        
        if playerAnswer == answers[questionNumber - 1] {
            if questionNumber < question.count {
                showAlert(title: "正解です", message: "次の問題へ進みます")
                
            }else{
                 showAlert(title: "正解です", message: "結果を表示する")
            }
        }else{
            showAlertcontroller(title: "不正解です", message: "次の問題へ進みます")
        
        }
    }
    
    
    func showAlert(title:String?,message: String){
        // アラートの作成
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // アラートのアクション(ボタン部分の定義)
        let close = UIAlertAction(title: "OK", style: .cancel, handler: {(action: UIAlertAction!) in
            self.sam.append(true)
            self.nextQuestion()
            
        
        })
        // 作成したalertに閉じるボタンを追加
        alert.addAction(close)
        // アラートを表示
        present(alert, animated: true, completion: nil)
    }
    
    func showAlertcontroller(title:String?,message: String){
        // アラートの作成
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let a = UIAlertAction(title: "いいえ", style: .default, handler: nil)
        
        // アラートのアクション(ボタン部分の定義)
        let close = UIAlertAction(title: "OK", style: .cancel, handler: {(action: UIAlertAction!) in
            self.sam.append(false)
            self.nextQuestion()
            
            
        })
        
        // 作成したalertに閉じるボタンを追加
        alert.addAction(close)
        alert.addAction(a)
        
        // アラートを表示
        present(alert, animated: true, completion: nil)
    }
    
    func nextQuestion(){
    
       if questionNumber < question.count {
          hideButton()
        questionNumber += 1
        TextView.text = question[questionNumber - 1]
        NavigationItem.title = "\(questionNumber)"
       }else{
        //画面遷移
        performSegue(withIdentifier: "toresult", sender: nil)
        reset()
        
        }
    }
    
    func reset() {
        TextView.text = question [0]
        for button in StackView.arrangedSubviews{
            button.isHidden = false
        }
        
        questionNumber = 1
        
        
    }
    
    func hideButton() {
      let hideButtonNumber = StackView.arrangedSubviews.count - questionNumber
        StackView.arrangedSubviews[hideButtonNumber].isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toresult" {
            let nextVC = segue.destination as! TableViewController
            nextVC.trable = sam
        }
    }
    
    @IBAction func TapButton(_ sender: UIButton) {
        checkAnswer(playerAnswer: sender.tag)
        
        
    }
    

}

