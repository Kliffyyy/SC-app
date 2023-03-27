//
//  ContentView.swift
//  SC-app
//
//  Created by klifton Cheng stu on 21/3/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var showingPopover = false
    @ObservedObject var councillorManager: CouncillorManager = .shared
    @State var subcomm: Subcomm
    
    var body: some View {
        
        NavigationView{
            SideBarView(councillor: councillorManager.councillors, subcomm: subcomm)
        }
        .toolbar {
            ToolbarItem(placement: .automatic) {
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
                .popover(isPresented: $showingPopover, attachmentAnchor: .rect(.bounds), arrowEdge: .bottom) {
                    Text("Your content here")
                        .font(.headline)
                        .padding()
                }
            }
            
            ToolbarItem(placement: .navigation){
                Button{
                    toggleSidebar()
                } label: {
                    Image(systemName: "sidebar.left")
                }
            }
//            ToolbarItemGroup(placement: .automatic){
//                Image(systemName: "sidebar.left")
//                Menu{
//                    Image(systemName: "gear")
//                    Image(systemName: "gear.1")
//                } label: {
//                    Image(systemName: "square.and.arrow.up")
//                }
//            }
        }
    }
    
    private func toggleSidebar() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(subcomm: .None)
    }
}
