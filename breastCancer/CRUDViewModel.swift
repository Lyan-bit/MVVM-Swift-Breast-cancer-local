//
//  ClassificationViewModel.swift
//  Diet Pro
//
//  Created by Lyan Alwakeel on 26/09/2022.
//

import Foundation
import Darwin
import Combine
import SwiftUI
import CoreLocation


func instanceFromJSON(typeName: String, json: String) -> AnyObject?
{ let jdata = json.data(using: .utf8)!
  let decoder = JSONDecoder()
  if typeName == "String"
  { let x = try? decoder.decode(String.self, from: jdata)
      return x as AnyObject
  }
  if typeName == "Classification"
    { let x = try? decoder.decode(Classification.self, from: jdata)
    return x
  }
  return nil
}




class CRUDViewModel : ObservableObject {
    static var instance : CRUDViewModel? = nil
    var fileSystem : FileAccessor = FileAccessor()
    var cdbi : FirebaseDbi = FirebaseDbi.getInstance()

  static func getInstance() -> CRUDViewModel
  { if instance == nil
    { instance = CRUDViewModel()
    }
    return instance!
  }

  @Published var currentClassification : ClassificationVO = ClassificationVO.defaultClassificationVO()

  @Published var currentClassifications : [ClassificationVO] = [ClassificationVO]()

  init() {
  //init
  }
    
    func listClassification() -> [ClassificationVO]
    {
      currentClassifications = [ClassificationVO]()
      let list : [Classification] = classificationAllInstances
      for (_,x) in list.enumerated()
      { currentClassifications.append(ClassificationVO(x: x)) }
      return currentClassifications
    }

  func stringListClassification() -> [String]
  { var res : [String] = [String]()
    for (_,obj) in currentClassifications.enumerated()
    { res.append(obj.toString()) }
    return res
  }

  func getClassificationByPK(val: String) -> Classification?
  { return Classification.classificationIndex[val] }

  func retrieveClassification(val: String) -> Classification?
  { return Classification.classificationIndex[val] }

  func allClassificationids() -> [String]
  { var res : [String] = [String]()
    for (_,item) in currentClassifications.enumerated()
    { res.append(item.id + "") }
    return res
  }

  func setSelectedClassification(x : ClassificationVO)
  { currentClassification = x }

  func setSelectedClassification(i : Int)
  { if i < currentClassifications.count
    { currentClassification = currentClassifications[i] }
  }

  func getSelectedClassification() -> ClassificationVO
  { return currentClassification }

  func persistClassification(x : Classification)
  { let vo : ClassificationVO = ClassificationVO(x: x)
    cdbi.persistClassification(ex: x)
    currentClassification = vo
  }

  func canceleditClassification() {
  //cancel
  }
  
  func editClassification(x : ClassificationVO)
  { if let obj = getClassificationByPK(val: x.id) {
      obj.age = x.getage()
      obj.bmi = x.getbmi()
      obj.glucose = x.getglucose()
      obj.insulin = x.getinsulin()
      obj.homa = x.gethoma()
      obj.leptin = x.getleptin()
      obj.adiponectin = x.getadiponectin()
      obj.resistin = x.getresistin()
      obj.result = x.getresult()

      cdbi.persistClassification(ex: obj)
    }
    currentClassification = x
  }

  func cancelcreateClassification() { 
  //cancel
  }
    
    func createClassification(x : ClassificationVO)
    { if let obj = getClassificationByPK(val: x.id)
        { cdbi.persistClassification(ex: obj) }
      else
     {
      let res : Classification = createByPKClassification(key: x.id)
          res.age = x.age
          res.bmi = x.bmi
          res.glucose = x.glucose
          res.insulin = x.insulin
          res.homa = x.homa
          res.leptin = x.leptin
          res.adiponectin = x.adiponectin
          res.resistin = x.resistin
          res.result = x.result
      cdbi.persistClassification(ex: res)
     }
     currentClassification = x
    }

  func deleteClassification(id : String)
  { if let obj = getClassificationByPK(val: id)
    { cdbi.deleteClassification(ex: obj) }
  }
    
}
