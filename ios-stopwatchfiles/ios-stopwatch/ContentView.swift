//
//  ContentView.swift
//  ios-stopwatch
//
//  Created by Yuv Rout on 1/30/24.
//

import SwiftUI

struct ContentView: View {
    @State private var timeElapsed = 0.00
    @State private var timerRunning = false
    @State private var laps: [String] = []
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            Text(String(format: "%02d:%05.2f", Int(timeElapsed) / 60, timeElapsed.truncatingRemainder(dividingBy: 60)))
                .font(.system(size: 85))
                .onReceive(timer) { _ in
                    if timerRunning {
                        timeElapsed += 0.1
                    }
                }
            
            HStack(spacing: 20) {

                Button(action: {
                    if timerRunning {
  
                        let lapTime = String(format: "%02d:%05.2f", Int(timeElapsed) / 60, timeElapsed.truncatingRemainder(dividingBy: 60))
                        laps.insert("Lap \(laps.count + 1): \(lapTime)", at: 0)
                    } else {

                        timeElapsed = 0.00
                        laps.removeAll()
                    }
                }) {
                    Text(timerRunning ? "Lap" : "Reset")
                }
                .frame(width: 175, height: 100)
                .foregroundColor(.white)
                .background(Color.gray)
                .clipShape(Circle())


                Button(action: {
                    timerRunning.toggle()
                }) {
                    Text(timerRunning ? "Stop" : "Start")
                }
                .frame(width: 175, height: 100)
                .font(.system(size: 30))
                .foregroundColor(.white)
                .background(timerRunning ? Color.red : Color.green)
                .clipShape(Circle())
            }

            List {
                ForEach(laps, id: \.self) { lap in
                    Text(lap)
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
