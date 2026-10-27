# Question 21
numbers = [10, 20, 10, 30, 40, 20, 50]
unique_numbers = set(numbers)
print("Unique set:", unique_numbers)
print("Unique count:", len(unique_numbers))

# Question 22
a = {1, 2, 3, 4, 5}
b = {4, 5, 6, 7, 8}
print("Union:", a | b)
print("Intersection:", a & b)
print("a - b:", a - b)
print("Symmetric difference:", a ^ b)

# Question 23
skills = {"Python", "SQL", "AWS"}
skills.add("Snowflake")
skills.add("Databricks")
skills.discard("AWS")
print("Skills:", skills)

# Question 24
python_students = {"Ali", "Sara", "Ahmed", "Zain"}
sql_students = {"Sara", "Ahmed", "Hamza", "Usman"}
both_courses = python_students & sql_students
exactly_one_course = python_students ^ sql_students
print("Both courses:", both_courses)
print("Exactly one course:", exactly_one_course)

# Question 25
required_skills = {"Python", "SQL"}
candidate_skills = {"Python", "SQL", "AWS", "Snowflake"}
print("Required is subset of candidate:", required_skills.issubset(candidate_skills))
print("Candidate is superset of required:", candidate_skills.issuperset(required_skills))

# Question 26
numbers = {1, 2, 4, 6, 8, 10}
full_range = set(range(1, 11))
missing_numbers = full_range - numbers
print("Missing numbers:", missing_numbers)

# Question 27
python = {"Ali", "Sara", "Ahmed", "Zain"}
sql = {"Sara", "Ahmed", "Hamza"}
aws = {"Ahmed", "Zain", "Hamza"}
all_three = python & sql & aws
python_and_sql_not_aws = (python & sql) - aws
at_least_two = (python & sql) | (python & aws) | (sql & aws)
print("All three:", all_three)
print("Python and SQL but not AWS:", python_and_sql_not_aws)
print("At least two:", at_least_two)

# Question 28
day1 = {101, 102, 103, 104}
day2 = {103, 104, 105, 106}
day3 = {104, 106, 107, 108}
all_days = day1 & day2 & day3
at_least_two_days = (day1 & day2) | (day1 & day3) | (day2 & day3)
exactly_one_day = (day1 | day2 | day3) - at_least_two_days
print("All days:", all_days)
print("Exactly one day:", exactly_one_day)
print("At least two days:", at_least_two_days)

# Question 29
required_permissions = {"read", "write", "execute"}
user_permissions = {"read", "write", "delete"}
missing_permissions = required_permissions - user_permissions
extra_permissions = user_permissions - required_permissions
fully_authorized = required_permissions.issubset(user_permissions)
print("Missing permissions:", missing_permissions)
print("Extra permissions:", extra_permissions)
print("Fully authorized:", fully_authorized)

# Question 30
website = {"C1", "C2", "C3", "C4", "C5"}
mobile = {"C3", "C4", "C6", "C7"}
store = {"C2", "C4", "C7", "C8"}
all_platforms = website & mobile & store
at_least_two_platforms = (website & mobile) | (website & store) | (mobile & store)
exactly_two_platforms = at_least_two_platforms - all_platforms
exactly_one_platform = (website | mobile | store) - at_least_two_platforms
print("Exactly one platform:", exactly_one_platform)
print("Exactly two platforms:", exactly_two_platforms)
print("All three platforms:", all_platforms)
