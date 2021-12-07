//
//  LearningApp.swift
//  Learning
//
//  Created by 王柏凱 on 2021-12-07.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
