
import SwiftUI

struct ListBreastCancerScreen: View {
    @ObservedObject var crud : CRUDViewModel = CRUDViewModel.getInstance()

     var body: some View
     { List(crud.currentBreastCancers){ instance in
     	ListBreastCancerRowScreen(instance: instance) }
       .onAppear(perform: { crud.listBreastCancer() })
     }
    
}

struct ListBreastCancerScreen_Previews: PreviewProvider {
    static var previews: some View {
        ListBreastCancerScreen(crud: CRUDViewModel.getInstance())
    }
}

