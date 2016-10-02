//
//  ViewController.swift
//  AprendaLibras
//
//  Created by Okd on 7/5/16.
//  Copyright © 2016 Poli-Libras. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import Foundation


class ViewController: UIViewController {

    @IBOutlet weak var imgQuestion: UIImageView!
    @IBOutlet weak var vidQuestion: UIView!
    
    @IBOutlet weak var btnAnswer1: UIButton!
    @IBOutlet weak var btnAnswer2: UIButton!
    @IBOutlet weak var btnAnswer3: UIButton!
    @IBOutlet weak var btnAnswer4: UIButton!
    
    @IBOutlet weak var viewFeedback: UIView!
    @IBOutlet weak var lbFeedback: UILabel!
    @IBOutlet weak var btnFeedback: UIButton!
    
    var questions : [Question]! //vetor que contém as questões do quiz
    var currentQuestion = 0     //Int que indica qual a questão atual
    var grade = 0.0             //Double para o cálculo da nota
    var quizEnded = false       //Bool que indica se o quiz terminou ou não
    var playerItem : AVPlayerItem?
    var player : AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let q0answer0 = Answer(answer: "PENSAR", isCorrect: false, corAns: "OLHAR")
        let q0answer1 = Answer(answer: "OLHAR", isCorrect: true, corAns: "OLHAR")
        let q0answer2 = Answer(answer: "COMER", isCorrect: false, corAns: "OLHAR")
        let q0answer3 = Answer(answer: "CORRER", isCorrect: false, corAns: "OLHAR")
        let question0 = Question(id: 0, strImageFileName: "logo", answers: [q0answer0,q0answer1,q0answer2,q0answer3])

        
        let q1answer0 = Answer(answer: "ESPADA", isCorrect: false, corAns: "TORNEIO")
        let q1answer1 = Answer(answer: "TORNEIO", isCorrect: true, corAns: "TORNEIO")
        let q1answer2 = Answer(answer: "FLECHA", isCorrect: false, corAns: "TORNEIO")
        let q1answer3 = Answer(answer: "ESGRIMA", isCorrect: false, corAns: "TORNEIO")
        let question1 = Question(id: 1, strImageFileName: "logo", answers: [q1answer0,q1answer1,q1answer2,q1answer3])
        
        questions = [question0,question1]
        
        /*let path = NSBundle.mainBundle().pathForResource("olhar", ofType:"mp4")
        let url = NSURL.fileURLWithPath(path!)
        playerItem = AVPlayerItem(URL: url)
        player=AVPlayer(playerItem: playerItem!)
        let playerLayer=AVPlayerLayer(player: player!)
        playerLayer.frame=CGRectMake(-10, -45, 270, 300)
        self.vidQuestion.layer.addSublayer(playerLayer)
        player?.play()*/
        
        
        startQuiz() //começa o quiz
    
    }
    
    /*Função que reseta o Quiz*/
    func startQuiz() {
        questions.shuffle() //embaralha o vetor de questões
        for(var i=0;i<questions.count;i+=1){
            questions[i].answers.shuffle() //embaralha o vetor de respostas para cada questão
        }
        
        
        //reseta as variáveis do progresso do usuário
        quizEnded = false
        grade = 0.0
        currentQuestion = 0
        
        showQuestion (0) //mostra a pimeira questão
    }
    
    
    /*Função que atualiza os objetos da tela com os dados do vetor de questões*/
    func showQuestion(questionIdx : Int){
        
        let question : Question = questions[questionIdx]
        
        vidQuestion.hidden = false
        
        if question.id == 0 {
            
            let path = NSBundle.mainBundle().pathForResource("olhar", ofType:"mp4")
            let url = NSURL.fileURLWithPath(path!)
            playerItem = AVPlayerItem(URL: url)
            player=AVPlayer(playerItem: playerItem!)
            let playerLayer=AVPlayerLayer(player: player!)
            playerLayer.frame=CGRectMake(-10, -45, 270, 300)
            self.vidQuestion.layer.addSublayer(playerLayer)
            player?.play()
        }
        
        if question.id == 1 {
            
            let path = NSBundle.mainBundle().pathForResource("torneio", ofType:"mp4")
            let url = NSURL.fileURLWithPath(path!)
            playerItem = AVPlayerItem(URL: url)
            player=AVPlayer(playerItem: playerItem!)
            let playerLayer=AVPlayerLayer(player: player!)
            playerLayer.frame=CGRectMake(-10, -45, 270, 300)
            self.vidQuestion.layer.addSublayer(playerLayer)
            player?.play()
        }

        
        //habilita os 4 botões das alternativas
        btnAnswer1.enabled = true
        btnAnswer2.enabled = true
        btnAnswer3.enabled = true
        btnAnswer4.enabled = true

        //atualiza o label de questão, imagem e texto dos 4 botões
        imgQuestion.image = question.imgQuestion
        btnAnswer1.setTitle(question.answers[0].strAnswer, forState: UIControlState.Normal)
        btnAnswer2.setTitle(question.answers[1].strAnswer, forState: UIControlState.Normal)
        btnAnswer3.setTitle(question.answers[2].strAnswer, forState: UIControlState.Normal)
        btnAnswer4.setTitle(question.answers[3].strAnswer, forState: UIControlState.Normal)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func chooseAnswer1(sender: AnyObject) {
        selectAnswer(0)
    }
    
    @IBAction func chooseAnswer2(sender: AnyObject) {
        selectAnswer(1)
    }
    
    @IBAction func chooseAnswer3(sender: AnyObject) {
        selectAnswer(2)
    }
    
    @IBAction func chooseAnswer4(sender: AnyObject) {
        selectAnswer(3)
    }
    
    //Função que seleciona uma alternativa
    func selectAnswer(answerid : Int){
        //desabilita botões de alternativa para que não se possa clicar 2 vezes
        btnAnswer1.enabled = false
        btnAnswer2.enabled = false
        btnAnswer3.enabled = false
        btnAnswer4.enabled = false
        
        viewFeedback.hidden = false //mostra view de feedback
        
        
        let answer : Answer = questions[currentQuestion].answers[answerid] //seleciona resposta
        
        if(answer.isCorrect == true){
            grade = grade + 1.0 //soma 1 ponto caso a resposta esteja correta
            lbFeedback.text = "PARABÉNS!!!" + "\n\nResposta correta : " + answer.strAnswer//feedback: Correto"
        }else{
            lbFeedback.text = "NÃO DEU..." + "\n\nResposta correta : " + answer.corAns//feedback: Errado"
        }
        
        if(currentQuestion < questions.count-1){
            //caso a questão atual não seja a última, atualiza o texto do botão Feedback para Próxima
            btnFeedback.setTitle("PRÓXIMA PERGUNTA", forState: UIControlState.Normal)
        }else{
            //caso a questão atual seja a última, atualiza o botão de Feedback para "Ver Nota"
            btnFeedback.setTitle("CONTINUA", forState: UIControlState.Normal)
        }
    }

    @IBAction func btnFeedbackAction(sender: AnyObject) {
        viewFeedback.hidden = true //esconde view de feedback
        
        if(quizEnded){
            startQuiz() //se quiz terminou, recomeça
        }else{
            nextQuestion() //se não terminou, mostra próxima questão
        }
        
    }
    
    /*Função que mostra a próxima questão ou o final do quiz */
    func nextQuestion(){
        currentQuestion+=1 //incrementa em 1 o valor da variável de questão atual
        
        if(currentQuestion < questions.count){
            //se a questão atual é menor que o número total de questões, mostra a próxima
            showQuestion(currentQuestion)
        }else{
            //se a questão atual é igual o número total de questões, termina o quiz
            endQuiz()
        }
    }
    
    /*Função que termina o quiz */
    func endQuiz(){
        grade = grade / Double(questions.count) * 100.0 //Cálculo da nota: de 0 a 100
        quizEnded = true //atualiza variável booleana que inidica o término do quiz
        viewFeedback.hidden = false //mostra o view de feedback
        vidQuestion.hidden = true
        lbFeedback.text = "Sua nota: \(grade)" //atualiza texto de Feedback mostrando a nota
        btnFeedback.setTitle("Refazer", forState: UIControlState.Normal) //atualiza texto de botão de Feedback de refazer o quiz
    }
}

    
    


