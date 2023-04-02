//
//  ContentView.swift
//  SC-app
//
//  Created by klifton Cheng stu on 21/3/23.
//

import SwiftUI

struct ContentView: View {
    var controlPoint: Double = 0.0
    @State private var showingPopover = false
    @State private var showToolbar = false
    @State private var toolbarState = true
    @State private var sidebarX: Double = 17
    @ObservedObject var councillorManager: CouncillorManager = .shared
    @State var subcomm: Subcomm
    
    
    var body: some View {
        
        NavigationView {
            SideBarView(subcomm: subcomm)
                .frame(minWidth: 200, minHeight: 300)
                .toolbar {
                    ToolbarItem(placement: .primaryAction){
                        Button {
                            toggleSidebar()
                            toolbarState.toggle()
                            sidebarX += toolbarState ? 14 : -14
                        } label: {
//                            Image(systemName: toolbarState ? "sidebar.left" : "sidebar.right")
//                                .animation(.easeInOut(duration: 0.2), value: toolbarState)
                            
                            CustomSideBarToggleIcon(controlPoint: controlPoint, toggle: toolbarState, x: sidebarX)
                                .stroke(.primary, style: StrokeStyle(lineWidth: 1.7, lineCap: .round, lineJoin: .round))
                                .frame(width: 20, height: 15)
                                .offset(x: 0, y: 0)
                                .scaledToFit()
                        }
//                        .animation(.easeInOut(duration: 1), value: toolbarState)
                        .animation(.linear(duration: 5), value: sidebarX)
                    }
                    ToolbarItem(placement: .automatic) {
                        
                    }
                }
        }
        .frame(minWidth: 500)
        .toolbar {
            Button {
                showingPopover = true
            } label: {
                HStack{
                    Text("Window")
                        .font(.headline)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 10)
                        .offset(y: 1)
                }
            }
            .padding(7)
            .buttonStyle(.bordered)
            .popover(isPresented: $showingPopover, attachmentAnchor: .rect(.bounds), arrowEdge: .bottom) {
                PopoverView()
            }

        }
//        .toolbar(showToolbar ? .visible : .hidden, for: .automatic)
//        .onChange(of: , perform: showToolbar.toggle())
    }
    
    private func toggleSidebar() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
}

struct CustomSideBarToggleIcon: Shape {
    var controlPoint: Double
    var toggle: Bool
    var x: Double
    
    func path(in rect: CGRect) -> Path {
        var pencil = Path()
        
        // INSTRUCTIONS
        // 1. Move to an origin
        pencil.move(to: CGPoint(x: rect.minX + 2, y: rect.minY))
        pencil.addLine(to: CGPoint(x: rect.minX + 2, y: rect.minY))
        
        pencil.addLine(to: CGPoint(x: rect.maxX - 2, y: rect.minY))
        pencil.addArc(center: CGPoint(x: rect.maxX - 2, y: rect.minY + 2), radius: 2, startAngle: Angle(degrees: 270), endAngle: Angle(degrees: 0), clockwise: false)
        pencil.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - 2))
        pencil.addArc(center: CGPoint(x: rect.maxX - 2, y: rect.maxY - 2), radius: 2, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
        pencil.addLine(to: CGPoint(x: rect.minX + 2, y: rect.maxY))
        pencil.addArc(center: CGPoint(x: rect.minX + 2, y: rect.maxY - 2), radius: 2, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
        pencil.addLine(to: CGPoint(x: rect.minX, y: rect.minY + 2))
        pencil.addArc(center: CGPoint(x: rect.minX + 2, y: rect.minY + 2), radius: 2, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)

        pencil.closeSubpath()
        
        // Draw Line
        pencil.move(to: CGPoint(x: x, y: rect.minY + 4))
        pencil.addLine(to: CGPoint(x: x, y: rect.minY + 4))
        pencil.addLine(to: CGPoint(x: x, y: rect.maxY - 4))
        pencil.closeSubpath()
        
        
//        if toggle {
//            pencil.move(to: CGPoint(x: rect.maxX - x, y: rect.minY + x))
//            pencil.addLine(to: CGPoint(x: rect.maxX - x, y: rect.minY + x))
//            pencil.addLine(to: CGPoint(x: rect.maxX - x, y: rect.maxY - x))
//            pencil.closeSubpath()
//        } else {
//            pencil.move(to: CGPoint(x: rect.minX + x, y: rect.minY + x))
//            pencil.addLine(to: CGPoint(x: rect.minX + x, y: rect.minY + x))
//            pencil.addLine(to: CGPoint(x: rect.minX + x, y: rect.maxY - x))
//            pencil.closeSubpath()
//
//        }
        
        return pencil
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(subcomm: .None)
    }
}
