//
//  TabView.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 22.10.24.
//

import SwiftUI

struct TabCellView: View {
  
  var model: TabModel
  
    var body: some View {
      model.image
        .renderingMode(.template)
    }
  
}

#Preview {
  TabCellView(model: .addBirthday)
}
