//
//  ItemDetailsVC.swift
//  DreamLister
//
//  Created by Kimar Arakaki Neves on 2016-11-24.
//  Copyright © 2016 Kimar. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var storePicker: UIPickerView!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var priceField: CustomTextField!
    @IBOutlet weak var detailsField: CustomTextField!
    @IBOutlet weak var imageThumb: UIImageView!
    
    var stores = [Store]()
    var itemToEdit: Item?
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let topItem = self.navigationController?.navigationBar.topItem{
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        storePicker.dataSource = self
        storePicker.delegate = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        getStores()
        if stores.count == 0 {
            loadStores()
            getStores()
        }
        
        loadItemData()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = stores[row]
        return store.nane
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func loadStores(){
        let store = Store(context: context)
        store.nane = "BestBuy"
        
        let store1 = Store(context: context)
        store1.nane = "LondonDrugs"
        
        let store2 = Store(context: context)
        store2.nane = "Shoppers"
        
        let store3 = Store(context: context)
        store3.nane = "Running Room"
        
        let store4 = Store(context: context)
        store4.nane = "SportCheck"

        let store5 = Store(context: context)
        store5.nane = "Amazon"

        ad.saveContext()
    }
    
    func getStores(){
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        
        do{
            self.stores = try context.fetch(fetchRequest)
            self.storePicker.reloadAllComponents()
        } catch {
            let error =  NSError()
            print("\(error)")
        }
    }
    
    func loadItemData(){
        if let item = itemToEdit {
            titleField.text = item.title
            priceField.text = "\(item.price)"
            detailsField.text = item.details
            imageThumb.image = item.toImage?.image as? UIImage
            
            if let store = item.toStore {
                var index = 0
                repeat{
                    let s = stores[index]
                    if(s.nane == store.nane){
                        storePicker.selectRow(index, inComponent: 0, animated: false)
                    }
                    index += 1
                } while (index < stores.count)
            }
        }
    }
    
    @IBAction func saveItem(_ sender: Any) {
        var item: Item!
            
        if itemToEdit == nil{
            item = Item(context: context)
        } else {
            item = itemToEdit
        }
        
        if let title = titleField.text, title != "" {
            item.title = title
        }
        if let price = priceField.text {
            if let priceValue = (price as? NSString) {
                item.price = priceValue.doubleValue
            }
        }
        if let details = detailsField.text, title != "" {
            item.details = details
        }
        
        item.toStore = stores[storePicker.selectedRow(inComponent: 0)]
        
        let image = Image(context: context)
        image.image = imageThumb.image
        item.toImage = image
        
        ad.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deletePressed(_ sender: UIBarButtonItem) {
        
        if let item = itemToEdit {
            context.delete(item)
            ad.saveContext()
        }
        
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func pressedImageButton(_ sender: UIButton) {
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageThumb.image = image
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
}
