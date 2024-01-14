//
//  CustomProgressView.swift
//  StarWarsApp
//
//  Created by Ikechukwu Onuorah on 10/01/2024.
//

import SwiftUI

struct CustomProgressView: View {
  var body: some View {
    ProgressView()
      .progressViewStyle(.automatic)
      .frame(width: 100, height: 100)
      .background(Color.secondary.colorInvert())
      .foregroundColor(Color.primary)
    .cornerRadius(20)    }
}

#Preview {
  CustomProgressView()
}
