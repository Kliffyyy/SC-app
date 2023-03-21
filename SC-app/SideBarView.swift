//
//  SideBarView.swift
//  SC-app
//
//  Created by klifton Cheng stu on 21/3/23.
//

import SwiftUI

struct SideBarView: View {
    
    let councillor: [Councillor]
    
    var body: some View {
        List{
            ForEach(councillor) { i in
                NavigationLink(destination: CouncillorDetailView(councillor: i), label: {
                        Text(i.name)
                })
            }
        }
    }
}

struct SideBarView_Previews: PreviewProvider {
    static var previews: some View {
        SideBarView(councillor: Councillor.names())
    }
}
