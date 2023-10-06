//
//  ContentView.swift
//  Calculator V2
//
//  Created by MacBook Pro on 05/10/23.
//

import SwiftUI

let ALL_CLEAR:String = "AC"
let CLEAR:String = "C"

struct GrayButton: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 80, height: 80)
            .foregroundColor(Color.black)
            .background(Color.gray)
            .clipShape(Circle())
            .font(.system(size: 40))
    }
}

struct BlackButton: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 80, height: 80)
            .foregroundColor(Color.white)
            .background(Color(red: 65/255,green: 65/255, blue: 65/255))
            .clipShape(Circle())
            .font(.system(size: 40))
    }
}

struct BlackButtonDouble: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 170, height: 80, alignment: .leading)
            .foregroundColor(Color.white)
            .background(Color(red: 65/255,green: 65/255, blue: 65/255))
            .clipShape(RoundedRectangle(cornerRadius: 40))
            .font(.system(size: 40))
    }
}

struct OrangeButton: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 80, height: 80)
            .foregroundColor(Color.white)
            .background(Color.orange)
            .clipShape(Circle())
            .font(.system(size: 40, weight: .bold))
    }
}

struct ContentView: View {
    @State var curr_num:String = "0"
    @State var result:Double = 0
    @State var prev_operator:String = ""
    @State var accept_input:Bool = true
    @State var calculating:Bool = true
    @State var clear_text:String = ALL_CLEAR
       
    func reset(){
        curr_num = "0"
        result = 0
        prev_operator = ""
        accept_input = true
        calculating = true
        clear_text = ALL_CLEAR
    }
    
    func checkError(){
        if(curr_num.last == "."){
            curr_num.removeLast()
        }
    }
    
    func showResult(){
        switch prev_operator {
        case "DIVIDE":
            if let temp:Double = Double(curr_num){
                result /= temp
            }
        case "MULTIPLY":
            if let temp:Double = Double(curr_num){
                result *= temp
            }
        case "ADD":
            if let temp:Double = Double(curr_num){
                result += temp
            }
        case "SUBSTRACT":
            if let temp:Double = Double(curr_num){
                result -= temp
            }
        case "":
            if let temp:Double = Double(curr_num){
                result = temp
            }
        default:
            result = result
        }
        
        curr_num = String(result)
        accept_input = false
        
        if(curr_num.suffix(2) == ".0") {
            curr_num = String(curr_num.dropLast(2))
        }
    }
    
    func buttonPressed(_ value: String){

        if (!accept_input){
            curr_num = "0"
            accept_input = true
        }
        
        if(!calculating){
            reset()
        }
        switch value{
        case "AC":
            reset()
        case "C":
            curr_num = "0"
        case "PLUS_MINUS":
            if(curr_num.first == "-"){
                curr_num.removeFirst()
            } else if(curr_num != "0"){
                curr_num = "-" + curr_num
            }
        case "PERCENT":
            checkError()
            if let temp:Double = Double(curr_num){
                let temp2 = temp / 100
                curr_num = String(temp2)
            }
            if(curr_num.suffix(2) == ".0") {
                curr_num = String(curr_num.dropLast(2))
            }
        case ".":
            if(!curr_num.contains(".")){
                curr_num += value
            }
        case "DIVIDE":
            checkError()
            showResult()
            prev_operator = "DIVIDE"
        case "MULTIPLY":
            checkError()
            showResult()
            prev_operator = "MULTIPLY"
        case "ADD":
            checkError()
            showResult()
            prev_operator = "ADD"
        case "SUBSTRACT":
            checkError()
            showResult()
            prev_operator = "SUBSTRACT"
        case "PRINT_RESULT":
            showResult()
            calculating = false
        default:
            if(curr_num != "0"){
                curr_num += value
            } else {
                curr_num = value
            }
        }
        
        if(curr_num != "0"){
            clear_text = CLEAR
        } else {
            clear_text = ALL_CLEAR
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            HStack(){
                Spacer()
                TextField("0", text: $curr_num)
                    .font(.system(size: 60))
                    .padding(.trailing, 40)
                    .padding(.bottom, 10)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.trailing)
            }
            //Row1
            HStack(spacing: 10){
                Button(action: {
                    self.buttonPressed(clear_text)
                }) {
                    Text(clear_text)
                }.buttonStyle(GrayButton())
                
                Button(action: {
                    self.buttonPressed("PLUS_MINUS")
                }) {
                    Text("⁺⁄₋")
                }.buttonStyle(GrayButton())
                
                Button(action: {
                    self.buttonPressed("PERCENT")
                }) {
                    Text("%")
                }.buttonStyle(GrayButton())
                
                Button(action: {
                    self.buttonPressed("DIVIDE")
                }) {
                    Text("÷")
                }.buttonStyle(OrangeButton())
            }
            
            //Row2
            HStack(spacing: 10){
                Button(action: {
                    self.buttonPressed("7")
                }) {
                    Text("7")
                }.buttonStyle(BlackButton())
                
                Button(action: {
                    self.buttonPressed("8")
                }) {
                    Text("8")
                }.buttonStyle(BlackButton())
                
                Button(action: {
                    self.buttonPressed("9")
                }) {
                    Text("9")
                }.buttonStyle(BlackButton())
                
                Button(action: {
                    self.buttonPressed("MULTIPLY")
                }) {
                    Text("×")
                }.buttonStyle(OrangeButton())
            }
            
            //Row3
            HStack(spacing: 10){
                Button(action: {
                    self.buttonPressed("4")
                }) {
                    Text("4")
                }.buttonStyle(BlackButton())
                
                Button(action: {
                    self.buttonPressed("5")
                }) {
                    Text("5")
                }.buttonStyle(BlackButton())
                
                Button(action: {
                    self.buttonPressed("6")
                }) {
                    Text("6")
                }.buttonStyle(BlackButton())
                
                Button(action: {
                    self.buttonPressed("ADD")
                }) {
                    Text("+")
                }.buttonStyle(OrangeButton())
            }
            
            //Row4
            HStack(spacing: 10){
                Button(action: {
                    self.buttonPressed("1")
                }) {
                    Text("1")
                }.buttonStyle(BlackButton())
                
                Button(action: {
                    self.buttonPressed("2")
                }) {
                    Text("2")
                }.buttonStyle(BlackButton())
                
                Button(action: {
                    self.buttonPressed("3")
                }) {
                    Text("3")
                }.buttonStyle(BlackButton())
                
                Button(action: {
                    self.buttonPressed("SUBSTRACT")
                }) {
                    Text("−")
                }.buttonStyle(OrangeButton())
            }
            
            //Row5
            HStack(spacing: 10){
                Button(action: {
                    self.buttonPressed("0")
                }) {
                    Text("0")
                        .padding(.leading, 30)
                }.buttonStyle(BlackButtonDouble())
                
                Button(action: {
                    self.buttonPressed(".")
                }) {
                    Text(".")
                }.buttonStyle(BlackButton())
                
                Button(action: {
                    self.buttonPressed("PRINT_RESULT")
                }) {
                    Text("=")
                }.buttonStyle(OrangeButton())
            }
        }.background(.black)
    }
}

#Preview {
    ContentView()
}
