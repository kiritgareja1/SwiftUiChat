//
//  ChatListVC.swift
//  SwiftUIChat
//
//  Created by Kirit on 10/02/23.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseDatabase

struct ChatListVC: View {
    @State private var msg: String = ""
    @State var ref: DatabaseReference!
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    
                }.frame(width: DeviceSize.width,height: 50)
                    .background(GlobalColor.color_236_249_255)
                LazyVStack{
                    
                }.frame(width: DeviceSize.width,height: DeviceSize.height - 200)
                    .background(.clear)
                HStack{
                    Button("Att") {
                        print("clicked")
                    }
                    .padding(.leading , 10)
                    HStack(){
                        TextField("Enter your name", text: $msg)
                            .padding(10)
                    }.background(GlobalColor.color_236_249_255)
                        .cornerRadius(10)
                        .padding(.leading , 20)
                        .padding(.trailing , 20)
                        .shadow(color: .gray.opacity(0.3), radius: 1)
                    Button("Send") {
                        addMsg(text: msg)
                    }.padding(.trailing , 10)
                }.frame(width: DeviceSize.width,height: 50)
                    .background(GlobalColor.color_236_249_255)
            }
        }.onAppear(){
            viewDidLoad()
        }
    }
    
    
    private func viewDidLoad(){
        ref = Database.database().reference()
    }
    
    private func addMsg(text:String){
        self.ref.child("chat").childByAutoId().setValue(text)
    }
    
}

struct ChatListVC_Previews: PreviewProvider {
    static var previews: some View {
        ChatListVC()
    }
}
