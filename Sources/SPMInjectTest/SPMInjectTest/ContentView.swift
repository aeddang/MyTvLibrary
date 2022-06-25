//
//  ContentView.swift
//  SPMInjectTest
//
//  Created by JeongCheol Kim on 2022/06/25.
//

import SwiftUI
import CoreData
import Kingfisher
import MyTvLib
class CustomMyTvLauncherObservable : MyTvLauncherObservable{
    
    func setup(id:String, token:String){
        self.id = id
        self.token = token
        self.event = .updated
    }
    
    func setLogLv(_ lv:MyTvAppLogLv){
        self.logLv = lv
        self.event = .updatedLogLv(lv)
    }
    
    override func requestCaptureImages(completed: (String) -> Void) {
        completed("{jsonString}")
    }
    
    override func requestUserInfo(completed: (String) -> Void) {
        completed("{jsonString}")
    }
    
    override func requestLog(json: String) {

    }
    override func requestAdultCertification(json: String, completed: (String) -> Void) {
        completed("{jsonString}")
    }
}

struct ContentView: View {
    enum TestType{
        case player, download
    }
    @ObservedObject var launcher = CustomMyTvLauncherObservable()
    @State var type:TestType? = nil
    
    var body: some View {
        ZStack{
            if type == .player {
                MyTvPlayer(launcher: self.launcher)
        
            } else if type == .download {
                MyTvDownLoad()
                   
            } else {
                VStack(spacing:100){
                    Button(action: {
                        self.type = .player
                    }) {
                        Text("MyTV TEST")
                    }
                    Button(action: {
                        self.type = .player
                        self.launcher.request = .moveChannel(channelId: "C0160")
                    }) {
                        Text("MyTV Go YTN")
                    }
                    Button(action: {
                        self.type = .download
                    }) {
                        Text("DownLoad TEST")
                    }
                }
            }
            
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear{
            self.launcher.initBackgroundDownLoadTask() //옙 최초실행시 백그라운드 테스크 등록가능
            self.launcher.setup(
                id: "APL00000BO9AEFUJQ0HS",
                token: "eyJraWQiOiJlbmMiLCJhbGciOiJIUzI1NiJ9.eyJleHQiOnsidXNyIjoiQVBMMDAwMDBCTzlBRUZVSlEwSFMiLCJkdmMiOiJBUEwwMDAwMEJPOUFFRldSTVJLMCIsInRrbiI6IjhCNTI2MENENDA1OTRFM0Q4RDZEOEIzRkQ3Q0NEMkY1IiwicG9jIjoiYXBwLmFwb2xsby5hZ2VudCIsInNybCI6IkExODAzNTAzMUFEMjQ0OEU5RUNEMTBEQUUxQTZDREExMjAyMjA0MDExMTM0NTciLCJzdmMiOiJhcG9sbG8ifSwic3ViIjoiQVBMMDAwMDBCTzlBRUZVSlEwSFMiLCJhdWQiOiJhcHAuYXBvbGxvLmFnZW50IiwibmJmIjoxNjU1MzYzMDMwLCJ1c2VyX25hbWUiOiJBUEwwMDAwMEJPOUFFRlVKUTBIUyIsImlzcyI6Imh0dHBzOlwvXC9zdGctYWNjb3VudC5za3RhcG9sbG8uY29tIiwiZXhwIjoxNjU3MDA0NjMwLCJpYXQiOjE2NTUzNjMwMzAsImp0aSI6IjhiNTI2MGNkLTQwNTktNGUzZC04ZDZkLThiM2ZkN2NjZDJmNSIsImNsaWVudF9pZCI6ImFwcC5hcG9sbG8uYWdlbnQifQ.lZUf5F20WJNDRFK3ezmFmtBx_5UtEtTBaUdlJtkea0Y")
            self.launcher.setLogLv(.all)
        }
    }
}


