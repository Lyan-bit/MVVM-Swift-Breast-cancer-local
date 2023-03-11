              
              
              
import SwiftUI

struct ContentView : View {
	
	@ObservedObject var model : ClassificationViewModel
    @ObservedObject var crud : CRUDViewModel
	                                       
	var body: some View {
		TabView {
            CreateBreastCancerScreen (crud: crud).tabItem {
                        Image(systemName: "1.square.fill")
	                    Text("+BreastCancer")} 
            ListBreastCancerScreen (crud: crud).tabItem {
                        Image(systemName: "2.square.fill")
	                    Text("ListBreastCancer")} 
            ClassifyBreastCancerScreen (model: model, crud: crud).tabItem {
                        Image(systemName: "3.square.fill")
	                    Text("ClassifyBreastCancer")} 
				}.font(.headline)
		}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: ClassificationViewModel.getInstance(), crud: CRUDViewModel.getInstance())
    }
}

