//
//  ContentView.swift
//  MyWorkouts Watch App
//
//  Created by Xinrui gao on 17/1/23.
//

import SwiftUI
import HealthKit
import AVFoundation

struct ContentView: View {
    
    @State private var textToSpeak = "Hello, this is a sample text to speak."
    
    @EnvironmentObject var workoutManager: WorkoutManager
    
    var climbWorkout: HKWorkoutActivityType = .running
    
    let syn = AVSpeechSynthesizer()
    
    var body: some View {
        
        VStack{
            NavigationStack{
                
                //                Image(systemName: "headphones")
                //                    .font(.system(size: 30))
                
                
                //                Text("Connect Bluetooth headphones to your AI climb assistant")
                //                    .font(.footnote)
                //                    .multilineTextAlignment(.center)
                
                NavigationLink(destination: SessionPagingView().onAppear {
                    
                    let utterance = AVSpeechUtterance(string: "Workout started")
                    utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
                    utterance.rate = 0.5
                    
                    syn.speak(utterance)
                    
                    workoutManager.selectedWorkout = climbWorkout
                }
                ) {
                    
                    Image(systemName: "play.fill").resizable(resizingMode: .stretch)
                        .font(.largeTitle)
                        .frame(width: 88, height: 88)
                    
                }
                
            }
            .environmentObject(workoutManager)
        }.onAppear{
            workoutManager.requestAuthorization()
            let utterance = AVSpeechUtterance(string: "Tap on watch face to start workout")
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            utterance.rate = 0.5
            
            syn.speak(utterance)
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension HKWorkoutActivityType: Identifiable {
    public var id: UInt {
        rawValue
    }
    
    var name: String {
        switch self{
            case .running:
                return "climbing"
            default:
                return ""
        }
    }
}
