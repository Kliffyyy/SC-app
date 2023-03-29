//
//  SideBarView.swift
//  SC-app
//
//  Created by klifton Cheng stu on 21/3/23.
//

import SwiftUI

struct SideBarView: View {
    
    @State private var showSheet = false
    @State private var textInputName = ""
    @State private var textInputClass = ""
    @State var subcomm: Subcomm
    
    @ObservedObject var councillorManager: CouncillorManager = .shared
    
    var body: some View {
        VStack{
            List{
                ForEach(Array(councillorManager.councillors.enumerated()), id: \.1.id) { (index, item) in
                    NavigationLink(destination: CouncillorDetailView(councillor: item), label: {
                        withAnimation{
                            HStack{
                                VStack(alignment: .leading){
                                    Text(item.name)
                                        .lineLimit(1)
                                        .padding(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
                                }
                            }
                        }
                    })
//                    .onDeleteCommand {
//                        councillorManager.councillors.remove(at: index)
//                    }
                    .contextMenu {
                        Button{
                            print("button clicked")
                        } label: {
                            Text("Edit")
                                .foregroundColor(Color.primary)
                                .opacity(0.8)
                        }
                        .buttonStyle(.plain)
                        
                        Button{
                            councillorManager.councillors.remove(at: index)
                        } label: {
                            Text("Delete Councillor")
                                .foregroundColor(Color.primary)
                                .opacity(0.8)
                        }
                        .buttonStyle(.plain)
//                        .keyboardShortcut(.delete, modifiers: [.command])
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .padding(.bottom, 20)
            
            Button{
                showSheet.toggle()
            } label: {
                HStack{
                    Spacer()
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                    Spacer()
                }
                .padding(.init(top: 10, leading: 0, bottom: 10, trailing: 0))
            }
            .buttonStyle(.borderless)
            .sheet(isPresented: $showSheet) {
                SheetView(councillorName: $textInputName, councillorClass: $textInputClass, subcomm: $subcomm)
            }
            .frame(height: 50)
            Spacer()
        }
    }
}

struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var councillorName: String
    @Binding var councillorClass: String
    @Binding var subcomm: Subcomm
    
    @ObservedObject var councillorManager: CouncillorManager = .shared
    
    var body: some View {
        VStack(alignment: .leading){
            Spacer()
            
            TextField("Councillor Name", text: $councillorName)
                .padding(5)
                .background(.gray)
                .cornerRadius(10)
                .font(.caption)
            TextField("SX-0X", text: $councillorClass)
                .padding(5)
                .background(.gray)
                .cornerRadius(10)
                .font(.caption)
            Picker("Subcomm", selection: $subcomm) {
                ForEach(Subcomm.allCases, id: \.rawValue) { subcomm in
                    Text(subcomm.rawValue).tag(subcomm)
                }
            }.pickerStyle(.menu)
            
            Button("Confirm") {
                councillorManager.councillors.append(Councillor(name: councillorName, formClass: councillorClass, subcomm: subcomm))
                councillorName = ""
                councillorClass = ""
                subcomm = .None
                dismiss()
            }
            .keyboardShortcut(.return)
            .font(.title)
            .padding()
            .background(Color.orange)
            .cornerRadius(10)
            
        }.padding(10)
    }
}

//struct SideBarView_Previews: PreviewProvider {
//    @ObservedObject var councillorManager: CouncillorManager = .shared
//    @State var subcomm: Subcomm
//    static var previews: some View {
//        SideBarView(councillor: councillorManager.councillors, subcomm: subcomm)
//    }
//}
