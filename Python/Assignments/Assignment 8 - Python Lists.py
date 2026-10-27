# Question 1
numbers = [10, 20, 30, 40, 50, 60, 70]
first = numbers[0]
middle = numbers[len(numbers) // 2]
last = numbers[-1]
print("First:", first)
print("Middle:", middle)
print("Last:", last)
print("Original:", numbers)

# Question 2
numbers = [5, 10, 15, 20, 25, 30, 35, 40, 45, 50]
first_five = numbers[:5]
last_four = numbers[-4:]
every_second_reverse = numbers[::-2]
print("First five:", first_five)
print("Last four:", last_four)
print("Every second reversed:", every_second_reverse)
 
# Question 3
fruits = ["apple", "banana", "cherry", "mango"]
fruits[fruits.index("banana")] = "orange"
fruits.insert(2, "grapes")
fruits.remove("cherry")
print(fruits)

# Question 4
numbers = [12, 45, 23, 67, 89, 34]
reversed_numbers = numbers[::-1]
print("Reversed:", reversed_numbers)
print("Original:", numbers)

# Question 5
numbers = [45, 12, 89, 34, 89, 67, 45, 23]
unique_sorted = sorted(set(numbers))
second_largest = unique_sorted[-2]
print("Second largest unique:", second_largest)

# Question 6
numbers = [10, 20, 30, 40, 50, 60]
k = 2
rotated = numbers[-k:] + numbers[:-k]
print("Rotated:", rotated)

# Question 7
numbers = [10, 20, 10, 30, 20, 40, 30, 50]
no_duplicates = list(dict.fromkeys(numbers))
print("Without duplicates:", no_duplicates)

# Question 8
data = [[10, 20], [30, 40], [50, 60]]
flat = sum(data, [])
print("Flattened:", flat)

# Question 9
matrix = [
    [10, 20, 30],
    [40, 50, 60],
    [70, 80, 90]
]
main_diagonal = [matrix[0][0], matrix[1][1], matrix[2][2]]
secondary_diagonal = [matrix[0][2], matrix[1][1], matrix[2][0]]
middle_column = [matrix[0][1], matrix[1][1], matrix[2][1]]
print("Main diagonal:", main_diagonal, "Sum:", sum(main_diagonal))
print("Secondary diagonal:", secondary_diagonal, "Sum:", sum(secondary_diagonal))
print("Middle column:", middle_column, "Sum:", sum(middle_column))

# Question 10
data = [15, 5, 25, 10, 35, 20, 30]
unique_sorted = sorted(set(data))
three_largest = unique_sorted[-3:]
two_smallest_desc = unique_sorted[:2][::-1]
result = three_largest + two_smallest_desc
print("Result:", result)
