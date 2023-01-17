//
//  ContentView.swift
//  MyWorkouts Watch App
//
//  Created by Xinrui gao on 17/1/23.
//

import SwiftUI
import HealthKit

//struct TempView: View {
//    @EnvironmentObject var workoutManager: WorkoutManager
//    
//    var body: some View {
//        SessionPagingView()
//    }
//}

struct ContentView: View {
    
    //    @EnvironmentObject var workoutManager: WorkoutManager
    
//    @StateObject var workoutManager = WorkoutManager()
    @EnvironmentObject var workoutManager: WorkoutManager

    
    var climbWorkout: HKWorkoutActivityType = .running
    
    var body: some View {
        VStack{
            NavigationStack{
                
                Image(systemName: "headphones")
                    .font(.system(size: 30))
                
                Spacer()
                Spacer()
                Spacer()
                
                
                Text("Connect Bluetooth headphones to your AI climb assistant")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                
                Spacer()
                Spacer()
                Spacer()
                
                NavigationLink(destination:         SessionPagingView().onAppear {
                    workoutManager.selectedWorkout = climbWorkout
                }) {
                    Text("Start Climb")
                }
                
            }
            .environmentObject(workoutManager)
        }.onAppear{
            workoutManager.requestAuthorization()
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
