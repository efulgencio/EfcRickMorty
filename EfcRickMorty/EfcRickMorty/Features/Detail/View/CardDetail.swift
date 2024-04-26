//
//  CardDetail.swift
//  EfcRickMorty
//
//  Created by efulgencio on 22/4/24.
//

import SwiftUI

struct CardDetail: View {
    
    let detailItem: DetailItem?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text(detailItem!.name)
                    .padding(20)
                Spacer()
                AsyncImage(url: URL(string: detailItem!.image)){ image in
                    image.resizable()
                        .cornerRadius(25)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 50)
                .padding()
            }
            .modifier(CustomModifierCardDetailItem(colorBack: Color.themeCardDetail.header))
   
            Spacer()
            
            TextValueRow(textItem: "Status", valueItem: detailItem!.status.iconDescription!)
            TextValueRow(textItem: "Sexo", valueItem: detailItem!.gender.iconDescription!)
        }
        .frame(height: 200)
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.themeCardDetail.body)
        .clipShape(RoundedCorner(radius: 30, corners: [.bottomLeft, .topRight]))
        
    }
}

#Preview {
    CardDetail(detailItem: DetailItem.getMock())
}
