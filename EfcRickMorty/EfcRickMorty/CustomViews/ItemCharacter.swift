//
//  ItemCharacter.swift
//  EfcRickMorty
//
//  Created by efulgencio on 20/4/24.
//

import SwiftUI

struct ItemCharacter: View {
    
    let item: ListItem
    
    var body: some View {
        VStack(spacing: 5) {
            HStack{
                Text("\(item.id)")
                    .padding(.leading, 20)
                HStack {
                    Text("\(item.name)")
                        .padding(.horizontal, 20)
                    Spacer()
                    AsyncImage(url: URL(string: item.image)){ image in
                        image.resizable()
                            .cornerRadius(25)
                    } placeholder: {
                        imagePlaceHolder
                    }
                    .frame(width: 50, height: 50)
                    .padding()
                }
                .modifier(CustomModifierCardDetailItem())
                .shadow(radius: 20)

            }
            .frame(maxWidth: .infinity)
            .background(Color.themeItem.body)
            .clipShape(RoundedCorner(radius: 30, corners: [.bottomLeft, .topRight]))
        
        }.padding(20)
    }
    
    private var imagePlaceHolder: some View {
        Image(systemName:"person.crop.circle")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.white)
    }
    
}


struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    ItemCharacter(item: ListItem.mock())
}
