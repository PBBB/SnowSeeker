//
//  ResortDetailsView.swift
//  SnowSeeker
//
//  Created by Issac Penn on 2019/12/30.
//  Copyright © 2019 Issac Penn. All rights reserved.
//

import SwiftUI

struct ResortDetailsView: View {
    let resort: Resort
    
    var body: some View {
        Group {
            Text("Size: \(resort.sizeString)").layoutPriority(1)
            Spacer().frame(height: 0)
            Text("Price: \(resort.priceString)").layoutPriority(1)
        }
    }
}

struct ResortDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ResortDetailsView(resort: .example)
    }
}
