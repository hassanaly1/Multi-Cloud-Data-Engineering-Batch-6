# Question 31
student = {"name": "Ali", "age": 22, "course": "Python", "marks": 85}
print("Name:", student["name"])
print("Marks:", student["marks"])
print("City:", student.get("city", "Karachi"))

# Question 32
employee = {"name": "Sara", "salary": 100000, "department": "IT"}
employee["salary"] = round(employee["salary"] * 1.20)
employee["bonus"] = 15000
employee["department"] = "Data Engineering"
print("Updated employee:", employee)

# Question 33
product = {"id": 101, "name": "Laptop", "price": 120000, "stock": 5}
print("Keys:", product.keys())
print("Values:", product.values())
print("Items:", product.items())
removed_stock = product.pop("stock")
print("Removed stock:", removed_stock)
print("Product after removal:", product)

# Question 34
dict1 = {"a": 10, "b": 20, "c": 30}
dict2 = {"b": 50, "d": 40}
merged = dict1 | dict2
print("Merged:", merged)

# Question 35
marks = {"Ali": 85, "Sara": 92, "Ahmed": 78, "Zain": 88}
highest = max(marks.values())
lowest = min(marks.values())
average = sum(marks.values()) / len(marks)
top_student = max(marks, key=marks.get)
print("Highest:", highest)
print("Lowest:", lowest)
print("Average:", average)
print("Top student:", top_student)

# Question 36
employees = {
    "E101": {"name": "Ali", "salary": 80000},
    "E102": {"name": "Sara", "salary": 120000},
    "E103": {"name": "Ahmed", "salary": 95000}
}
print("Sara salary:", employees["E102"]["salary"])
employees["E101"]["salary"] = round(employees["E101"]["salary"] * 1.15)
print("Ali new salary:", employees["E101"]["salary"])
ali, sara, ahmed = employees.values()
total_payroll = ali["salary"] + sara["salary"] + ahmed["salary"]
print("Total payroll:", total_payroll)

# Question 37
data = {"Python": "Ali", "SQL": "Sara", "AWS": "Ahmed"}
inverse = dict(zip(data.values(), data.keys()))
print("Inverse:", inverse)

# Question 38
order = {
    "laptop": {"price": 120000, "quantity": 2},
    "mouse": {"price": 1500, "quantity": 5},
    "keyboard": {"price": 3500, "quantity": 3}
}
laptop, mouse, keyboard = order.values()
laptop_subtotal = laptop["price"] * laptop["quantity"]
mouse_subtotal = mouse["price"] * mouse["quantity"]
keyboard_subtotal = keyboard["price"] * keyboard["quantity"]
grand_total = laptop_subtotal + mouse_subtotal + keyboard_subtotal
after_discount = grand_total * 0.90
print("Laptop subtotal:", laptop_subtotal)
print("Mouse subtotal:", mouse_subtotal)
print("Keyboard subtotal:", keyboard_subtotal)
print("Grand total:", grand_total)
print("After 10% discount:", after_discount)

# Question 39
employees = {
    "Ali": {"python": 90, "sql": 85, "aws": 88},
    "Sara": {"python": 95, "sql": 92, "aws": 90},
    "Ahmed": {"python": 80, "sql": 87, "aws": 84}
}
ali, sara, ahmed = employees.values()
averages = dict(zip(employees, (
    sum(ali.values()) / len(ali),
    sum(sara.values()) / len(sara),
    sum(ahmed.values()) / len(ahmed)
)))
top_performer = max(averages, key=averages.get)
sql_scores = dict(zip(employees, (ali["sql"], sara["sql"], ahmed["sql"])))
best_sql_employee = max(sql_scores, key=sql_scores.get)
print("Averages:", averages)
print("Top performer:", top_performer)
print("Highest SQL score:", sql_scores[best_sql_employee], "by", best_sql_employee)

# Question 40
inventory = {
    "P101": {"name": "Laptop", "price": 120000, "stock": 5},
    "P102": {"name": "Mouse", "price": 1500, "stock": 20},
    "P103": {"name": "Keyboard", "price": 3500, "stock": 10}
}
laptop, mouse, keyboard = inventory.values()
item_values = dict(zip(inventory, (
    laptop["price"] * laptop["stock"],
    mouse["price"] * mouse["stock"],
    keyboard["price"] * keyboard["stock"]
)))
total_value = sum(item_values.values())
most_valuable_id = max(item_values, key=item_values.get)
print("Total inventory value:", total_value)
print("Most valuable item:", inventory[most_valuable_id]["name"])
inventory["P101"]["stock"] -= 2
inventory["P102"]["stock"] -= 5
print("Laptop stock after sale:", inventory["P101"]["stock"])
print("Mouse stock after sale:", inventory["P102"]["stock"])
