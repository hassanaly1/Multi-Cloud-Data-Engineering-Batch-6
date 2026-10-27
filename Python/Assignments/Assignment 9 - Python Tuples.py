from math import prod, sumprod
from operator import itemgetter

# Question 11
colors = ("red", "green", "blue", "yellow", "purple")
second = colors[1]
last = colors[-1]
middle = len(colors) // 2
middle_three = colors[middle - 1:middle + 2]
print("Second:", second)
print("Last:", last)
print("Middle three:", middle_three)

# Question 12
employee = ("Ali", 28, "Data Engineer", 150000)
name, age, job, salary = employee
print("Name:", name)
print("Salary:", salary)

# Question 13
tuple1 = (10, 20, 30)
tuple2 = (40, 50, 60)
combined = tuple1 + tuple2
reversed_tuple = combined[::-1]
print("Combined:", combined)
print("Reversed:", reversed_tuple)

# Question 14
numbers = (10, 20, 30, 20, 40, 20, 50)
print("Count of 20:", numbers.count(20))
print("First index of 20:", numbers.index(20))

# Question 15
data = (100, 200, 300, 400, 500, 600)
first, second, *remaining, last = data
print("First:", first)
print("Second:", second)
print("Last:", last)
print("Remaining:", remaining)

# Question 16
numbers = (10, 20, 30, 40, 50)
position = numbers.index(30)
new_numbers = numbers[:position] + (300,) + numbers[position + 1:]
print("New tuple:", new_numbers)
print("Original:", numbers)

# Question 17
students = (
    ("Ali", (85, 90, 88)),
    ("Sara", (92, 87, 95)),
    ("Ahmed", (78, 84, 80))
)
sara_second_score = students[1][1][1]
ali_scores = students[0][1]
ali_average = sum(ali_scores) / len(ali_scores)
ahmed_highest = max(students[2][1])
print("Sara second score:", sara_second_score)
print("Ali average:", ali_average)
print("Ahmed highest score:", ahmed_highest)

# Question 18
employees = (
    ("Ali", 80000),
    ("Sara", 120000),
    ("Ahmed", 95000)
)
sorted_employees = tuple(sorted(employees, key=itemgetter(1), reverse=True))
print("Sorted by salary descending:", sorted_employees)

# Question 19
matrix = ((2, 4, 6), (8, 10, 12), (14, 16, 18))
diagonal = (matrix[0][0], matrix[1][1], matrix[2][2])
diagonal_product = prod(diagonal)
row_sums = (sum(matrix[0]), sum(matrix[1]), sum(matrix[2]))
print("Diagonal:", diagonal)
print("Diagonal product:", diagonal_product)
print("Row sums:", row_sums)

# Question 20
records = (
    ("Laptop", 120000, 5),
    ("Mouse", 1500, 20),
    ("Keyboard", 3500, 10)
)
names, prices, quantities = zip(*records)
inventory_value = sumprod(prices, quantities)
most_expensive = names[prices.index(max(prices))]
reversed_names = names[::-1]
print("Inventory value:", inventory_value)
print("Most expensive product:", most_expensive)
print("Reversed names:", reversed_names)
