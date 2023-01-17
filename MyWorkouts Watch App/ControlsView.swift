//
//  ControlsView.swift
//  MyWorkouts Watch App
//
//  Created by Xinrui gao on 17/1/23.
//

import SwiftUI

struct ControlsView: View {
    
    @EnvironmentObject var workoutManager: WorkoutManager
    
    @State var isRunning: Bool = false
    
    var body: some View {
        
        HStack{
            VStack{
                Button{
                    workoutManager.endWorkout()
                } label: {
                    Image(systemName: "xmark")
                }
                .tint(Color.red)
                .font(.title2)
                Text("End")
            }
            
            if isRunning{
                VStack{
                    Button{
                        workoutManager.togglePause()
                        isRunning = !isRunning
                    } label: {
                        Image(systemName: "play")
                    }
                    .tint(Color.yellow)
                    .font(.title2)
                    Text("Play")
                }
            }else{
                VStack{
                    Button{
                        workoutManager.togglePause()
                        isRunning = !isRunning
                    } label: {
                        Image(systemName: "pause")
                    }
                    .tint(Color.yellow)
                    .font(.title2)
                    Text("pause")
                }
            }
        }
    }
}

struct ControlsView_Previews: PreviewProvider {
    static var previews: some View {
        ControlsView()
    }
}
