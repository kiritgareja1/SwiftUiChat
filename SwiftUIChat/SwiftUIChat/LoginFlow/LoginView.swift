//
//  LoginView.swift
//  SwiftUIChat
//
//  Created by Kirit on 10/02/23.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State private var name: String = ""
    @State private var number: String = ""
    @State private var code: String = ""
    @State var ref: DatabaseReference!
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    HStack(){
                        TextField("Enter your name", text: $name)
                            .padding(10)
                    }.background(GlobalColor.color_236_249_255)
                        .cornerRadius(10)
                        .padding(.leading , 20)
                        .padding(.trailing , 20)
                        .shadow(color: .gray.opacity(0.3), radius: 1)
                }
                HStack{
                    HStack(){
                        TextField("Enter your mobile number", text: $number)
                            .padding(10)
                    }.background(GlobalColor.color_236_249_255)
                        .cornerRadius(10)
                        .padding(.leading , 20)
                        .padding(.trailing , 20)
                        .shadow(color: .gray.opacity(0.3), radius: 1)
                }
                HStack{
                    HStack(){
                        TextField("Enter code", text: $code)
                            .padding(10)
                    }.background(GlobalColor.color_236_249_255)
                        .cornerRadius(10)
                        .padding(.leading , 20)
                        .padding(.trailing , 20)
                        .shadow(color: .gray.opacity(0.3), radius: 1)
                }.padding(.top , 10)
                Button("Login") {
                    onClickLogin()
                }
                .padding(.horizontal ,15)
                .padding(.vertical ,5)
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(5)
                .padding(.top , 10)
                
            }.frame(alignment: .top)
                .padding(.top , -150)
            Spacer()
        }.frame(width: DeviceSize.width,height: DeviceSize.height,alignment: .center)
            .background(GlobalColor.color_236_249_255)
            .onAppear(){
                viewDidLoad()
            }
    }
    
    private func viewDidLoad(){
        ref = Database.database().reference()
        checkUserExist()
    }
    
    func onClickLogin(){
        let dict = NSMutableDictionary()
        let id = ref.child("users").childByAutoId().key
        dict["mobile"] = number
        dict["code"] = code
        dict["name"] = name
        dict["id"] = id //ref.child("users").childByAutoId().key
        ref.child("users").child(id!).setValue(dict)
    }
    
    func checkUserExist(){
        let refUsers = ref.child("users")
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.hasChildren(){
                if let dictUsers = snapshot.value as? NSDictionary{
                    if let arrUsers = dictUsers.allValues as? NSArray{
                        for i in 0..<arrUsers.count{
                            if let dict = arrUsers.object(at: i) as? NSMutableDictionary{
                                print(dict)
                            }
                        }
                    }
                }
            }else{
                print("false room doesn't exist")
            }
        })
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
