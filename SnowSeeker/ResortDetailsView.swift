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
    var size: String {
        switch resort.size {
        case 1:
            return "Small"
        case 2:
            return "Average"
        default:
            return "Large"
        }
    }
    var price: String {
        String(repeating: "$", count: resort.price)
    }
    
    var body: some View {
        Group {
            Text("Size: \(size)").layoutPriority(1)
            Spacer().frame(height: 0)
            Text("Price: \(price)").layoutPriority(1)
        }
    }
}

struct ResortDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ResortDetailsView(resort: .example)
    }
}
