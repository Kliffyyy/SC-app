//
//  CouncillorDetailView.swift
//  SC-app
//
//  Created by klifton Cheng stu on 21/3/23.
//

import SwiftUI

struct CouncillorDetailView: View {
    
    let councillor: Councillor
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(councillor.name)
                    .font(.largeTitle)
                    .bold()
                HStack{
                    Text("Subcomm:   ")
                    Spacer()
                    Text(" \(councillor.Subcomm.rawValue) ")
                        .padding(5)
                        .font(.footnote)
                        .background(.blue)
                        .cornerRadius(7)
                }.frame(width: 300)
                
                HStack(alignment: .center){
                    Text("Class:   ")
                    Spacer()
                    Text(" \(councillor.Class) ")
                        .padding(5)
                        .font(.footnote)
                        .background(.blue)
                        .cornerRadius(7)
                }.frame(width: 300)
                
                if councillor.ExCo == true {
                    Text("This person is a member of the Student Council ExCo")
                        .font(.footnote)
                        .underline()
                }
                
                Spacer()
            }
            Spacer()
        }.padding(20)
    }
}

struct CouncillorDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CouncillorDetailView(councillor: Councillor.names()[1])
    }
}
