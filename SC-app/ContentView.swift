//
//  ContentView.swift
//  SC-app
//
//  Created by klifton Cheng stu on 21/3/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var showingPopover = false
    
    var body: some View {
        List{
            
        } .toolbar() {
            ToolbarItem(placement: .primaryAction) {
                Button{
                    showingPopover = true
                } label: {
                    HStack{
//                        Image(systemName: "macwindow.on.rectangle")
                        Text("Window")
                            .font(.headline)
                            .padding(.trailing, 10)
                        Image(systemName: "chevron.down")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 10)
                            .offset(y: 1)
                    }
                }
                .popover(isPresented: $showingPopover) {
                    Text("Your content here")
                        .font(.headline)
                        .padding()
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
