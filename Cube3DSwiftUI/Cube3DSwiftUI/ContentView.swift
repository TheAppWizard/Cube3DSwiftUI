//
//  ContentView.swift
//  Cube3DSwiftUI
//
//  Created by Shreyas Vilaschandra Bhike on 07/06/21.
//  The App Wizard
//  Instagram : theappwizard2408

import SwiftUI


struct ContentView: View {
    
        var body: some View {
            FinalView()
            
        }
}
        


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


































struct FinalView: View {
    
        var body: some View {
        
        ZStack{
        Color.black.edgesIgnoringSafeArea(.all)
        CubeView().offset(x: 0, y: -95)
            
      
            
            ZStack{
                RoundedRectangle(cornerRadius: 75)
                .frame(width: 450, height: 400, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(.gray).opacity(0.2)
                .offset(x: 0, y: 350)
                
                VStack{
                    Text("WELCOME")
                        .font(.title)
                        .fontWeight(.thin)
                        .foregroundColor(Color.white)
                    
                    
                    ZStack{
                        
                        Circle()
                            .frame(width: 75, height: 75, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.clear)
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        
                        
                        
                        Image(systemName: "arrow.right")
                            .resizable()
                            .frame(width: 35, height: 30, alignment: .center)
                            .foregroundColor(.white)
                           
                            
                        
                        
                    }
                    
                    
                    
                   
              
                }.offset(x: 0, y: 300)
                
            }
        }
        
        
    }}

struct CubeView: View {
    
    
    var body: some View {
       
        ZStack{
            
            ForEach(0 ..< 10) {
                        CubeSet()
                        .offset( x: 100)
                        .rotationEffect(.degrees(Double($0) * 60))
                                                             
                         }
           
            
            
   
        }
    }
    
}




enum AllCubes: CaseIterable {
    
    static var indexOffset: Int = 0
    
    
    case one,two,three,four,five,clear
    
    var view: AnyView {
        switch self {
        case .one:
            return AnyView(Image("green").resizable().frame(width: 80, height: 80, alignment: .center))
        case .two:
            return AnyView(Image("yellow").resizable().frame(width: 80, height: 80, alignment: .center))
        case .three:
            return AnyView(Image("red").resizable().frame(width: 80, height: 80, alignment: .center))
        case .four:
            return AnyView(Image("blue").resizable().frame(width: 80, height: 80, alignment: .center))
        case .five:
            return AnyView(Image("orange").resizable().frame(width: 80, height: 80, alignment: .center))
        default:
            return AnyView(EmptyView())
//
        
        //Skeleton Cube : Skcube
//        case .one:
//            return AnyView(Image("skcube").resizable().frame(width: 100, height: 100, alignment: .center))
//        case .two:
//            return AnyView(Image("skcube").resizable().frame(width: 100, height: 100, alignment: .center))
//        case .three:
//            return AnyView(Image("skcube").resizable().frame(width: 100, height: 100, alignment: .center))
//        case .four:
//            return AnyView(Image("skcube").resizable().frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .center))
//        case .five:
//            return AnyView(Image("skcube").resizable().frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .center))
//        default:
//            return AnyView(EmptyView())
        }
    }
}

struct CubeSet: View {
    @State var allcubes = AllCubes.allCases
    @State var allIndices: [(CGFloat, CGFloat, Double, Bool)] = [
        (-80,40, 5, true),
        (-40,20, 3, false),
        (0,0, 1, false),
        (40,20, 2, true),
        (0,40, 4, false),
        (-40,60, 6, false)
    ]
    @State var currentIndex: Int = 4
    
    var body: some View {
        ZStack {
            ForEach(0..<allcubes.count) { index in
                cube(index: index)
            }
        }
        .onAppear {
            withAnimation {
                rotate()
            }
        }
    }
    
    func cube(index: Int) -> some View {
        let offset = allIndices[index]
        return allcubes[index].view
            .offset(x: offset.0, y: offset.1)
            .zIndex(offset.2)
    }
    
    func rotate() {
        let clearPosition = allIndices[5]
        
        allIndices[5] = allIndices[currentIndex]
        allIndices[currentIndex] = clearPosition
        
        currentIndex = currentIndex - 1
        
        if currentIndex == -1 {
            currentIndex = 4
        }
        
        if allIndices[currentIndex].3 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation {
                    rotate()
                }
            }
            
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation {
                    rotate()
                }
            }
        }
    }
}
