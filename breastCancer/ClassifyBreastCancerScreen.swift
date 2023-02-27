import Foundation
import SwiftUI

struct ClassifyBreastCancerScreen: View {
    @State var objectId: String = ""
    @ObservedObject var model : ModelFacade
    
    @State var result = ""

    var body: some View {
  	NavigationView {
  		ScrollView {
        VStack {
             HStack (spacing: 20) {
             	Text("id:").bold()
             	Divider()
                Picker("Select a object", selection: $objectId) {
                  ForEach(model.currentBreastCancers) { Text($0.id).tag($0.id) }
                }.pickerStyle(.menu)
             }.frame(width: 200, height: 30).border(Color.gray)
                        
             VStack (spacing: 20) {
             	Text("Result:").bold()
                Text("\(result)")
             }.frame(width: 200, height: 60).border(Color.gray)
             
             HStack (spacing: 20) {
                Button(action: { result = self.model.classifyBreastCancer(x: objectId) } ) { Text("Classify") }
				Button(action: {self.model.cancelClassifyBreastCancer() } ) { Text("Cancel") }
		     }.buttonStyle(.bordered)
        }.onAppear(perform:
        	{ objectId = model.currentBreastCancer?.id ?? "id" 
        	  model.listBreastCancer()
        	})
        }.navigationTitle("classifyBreastCancer")
      }
    }
}

struct ClassifyBreastCancerScreen_Previews: PreviewProvider {
    static var previews: some View {
        ClassifyBreastCancerScreen(model: ModelFacade.getInstance())
    }
}

