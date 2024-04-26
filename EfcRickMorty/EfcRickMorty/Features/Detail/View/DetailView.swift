//
//  DetailView.swift
//  EfcRickMorty
//
//  Created by efulgencio on 16/4/24.
//

import SwiftUI

struct DetailView: View {
    
    @StateObject private var viewModel: DetailViewModel = DetailViewModel()
    @EnvironmentObject var characterData: CharacterData
    @State private var optionShow: OptionSelected = OptionSelected.character
    
    var body: some View {
        ZStack {
            
            RadialGradient(stops: [
                .init(color: Color.themeItem.header, location: 0.3),
                .init(color: Color.themeItem.body, location: 0.3)
            ], center: .top, startRadius: 100, endRadius: 200)
            .ignoresSafeArea()
            
            VStack{
                switch viewModel.viewModelState {
                case .loadingView:
                    LoadingView()
                case .errorView(let error):
                    Text(error)
                case .loadedView, .filteredView:
                    detailView
                }
            }
            .task {
                viewModel.getDetail(id: characterData.idSelected)
            }
        }
    }
}

extension DetailView {
    
    private var detailView: some View {
        VStack {
            header
                .frame(height: 80)
            headerOptions
            ZStack {
             switch optionShow {
                 case .character:
                    characterView
                 case .location:
                    locationView
                 case .episode:
                    episodeView
             }
            }
            Spacer()
        }
        .padding()
    }
    
    private var headerOptions: some View {
        HStack {
            VStack {
                Text("Character")
                    .modifier(CustomModifierCardDetailItem(heightContent: CGFloat(40)))
                Divider()
                   .frame(height: 6)
                   .background(optionShow == .character ? Color.themeOption.optionOne: Color.themeOption.unSelectedOption)
            }.onTapGesture {
                optionShow = OptionSelected.character
            }
            VStack {
                Text("Location")
                    .modifier(CustomModifierCardDetailItem(heightContent: CGFloat(40)))
                Divider()
                   .frame(height: 6)
                   .background(optionShow == .location ? Color.themeOption.optionTwo : Color.themeOption.unSelectedOption)
            }.onTapGesture {
                optionShow = OptionSelected.location
            }
            VStack {
                Text("Episode")
                    .modifier(CustomModifierCardDetailItem(heightContent: CGFloat(40)))
                Divider()
                   .frame(height: 6)
                   .background(optionShow == .episode ? Color.themeOption.optionThree : Color.themeOption.unSelectedOption)
            }.onTapGesture {
                optionShow = OptionSelected.episode
            }
        }.padding(.top, 50)
    }
    
    private var characterView: some View {
        VStack {
            CardDetail(detailItem: viewModel.character.data)
                .padding(.top, 10)
        }
    }
    
    private var locationView: some View {
        HStack {
            Text(viewModel.character.data!.location)
                .modifier(CustomModifierCardDetailItem())
        }
        .padding(.horizontal)
    }
    
    private var episodeView: some View {
        List(viewModel.character.data!.episode, id: \.self) { item in
            Text(item)
                .modifier(CustomModifierCardDetailItem())
        }.listStyle(PlainListStyle())
    }
    
    private var header: some View {
        HStack {
            Text("Rick and Morty (DETAIL)")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(.white)
        }
        .padding(.horizontal)
    }
    
    
}

#Preview {
    ListView()
}
