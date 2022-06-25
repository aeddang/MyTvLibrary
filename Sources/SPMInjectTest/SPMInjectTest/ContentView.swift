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
    @ObservedObject var launcher = CustomMyTvLauncherObservable()
    var body: some View {
        MyTvPlayer(launcher: self.launcher)
    }
}

