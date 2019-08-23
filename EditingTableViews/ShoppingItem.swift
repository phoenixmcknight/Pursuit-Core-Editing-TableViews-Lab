struct ShoppingItem {
    let name: String
    let price: Double
}

struct ShoppingItemFetchingClient {
    static func getShoppingItems() -> [ShoppingItem] {
        return [
            ShoppingItem(name: "Apple", price: 2.99),
            ShoppingItem(name: "Baseball Bat", price: 11.59),
            ShoppingItem(name: "Car", price: 20_000.99),
            ShoppingItem(name: "Donut", price: 1.19),
            ShoppingItem(name: "Egg", price: 0.19),
            ShoppingItem(name: "Fan", price: 8.99)
        ]
    }
}
