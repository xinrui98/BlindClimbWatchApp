//
//  ControlsView.swift
//  MyWorkouts Watch App
//
//  Created by Xinrui gao on 17/1/23.
//

import SwiftUI
import AVFoundation

struct ControlsView: View {
    
    @EnvironmentObject var workoutManager: WorkoutManager
    
    @State var responseData: String = ""
    
    @State var isRunning: Bool = false
    
    let syn = AVSpeechSynthesizer()
    
    func generateRandomNumber() -> String {
        let randomNumber = Int.random(in: 10000000...99999999)
        return String(randomNumber)
    }

    var body: some View {
        
        HStack{
//            VStack{
//                Button{
//                    workoutManager.endWorkout()
//                } label: {
//                    Image(systemName: "xmark")
//                }
//                .tint(Color.red)
//                .font(.title2)
//                Text("End")
//            }
            VStack{
                Button{
                    
                    // Create the URL for the JSONPlaceholder API endpoint
                    guard let url = URL(string: "https://mzpoqw4tt9.execute-api.ap-southeast-1.amazonaws.com/Prod/applewatchstats") else { return }

                    // Create the URL request and configure it with the appropriate method (e.g., GET, POST, etc.)
                    var request = URLRequest(url: url)
                    request.httpMethod = "POST"
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

                    // Create a dictionary to hold the data to be sent in the request body
                    let postData = [ "id": generateRandomNumber(),
                                     "color":"",
                                     "timeInSeconds":String(workoutManager.builder?.elapsedTime ?? 0.0),
                                     "date":"",
                                     "calories":String(workoutManager.activeEnergy),
                                     "heartRate":String(workoutManager.heartRate.formatted(.number.precision(.fractionLength(0)))),
                                     "createdAt":"2022-02-26T16:37:48.244Z",
                                     "updatedAt":"2022-02-26T16:37:48.244Z"] as [String : Any]

                    // Convert the data to JSON format and add it to the request body
                    guard let httpBody = try? JSONSerialization.data(withJSONObject: postData, options: []) else { return }
                    request.httpBody = httpBody

                    // Create a URLSession and use it to send the request to the API endpoint
                    let session = URLSession.shared
                    session.dataTask(with: request) { data, response, error in
                        // Handle any errors that occur during the request
                        if let error = error {
                            print("Error: \(error.localizedDescription)")
                            return
                        }

                        // If there is data returned from the request, convert it to a string and print it to the console
                        if let data = data {
                            if let stringData = String(data: data, encoding: .utf8) {
                                print("Response: \(stringData)")
                                DispatchQueue.main.async {
                                    responseData = stringData
                                }
                            }
                        }
                    }.resume()
                    
                    print("WORKOUT STATS")
                    print(workoutManager.builder?.elapsedTime ?? 0.0)
                    print(workoutManager.activeEnergy)
                    print(workoutManager.heartRate.formatted(.number.precision(.fractionLength(0))))
                    
                    AudioManager.shared.startPlayer(track: "w_end")
                    
                    workoutManager.togglePause()
                    isRunning = !isRunning
                    

                } label: {
                    Image(systemName: "xmark").resizable(resizingMode: .stretch)
                        .font(.largeTitle)
                        .frame(width: 88, height: 88)
                }
                .tint(Color.red)
                .font(.title2)
                
            }
        }
    }
}

struct ControlsView_Previews: PreviewProvider {
    static var previews: some View {
        ControlsView()
    }
}
