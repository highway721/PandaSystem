//
//  Home.swift
//  pandaSystem
//
//  Created by Yusuke Tomatsu on 2020/11/23.
//

import SwiftUI

struct Home: View {
    @StateObject var HomeModel = HomeViewModel()
    var body: some View {
        ZStack{
            VStack(spacing: 10){
                
                HStack(spacing: 15){
                    Button(action: {
                        withAnimation(.easeIn){
                            HomeModel.showMenu.toggle()
                        }
                           }){
                            Text("Order here")
                           }
                    
                    Text(HomeModel.userLocation == nil ? "Locating.." : "Deliver to")
                        .foregroundColor(.black)
                    Text(HomeModel.userAddress)
                        .font(.caption)
                    Spacer(minLength: 0)
                }
                .padding([.horizontal,.top])
                Divider()
                
                HStack(spacing: 15){
                    TextField("search",text:$HomeModel.search)
                    if HomeModel.search != ""{
                        Button(action: {}, label: {
                            Image(systemName: "magnifyingglass")
                                .font(.title2)
                                .foregroundColor(.gray)
                        })
                        .animation(.easeIn)
                    }
                }
                .padding(.horizontal)
                .padding(.top,10)
                Divider()
                
                ScrollView(.vertical, showsIndicators: false, content:{
                    VStack(spacing:25){
                        ForEach(HomeModel.items){ item in
                            //item view
                            Text(item.item_name)
                        }
                    }
                })
            }
            //side menu
            HStack{
                Menu(homeData:  HomeModel)
                    //moving effect
                    .offset(x:HomeModel.showMenu ? 0 : -UIScreen.main.bounds.width / 1.6)
                Spacer(minLength: 0)
            }
            .background(Color.black.opacity(HomeModel.showMenu ? 0.3 : 0).ignoresSafeArea())
            //closing the side bar when the user touches outside
            .onTapGesture(perform: {
                                    withAnimation(.easeIn){HomeModel.showMenu.toggle()}
                                })
            
            //if permission is denied, the alert remains
            if HomeModel.noLocation{
                Text("Plz enable location system")
                    .foregroundColor(.black)
                    .frame(width: 100, height: 120)
                    .background(Color.white)
                    .cornerRadius(10)
                    .frame(minWidth: .infinity, maxWidth:.infinity)
                    .background(Color.black.opacity(0.3).ignoresSafeArea())
                    
                
            }
        }
        .onAppear(perform: {
            
            HomeModel.locationManager.delegate = HomeModel
           
        })
    }
}



