//
//  Menu.swift
//  pandaSystem
//
//  Created by Yusuke Tomatsu on 2020/11/24.
//

import SwiftUI

struct Menu: View {
    @ObservedObject var homeData : HomeViewModel
    var body: some View {
        VStack{
            Button(action:{}, label: {
                
                HStack(spacing: 15){
                    Image(systemName: "cart")
                        .font(.title)
                    
                    Text("cart")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    Spacer(minLength: 0)
                }
                .padding()
            })
            
            Spacer()
            HStack{
                Spacer()
                
                Text("version 0.1")
                    .fontWeight(.bold)
                    .foregroundColor(Color("blue"))
            }
            .padding(10)
        }
        .padding([.top, .trailing])
        .frame(width: UIScreen.main.bounds.width / 1.6)
        .background(Color.white.ignoresSafeArea())
    }
}


