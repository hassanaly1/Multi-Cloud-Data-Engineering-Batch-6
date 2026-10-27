from bisect import bisect_left
from math import sumprod
from operator import itemgetter

# Question 41
students = [
    {"id": 1, "name": "Ali", "marks": (85, 90, 88)},
    {"id": 2, "name": "Sara", "marks": (92, 95, 91)},
    {"id": 3, "name": "Ahmed", "marks": (78, 84, 80)}
]
s1, s2, s3 = students
names = (s1["name"], s2["name"], s3["name"])
averages = dict(zip(names, (
    sum(s1["marks"]) / len(s1["marks"]),
    sum(s2["marks"]) / len(s2["marks"]),
    sum(s3["marks"]) / len(s3["marks"])
)))
top_student = max(averages, key=averages.get)
unique_marks = set(s1["marks"] + s2["marks"] + s3["marks"])
print("Averages:", averages)
print("Top student:", top_student)
print("Names:", names)
print("Unique marks:", unique_marks)

# Question 42
employees = {
    "Ali": {"Python", "SQL", "AWS"},
    "Sara": {"Python", "Databricks", "SQL"},
    "Ahmed": {"AWS", "Snowflake", "SQL"}
}
ali, sara, ahmed = employees.values()
common_skills = ali & sara & ahmed
ali_only_skills = ali - sara - ahmed
team_skills = ali | sara | ahmed
required = {"Python", "SQL"}
meets_requirements = dict(zip(employees, (required <= ali, required <= sara, required <= ahmed)))
qualified = sorted(meets_requirements, key=meets_requirements.get, reverse=True)[:sum(meets_requirements.values())]
print("Common skills:", common_skills)
print("Ali only skills:", ali_only_skills)
print("All team skills:", team_skills)
print("Python and SQL employees:", qualified)

# Question 43
sales = [
    ("Laptop", 120000, 2),
    ("Mouse", 1500, 5),
    ("Keyboard", 3500, 3)
]
first, second, third = sales
revenues = (first[1] * first[2], second[1] * second[2], third[1] * third[2])
product_names, prices, quantities = zip(*sales)
revenue_by_product = dict(zip(product_names, revenues))
top_product = max(revenue_by_product, key=revenue_by_product.get)
print("Revenues:", revenues)
print("Total revenue:", sum(revenues))
print("Top revenue product:", top_product)
print("Revenue by product:", revenue_by_product)
print("Unique prices:", set(prices))

# Question 44
customers = {
    "C101": {"name": "Ali", "orders": [1200, 2500, 1800]},
    "C102": {"name": "Sara", "orders": [3000, 4500]},
    "C103": {"name": "Ahmed", "orders": [1500, 2000, 1000]}
}
c1, c2, c3 = customers.values()
spending = dict(zip(customers, (sum(c1["orders"]), sum(c2["orders"]), sum(c3["orders"]))))
top_customer_id = max(spending, key=spending.get)
totals_in_id_order = itemgetter(*sorted(spending))(spending)
print("Spending per customer:", spending)
print("Top customer:", customers[top_customer_id]["name"])
print("Totals in ID order:", totals_in_id_order)

# Question 45
courses = {
    "Python": {"Ali", "Sara", "Ahmed"},
    "SQL": {"Sara", "Ahmed", "Zain"},
    "AWS": {"Ali", "Ahmed", "Zain"}
}
python_set, sql_set, aws_set = courses.values()
all_three = python_set & sql_set & aws_set
at_least_two = (python_set & sql_set) | (python_set & aws_set) | (sql_set & aws_set)
exactly_two = at_least_two - all_three
exactly_one = (python_set | sql_set | aws_set) - at_least_two
print("Exactly two courses:", exactly_two)
print("All three courses:", all_three)
print("Exactly one course:", exactly_one)
print("Unique students:", len(python_set | sql_set | aws_set))

# Question 46
transactions = [
    {"id": 101, "customer": "Ali", "items": [("Laptop", 120000, 1), ("Mouse", 1500, 2)]},
    {"id": 102, "customer": "Sara", "items": [("Keyboard", 3500, 2), ("Mouse", 1500, 1)]},
    {"id": 103, "customer": "Ali", "items": [("Monitor", 45000, 1)]}
]
t1, t2, t3 = transactions
names1, prices1, quantities1 = zip(*t1["items"])
names2, prices2, quantities2 = zip(*t2["items"])
names3, prices3, quantities3 = zip(*t3["items"])
totals = (
    sumprod(prices1, quantities1),
    sumprod(prices2, quantities2),
    sumprod(prices3, quantities3)
)
ali_flags = (t1["customer"] == "Ali", t2["customer"] == "Ali", t3["customer"] == "Ali")
transaction_totals = dict(zip((t1["id"], t2["id"], t3["id"]), totals))
largest_transaction = max(transaction_totals, key=transaction_totals.get)
print("Total revenue:", sum(totals))
print("Ali spending:", sumprod(totals, ali_flags))
print("Largest transaction:", largest_transaction, "with", transaction_totals[largest_transaction])
print("Unique products:", set(names1 + names2 + names3))

# Question 47
pipelines = {
    "pipeline_1": {"status": "success", "records": (1000, 1200, 1100)},
    "pipeline_2": {"status": "failed", "records": (800, 0, 0)},
    "pipeline_3": {"status": "success", "records": (1500, 1600, 1700)}
}
p1, p2, p3 = pipelines.values()
pipeline_totals = dict(zip(pipelines, (sum(p1["records"]), sum(p2["records"]), sum(p3["records"]))))
failed_flags = dict(zip(pipelines, (
    p1["status"] == "failed",
    p2["status"] == "failed",
    p3["status"] == "failed"
)))
failed_pipelines = sorted(failed_flags, key=failed_flags.get, reverse=True)[:sum(failed_flags.values())]
largest_pipeline = max(pipeline_totals, key=pipeline_totals.get)
average_per_run = dict(zip(pipelines, (
    sum(p1["records"]) / len(p1["records"]),
    sum(p2["records"]) / len(p2["records"]),
    sum(p3["records"]) / len(p3["records"])
)))
print("Total processed records:", sum(pipeline_totals.values()))
print("Failed pipelines:", failed_pipelines)
print("Largest pipeline:", largest_pipeline, "with", pipeline_totals[largest_pipeline])
print("Average records per run:", average_per_run)

# Question 48
accounts = {
    "A101": {"holder": "Ali", "transactions": [5000, -2000, 3000, -1000]},
    "A102": {"holder": "Sara", "transactions": [10000, -3000, -2000]},
    "A103": {"holder": "Ahmed", "transactions": [7000, -1500, 2500]}
}
a1, a2, a3 = accounts.values()
balances = dict(zip((a1["holder"], a2["holder"], a3["holder"]), (
    sum(a1["transactions"]),
    sum(a2["transactions"]),
    sum(a3["transactions"])
)))
highest_holder = max(balances, key=balances.get)
all_transactions = a1["transactions"] + a2["transactions"] + a3["transactions"]
sorted_transactions = sorted(all_transactions)
split_point = bisect_left(sorted_transactions, 0)
total_withdrawals = -sum(sorted_transactions[:split_point])
largest_deposit = sorted_transactions[-1]
print("Final balances:", balances)
print("Highest balance:", highest_holder, "with", balances[highest_holder])
print("Total withdrawals:", total_withdrawals)
print("Largest single deposit:", largest_deposit)

# Question 49
users = {
    "Ali": {"purchased": {"Laptop", "Mouse"}, "wishlist": {"Keyboard", "Monitor", "Mouse"}},
    "Sara": {"purchased": {"Keyboard", "Monitor"}, "wishlist": {"Laptop", "Mouse"}},
    "Ahmed": {"purchased": {"Laptop", "Keyboard"}, "wishlist": {"Monitor", "Headphones"}}
}
ali, sara, ahmed = users.values()
bought_by_two = (
    (ali["purchased"] & sara["purchased"]) |
    (ali["purchased"] & ahmed["purchased"]) |
    (sara["purchased"] & ahmed["purchased"])
)
ali_wishlist_left = ali["wishlist"] - ali["purchased"]
shared_wishlist = (
    (ali["wishlist"] & sara["wishlist"]) |
    (ali["wishlist"] & ahmed["wishlist"]) |
    (sara["wishlist"] & ahmed["wishlist"])
)
all_products = (
    ali["purchased"] | ali["wishlist"] |
    sara["purchased"] | sara["wishlist"] |
    ahmed["purchased"] | ahmed["wishlist"]
)
print("Bought by at least two users:", bought_by_two)
print("Ali wishlist minus purchases:", ali_wishlist_left)
print("Shared wishlist products:", shared_wishlist)
print("All products:", all_products)

# Question 50
company = {
    "departments": {
        "Engineering": {
            "employees": [
                ("Ali", 120000, {"Python", "AWS", "SQL"}),
                ("Sara", 150000, {"Python", "Databricks", "SQL"})
            ],
            "budget": 500000
        },
        "Analytics": {
            "employees": [
                ("Ahmed", 100000, {"SQL", "Power BI"}),
                ("Zain", 130000, {"Python", "SQL", "Tableau"})
            ],
            "budget": 400000
        }
    }
}
departments = company["departments"]
engineering, analytics = departments.values()
eng_names, eng_salaries, eng_skills = zip(*engineering["employees"])
ana_names, ana_salaries, ana_skills = zip(*analytics["employees"])

payroll = dict(zip(departments, (sum(eng_salaries), sum(ana_salaries))))
print("1. Payroll per department:", payroll)

company_payroll = sum(payroll.values())
print("2. Company payroll:", company_payroll)

name_to_salary = dict(zip(eng_names + ana_names, eng_salaries + ana_salaries))
highest_paid = max(name_to_salary, key=name_to_salary.get)
print("3. Highest paid employee:", highest_paid, "with", name_to_salary[highest_paid])

all_skill_sets = eng_skills + ana_skills
print("4. Skills shared by all:", set.intersection(*all_skill_sets))

print("5. Engineering only skills:", set.union(*eng_skills) - set.union(*ana_skills))

budgets = dict(zip(departments, (engineering["budget"], analytics["budget"])))
remaining_budget = dict(zip(departments, (
    budgets["Engineering"] - payroll["Engineering"],
    budgets["Analytics"] - payroll["Analytics"]
)))
print("6. Remaining budget per department:", remaining_budget)

average_salary = dict(zip(departments, (
    sum(eng_salaries) / len(eng_salaries),
    sum(ana_salaries) / len(ana_salaries)
)))
print("7. Higher average salary department:", max(average_salary, key=average_salary.get), average_salary)

print("8. Name to salary:", name_to_salary)

print("9. All unique skills:", set.union(*all_skill_sets))

print("10. Combined budget sufficient:", sum(budgets.values()) >= company_payroll)
