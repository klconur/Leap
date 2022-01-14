//
//  ErrorView.swift
//  Leap
//
//  Created by ONUR KILIC on 13.01.2022.
//

import SwiftUI

struct ErrorView: View {
    var buttonHandler: (()->Void)?
    
    var body: some View {
        VStack {
            Text("NO INTERNET").font(.largeTitle).fontWeight(.bold)
            Text("You are not connected to Internet, please try later").font(.largeTitle).foregroundColor(.gray).multilineTextAlignment(.center).padding()
            Button(action: {
                buttonHandler?()
                }) {
                    Text("Try Again")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .font(.system(size: 18))
                        .padding()
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.white, lineWidth: 2)
                    )
                }
                .background(Color.black)
                .cornerRadius(25)
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
    }
}
