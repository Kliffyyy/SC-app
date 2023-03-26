//
//  SideBarView.swift
//  SC-app
//
//  Created by klifton Cheng stu on 21/3/23.
//

import SwiftUI

struct SideBarView: View {
    
    let councillor: [Councillor]
    
//    @State var item: Subcomm! = .None
    @State private var showSheet = false
    @State private var textInputName = ""
    @State private var textInputClass = ""
    
    @State var subcomm: Subcomm
    
    @StateObject var councillorManager = CouncillorManager()
    
    var body: some View {
        List{
            ForEach(councillor) { i in
                NavigationLink(destination: CouncillorDetailView(councillor: i), label: {
                    Text(i.name)
                })
            }
        }
        .overlay{
            VStack{
                Spacer()
                HStack{
                    Spacer(minLength: 4)
                    Button{
                        showSheet.toggle()
//                        councillorManager.councillors.append(Councillor(name: "your new student councillor", formClass: "SX0X", subcomm: .Discipline))
                        print("this is councillors: \(councillorManager.councillors)")
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                    }
                    .sheet(isPresented: $showSheet) {
                        SheetView(councillorName: $textInputName, councillorClass: $textInputClass, subcomm: $subcomm)
                    }
                    
                    Spacer()
                }
                .padding(10)
                .frame(height: 50)
                .background(Color(red: 20/255, green: 20/255, blue: 20/255, opacity: 0.8))
            }
        }
    }
}

struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var councillorName: String
    @Binding var councillorClass: String
    @Binding var subcomm: Subcomm
    
    @StateObject var councillorManager = CouncillorManager()
    
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
            
            Button("Press to dismiss") {
                councillorManager.councillors.append(Councillor(name: councillorName, formClass: councillorClass, subcomm: subcomm))
                dismiss()
            }
            .font(.title)
            .padding()
            .background(Color.orange)
            .cornerRadius(10)
            
        }.padding(10)
    }
}

//struct SideBarView_Previews: PreviewProvider {
//    @Binding var subcomm: Subcomm
//    static var previews: some View {
//        SideBarView(councillor: CouncillorManager().councillors, subcomm: $subcomm)
//    }
//}
