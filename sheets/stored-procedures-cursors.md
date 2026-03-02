# Stored Procedures & Cursors - Practice Sheet

## Exercise 1: Customer Information Procedure

Create a stored procedure that:

- **a)** Takes a `customer_id` as input
- **b)** Returns the customer's full name, total number of orders, and total amount spent
- **c)** Uses variables to store intermediate calculations

---

## Exercise 2: Stock Checker Procedure

Create a procedure that:

- **a)** Takes `store_id` and `product_id` as parameters
- **b)** Checks the stock quantity from the `stocks` table

**Returns:**
| Condition | Message |
|-----------|---------|
| quantity > 5 | "In Stock (X units)" |
| quantity 1-5 | "Low Stock (X units)" |
| quantity = 0 | "Out of Stock" |
| no record | "Product not carried" |

---

## Exercise 3: Price Update Procedure

Create a procedure that:

- **a)** Takes `brand_id` and `percentage_increase` as parameters
- **b)** Uses a `WHILE` loop to update prices of all products for that brand
- **c)** Applies the percentage increase to each product's `list_price`
- **d)** Returns the number of products updated

---

## Exercise 4: Late Orders Cursor

Create a procedure that:

- **a)** Uses a **cursor** to find all orders where `shipped_date` is NULL and `order_date` is more than 7 days old

For each late order:
- **b)** Updates the `order_status` to 'Late'
- **c)** Calculates a 5% discount for the order items
- **d)** Returns the total number of late orders processed

---

## Related Files

- [Cursors Examples](../examples/cursors.sql)
- [Procedures Examples](../examples/procedures.sql)
