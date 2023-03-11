              
              
import SwiftUI

@main 
struct breastcancerMain : App {

	var body: some Scene {
	        WindowGroup {
                ContentView(model: ClassificationViewModel.getInstance(), crud: CRUDViewModel.getInstance())
	        }
	    }
	} 
