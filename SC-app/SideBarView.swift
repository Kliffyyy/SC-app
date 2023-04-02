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
            List {
                Text("Councillors")
                    .font(.footnote)
                    .foregroundColor(.gray)
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
                    }
                }
            }
            .scrollContentBackground(.hidden)
            
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
        VStack(alignment: .leading) {
            Spacer()
            
            TextField("Councillor Name", text: $councillorName)
                .cornerRadius(10)
                .font(.callout)
                .textFieldStyle(.roundedBorder)
            ValidatableTextField("SX0X", text: $councillorClass, validation: { !$0.contains("-") })
                .cornerRadius(10)
                .font(.callout)
                .textFieldStyle(.roundedBorder)
            Picker("Subcomm", selection: $subcomm) {
                ForEach(Subcomm.allCases, id: \.rawValue) { subcomm in
                    Text(subcomm.rawValue)
                        .tag(subcomm)
                }
            }
            .pickerStyle(.menu)
            HStack {
                Button("Confirm") {
                    councillorManager.councillors.append(Councillor(name: councillorName, formClass: councillorClass, subcomm: subcomm))
                    councillorName = ""
                    councillorClass = ""
                    subcomm = .None
                    dismiss()
                }
                .keyboardShortcut(.return)
                .font(.caption)
                .cornerRadius(10)
                
                Button("Cancel") {
                    councillorName = ""
                    councillorClass = ""
                    subcomm = .None
                    dismiss()
                }
                .keyboardShortcut(.cancelAction)
                .font(.caption)
                .cornerRadius(10)
            }
        }
        .frame(maxWidth: 500)
        .padding(10)
    }
}

//struct SideBarView_Previews: PreviewProvider {
//    @ObservedObject var councillorManager: CouncillorManager = .shared
//    @State var subcomm: Subcomm
//    static var previews: some View {
//        SideBarView(councillor: councillorManager.councillors, subcomm: subcomm)
//    }
//}
