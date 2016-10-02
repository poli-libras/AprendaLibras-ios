//
//  ALModel.swift
//  AprendaLibras
//
//  Created by Okd on 7/5/16.
//  Copyright © 2016 Poli-Libras. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import AVFoundation


class Question{
    var id : Int
    var strQuestion : String! //String para armazenar o texto da questão
    var imgQuestion : UIImage! //UIImage para armazenar a imagem para ilustrar a pergunta
    var answers : [Answer]! //Vetor de objetos da classe Answer para armazenar as respostas
    
    //função que inicializa o objeto da classe Question
    init(id : Int, strImageFileName : String, answers : [Answer]){
        self.id = id
        self.imgQuestion = UIImage(named: strImageFileName)
        self.answers = answers
    }
}

/*class Question{
    var strQuestion : String! //String para armazenar o texto da questão
    var answers : [Answer]! //Vetor de objetos da classe Answer para armazenar as respostas
    var playerItem : AVPlayerItem?
    var player : AVPlayer?
    @IBOutlet weak var vidQuestion: UIView!
    var video : String!
    
    //função que inicializa o objeto da classe Question
    init(namevideo : String, answers : [Answer]){
        self.video = String(UTF8String: namevideo)
        self.answers = answers
        
 func video() {
        let path = NSBundle.mainBundle().pathForResource(namevideo, ofType:"mp4")
        let url = NSURL.fileURLWithPath(path!)
        playerItem = AVPlayerItem(URL: url)
        player=AVPlayer(playerItem: playerItem!)
        let playerLayer=AVPlayerLayer(player: player!)
        playerLayer.frame=CGRectMake(-10, -45, 270, 300)
        self.vidQuestion.layer.addSublayer(playerLayer)
        player?.play()
        }
    }
}*/




class Answer{
    var strAnswer : String! //String para armazenar o texto da resposta
    var isCorrect : Bool! //Booleana para armazenar se a resposta é correta ou não
    var corAns : String! //Armazena a resposta correta
    
    //função que inicializa o objeto da classe Answer
    init(answer : String, isCorrect : Bool, corAns : String){
        self.strAnswer = answer
        self.isCorrect = isCorrect
        self.corAns = corAns
    }
}

