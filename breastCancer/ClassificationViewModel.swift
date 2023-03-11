
import Foundation
import SwiftUI

class ClassificationViewModel : ObservableObject {
        
static var instance : ClassificationViewModel? = nil
private var modelParser : ModelParser? = ModelParser(modelFileInfo: ModelFile.modelInfo)
    private var crud : CRUDViewModel = CRUDViewModel ()

static func getInstance() -> ClassificationViewModel {
if instance == nil
{ instance = ClassificationViewModel() }
return instance! }
        
init() {
// init
}

func classifyBreastCancer(x : String) -> String {
    guard let breastCancer = crud.getBreastCancerByPK(val: x)
else {
return "Please selsect valid id"
}

guard let result = self.modelParser?.runModel(
input0: Float((breastCancer.age - 24) / (89 - 24)),
input1: Float((breastCancer.bmi - 18.37) / (38.5787585 - 18.37)),
input2: Float((breastCancer.glucose - 60) / (201 - 60)),
input3: Float((breastCancer.insulin - 2.432) / (58.46 - 2.432)),
input4: Float((breastCancer.homa - 4.311) / (90.28 - 4.311)),
input5: Float((breastCancer.leptin - 1.6502) / (38.4 - 1.6502)),
input6: Float((breastCancer.adiponectin - 3.21) / (82.1 - 3.21)),
input7: Float((breastCancer.resistin - 45.843) / (1698.44 - 45.843)),
input8: Float((breastCancer.mcp - 45.843) / (1698.44 - 45.843))
) else{
return "Error"
}

breastCancer.outcome = result
    crud.persistBreastCancer(x: breastCancer)

return result
}

func cancelClassifyBreastCancer() {
//cancel function
}

}
