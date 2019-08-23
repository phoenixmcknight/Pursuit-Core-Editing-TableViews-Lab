import UIKit

class ShoppingViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var shoppingItems:[ShoppingItem] = []
    var boughtItems:[ShoppingItem] = []
    @IBOutlet weak var shoppingTableView: UITableView!
    @IBAction func editButton(_ sender: UIButton) {
        if shoppingTableView.isEditing == true  {
shoppingTableView.setEditing(false, animated: false)
            sender.setTitle("Edit", for: .normal)
        } else {
           shoppingTableView.setEditing(true, animated: true)
            sender.setTitle("Finish Editing", for: .normal)
            
        }
    }
    @IBAction func unwind(segue: UIStoryboardSegue) {
        
        guard let addItemVC = segue.source as? AddItemVC
            else {
                fatalError()
        }
        // check to see if there is an input in the textfield
        guard let textFromName = addItemVC.nameField.text else {
            fatalError()
        }
        // check to see if there is an input in the textfield
        guard let textFromPrice = addItemVC.priceField.text else {
            fatalError()
        }
        // check to see if the text from the priceTextField can be converted to a double
        guard let priceAsDouble = Double(textFromPrice) else {
            fatalError()
        }
        // this line of code creates a ShoppingItem type with the textFromName and priceAsDouble. then it gets appended to the shoppingItem variable and the reloadItem variable
        let newItem = ShoppingItem(name: textFromName, price: priceAsDouble)
        shoppingItems.append(newItem)
        //reloadItem.append(newItem)
        
        // this line imitate the array.count method but for the shoppingItemsTableView. it gets how many rows in in that section
        let lastIndex = shoppingTableView.numberOfRows(inSection: 0)
        
        // this sets the lastIndex as the location for storing the input from the text view
        let lastIndexPath = IndexPath(row: lastIndex, section: 0)
        
        // this line appends a new row in the section for appending the data to the buttom
        shoppingTableView.insertRows(at: [lastIndexPath], with: .automatic)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       configureShoppingItemsTableView()
       loadShoppingItems()
     shoppingTableView.isEditing = false
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return shoppingItems.count
        } else {
        return boughtItems.count
    }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Shopping Cart"
        } else {
            return "Bought Items"
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
           boughtItems.insert(shoppingItems[indexPath.row], at: boughtItems.startIndex)
            print("shopArray\(shoppingItems[indexPath.row])")
            shoppingItems.remove(at: indexPath.row)
            print(shoppingItems.count)

            print("boughtArray\(boughtItems[0])")
            
        } else {
        shoppingItems.insert(boughtItems[indexPath.row], at: shoppingItems.startIndex)
            boughtItems.remove(at: indexPath.row)
        
        }
    tableView.reloadData()
        
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            print("we hit delete")
        shoppingItems.remove(at: indexPath.row)
         shoppingTableView.deleteRows(at: [indexPath], with: .fade)
        //  tableView.reloadData()
        default:
            print("we did something else")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingCart")
        
       cell?.textLabel?.text =  shoppingItems[indexPath.row].name
          cell?.detailTextLabel?.text = "Price: \(shoppingItems[indexPath.row].price)"
                return cell!
        } else {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "shoppingCart2")
            cell2?.textLabel?.text = boughtItems[indexPath.row].name
            cell2?.detailTextLabel?.text = "Price: \(boughtItems[indexPath.row].price)"
            return cell2!
        }
            
            
        
    
    }
    
    private func loadShoppingItems() {
        let allItems = ShoppingItemFetchingClient.getShoppingItems()
         shoppingItems = allItems
    }
    
    private func configureShoppingItemsTableView() {
        shoppingTableView.dataSource = self
        shoppingTableView.delegate = self
    }
   
}

