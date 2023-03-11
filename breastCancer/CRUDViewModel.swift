	                  
import Foundation
import SwiftUI

/* This code requires OclFile.swift */

func initialiseOclFile()
{ 
 createByPKOclFile(key: "System.in")
 createByPKOclFile(key: "System.out")
 createByPKOclFile(key: "System.err")
}

/* This metatype code requires OclType.swift */

func initialiseOclType()
{ let intOclType = createByPKOclType(key: "int")
  intOclType.actualMetatype = Int.self
  let doubleOclType = createByPKOclType(key: "double")
  doubleOclType.actualMetatype = Double.self
  let longOclType = createByPKOclType(key: "long")
  longOclType.actualMetatype = Int64.self
  let stringOclType = createByPKOclType(key: "String")
  stringOclType.actualMetatype = String.self
  let sequenceOclType = createByPKOclType(key: "Sequence")
  sequenceOclType.actualMetatype = type(of: [])
  let anyset : Set<AnyHashable> = Set<AnyHashable>()
  let setOclType = createByPKOclType(key: "Set")
  setOclType.actualMetatype = type(of: anyset)
  let mapOclType = createByPKOclType(key: "Map")
  mapOclType.actualMetatype = type(of: [:])
  let voidOclType = createByPKOclType(key: "void")
  voidOclType.actualMetatype = Void.self
	
  let breastCancerOclType = createByPKOclType(key: "BreastCancer")
  breastCancerOclType.actualMetatype = BreastCancer.self

  let breastCancerId = createOclAttribute()
  	  breastCancerId.name = "id"
  	  breastCancerId.type = stringOclType
  	  breastCancerOclType.attributes.append(breastCancerId)
  let breastCancerAge = createOclAttribute()
  	  breastCancerAge.name = "age"
  	  breastCancerAge.type = intOclType
  	  breastCancerOclType.attributes.append(breastCancerAge)
  let breastCancerBmi = createOclAttribute()
  	  breastCancerBmi.name = "bmi"
  	  breastCancerBmi.type = doubleOclType
  	  breastCancerOclType.attributes.append(breastCancerBmi)
  let breastCancerGlucose = createOclAttribute()
  	  breastCancerGlucose.name = "glucose"
  	  breastCancerGlucose.type = doubleOclType
  	  breastCancerOclType.attributes.append(breastCancerGlucose)
  let breastCancerInsulin = createOclAttribute()
  	  breastCancerInsulin.name = "insulin"
  	  breastCancerInsulin.type = doubleOclType
  	  breastCancerOclType.attributes.append(breastCancerInsulin)
  let breastCancerHoma = createOclAttribute()
  	  breastCancerHoma.name = "homa"
  	  breastCancerHoma.type = doubleOclType
  	  breastCancerOclType.attributes.append(breastCancerHoma)
  let breastCancerLeptin = createOclAttribute()
  	  breastCancerLeptin.name = "leptin"
  	  breastCancerLeptin.type = doubleOclType
  	  breastCancerOclType.attributes.append(breastCancerLeptin)
  let breastCancerAdiponectin = createOclAttribute()
  	  breastCancerAdiponectin.name = "adiponectin"
  	  breastCancerAdiponectin.type = doubleOclType
  	  breastCancerOclType.attributes.append(breastCancerAdiponectin)
  let breastCancerResistin = createOclAttribute()
  	  breastCancerResistin.name = "resistin"
  	  breastCancerResistin.type = doubleOclType
  	  breastCancerOclType.attributes.append(breastCancerResistin)
  let breastCancerMcp = createOclAttribute()
  	  breastCancerMcp.name = "mcp"
  	  breastCancerMcp.type = doubleOclType
  	  breastCancerOclType.attributes.append(breastCancerMcp)
  let breastCancerOutcome = createOclAttribute()
  	  breastCancerOutcome.name = "outcome"
  	  breastCancerOutcome.type = stringOclType
  	  breastCancerOclType.attributes.append(breastCancerOutcome)
}

func instanceFromJSON(typeName: String, json: String) -> AnyObject?
	{ let jdata = json.data(using: .utf8)!
	  let decoder = JSONDecoder()
	  if typeName == "String"
	  { let x = try? decoder.decode(String.self, from: jdata)
	      return x as AnyObject
	  }
  return nil
	}

class CRUDViewModel : ObservableObject {
		                      
	static var instance : CRUDViewModel? = nil
	var db : DB?
		
	// path of document directory for SQLite database (absolute path of db)
	let dbpath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
	var fileSystem : FileAccessor = FileAccessor()

	static func getInstance() -> CRUDViewModel {
		if instance == nil
	     { instance = CRUDViewModel()
	       initialiseOclFile()
	       initialiseOclType() }
	    return instance! }
	                          
	init() { 
		// init
		db = DB.obtainDatabase(path: "\(dbpath)/myDatabase.sqlite3")
		loadBreastCancer()
	}
	      
	@Published var currentBreastCancer : BreastCancerVO? = BreastCancerVO.defaultBreastCancerVO()
	@Published var currentBreastCancers : [BreastCancerVO] = [BreastCancerVO]()

	func createBreastCancer(x : BreastCancerVO) {
		let res : BreastCancer = createByPKBreastCancer(key: x.id)
			res.id = x.id
		res.age = x.age
		res.bmi = x.bmi
		res.glucose = x.glucose
		res.insulin = x.insulin
		res.homa = x.homa
		res.leptin = x.leptin
		res.adiponectin = x.adiponectin
		res.resistin = x.resistin
		res.mcp = x.mcp
		res.outcome = x.outcome
	    currentBreastCancer = x

	    do { try db?.createBreastCancer(breastCancervo: x) }
	    catch { print("Error creating BreastCancer") }
	}
	
	func cancelCreateBreastCancer() {
		//cancel function
	}

	func loadBreastCancer() {
		let res : [BreastCancerVO] = listBreastCancer()
		
		for (_,x) in res.enumerated() {
			let obj = createByPKBreastCancer(key: x.id)
	        obj.id = x.getId()
        obj.age = x.getAge()
        obj.bmi = x.getBmi()
        obj.glucose = x.getGlucose()
        obj.insulin = x.getInsulin()
        obj.homa = x.getHoma()
        obj.leptin = x.getLeptin()
        obj.adiponectin = x.getAdiponectin()
        obj.resistin = x.getResistin()
        obj.mcp = x.getMcp()
        obj.outcome = x.getOutcome()
			}
		 currentBreastCancer = res.first
		 currentBreastCancers = res
		}
		
  		func listBreastCancer() -> [BreastCancerVO] {
			if db != nil
			{ currentBreastCancers = (db?.listBreastCancer())!
			  return currentBreastCancers
			}
			currentBreastCancers = [BreastCancerVO]()
			let list : [BreastCancer] = BreastCancerAllInstances
			for (_,x) in list.enumerated()
			{ currentBreastCancers.append(BreastCancerVO(x: x)) }
			return currentBreastCancers
		}
				
		func stringListBreastCancer() -> [String] { 
			currentBreastCancers = listBreastCancer()
			var res : [String] = [String]()
			for (_,obj) in currentBreastCancers.enumerated()
			{ res.append(obj.toString()) }
			return res
		}
				
		func getBreastCancerByPK(val: String) -> BreastCancer? {
			var res : BreastCancer? = BreastCancer.getByPKBreastCancer(index: val)
			if res == nil && db != nil
			{ let list = db!.searchByBreastCancerid(val: val)
			if list.count > 0
			{ res = createByPKBreastCancer(key: val)
			}
		  }
		  return res
		}
				
		func retrieveBreastCancer(val: String) -> BreastCancer? {
			let res : BreastCancer? = getBreastCancerByPK(val: val)
			return res 
		}
				
		func allBreastCancerids() -> [String] {
			var res : [String] = [String]()
			for (_,item) in currentBreastCancers.enumerated()
			{ res.append(item.id + "") }
			return res
		}
				
		func setSelectedBreastCancer(x : BreastCancerVO)
			{ currentBreastCancer = x }
				
		func setSelectedBreastCancer(i : Int) {
			if 0 <= i && i < currentBreastCancers.count
			{ currentBreastCancer = currentBreastCancers[i] }
		}
				
		func getSelectedBreastCancer() -> BreastCancerVO?
			{ return currentBreastCancer }
				
		func persistBreastCancer(x : BreastCancer) {
			let vo : BreastCancerVO = BreastCancerVO(x: x)
			editBreastCancer(x: vo)
		}
			
		func editBreastCancer(x : BreastCancerVO) {
			let val : String = x.id
			let res : BreastCancer? = BreastCancer.getByPKBreastCancer(index: val)
			if res != nil {
			res!.id = x.id
		res!.age = x.age
		res!.bmi = x.bmi
		res!.glucose = x.glucose
		res!.insulin = x.insulin
		res!.homa = x.homa
		res!.leptin = x.leptin
		res!.adiponectin = x.adiponectin
		res!.resistin = x.resistin
		res!.mcp = x.mcp
		res!.outcome = x.outcome
		}
		currentBreastCancer = x
			if db != nil
			 { db!.editBreastCancer(breastCancervo: x) }
		 }
			
	    func cancelBreastCancerEdit() {
	    	//cancel function
	    }
    
		  

	}
