# Library Management System using SQL Project --P2

## Project Overview

**Project Title**: Library Management System  
**Level**: Intermediate  
**Database**: `library_db`

This project demonstrates the implementation of a Library Management System using SQL. It includes creating and managing tables, performing CRUD operations, and executing advanced SQL queries. The goal is to showcase skills in database design, manipulation, and querying.


## Objectives

1. **Set up the Library Management System Database**: Create and populate the database with tables for branches, employees, members, books, issued status, and return status.
2. **CRUD Operations**: Perform Create, Read, Update, and Delete operations on the data.
3. **CTAS (Create Table As Select)**: Utilize CTAS to create new tables based on query results.
4. **Advanced SQL Queries**: Develop complex queries to analyze and retrieve specific data.

## Project Structure

### 2. CRUD Operations

- **Create**: Inserted sample records into the `books` table.
- **Read**: Retrieved and displayed data from various tables.
- **Update**: Updated records in the `employees` table.
- **Delete**: Removed records from the `members` table as needed.

**Task 1. Create a New Book Record**
-- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

```sql
insert books values('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
SELECT * FROM books;
```
**Task 2: Update an Existing Member's Address**

```sql
update members set member_address = '125 oak St' where member_id = 'c101';
```

**Task 3: Delete a Record from the Issued Status Table**
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

```sql
delete from issued_status where issued_id ='IS121';
```

**Task 4: Retrieve All Books Issued by a Specific Employee**
-- Objective: Select all books issued by the employee with emp_id = 'E101'.
```sql
select * from issued_status where issued_emp_id = 'E101';
```


**Task 5: List Members Who Have Issued More Than One Book**
-- Objective: Use GROUP BY to find members who have issued more than one book.

```sql
select i.issued_emp_id,
	  e.emp_name,
      count(i.issued_id) as Count_of_issuedBook  
      from 
      issued_status as i  
      join 
      employees as e on e.emp_id = i.issued_emp_id
      group by 1,2 having count(*) >1;
```

### 3. CTAS (Create Table As Select)

- **Task 6: Create Summary Tables**: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**

```sql
select 
b.isbn,
b.book_title,
count(*) as count_of_books 
from 
books as b 
join 
issued_status i 
on i.issued_book_isbn=b.isbn 
group by 1,2 
order by count_of_books desc;
```


### 4. Data Analysis & Findings

The following SQL queries were used to address specific questions:

Task 7. **Retrieve All Books in a Specific Category**:

```sql
-- Task 7. Retrieve All Books in a Specific Category: 'classic'
select 
b.isbn,
b.book_title,
count(*) as count_of_books 
from 
books as b 
join 
issued_status i 
on i.issued_book_isbn=b.isbn 
group by 1,2 
order by count_of_books desc;
```

8. **Task 8: Find Total Rental Income by Category**:

```sql
select b.category,sum(b.rental_price) as Price from books as b join issued_status as i on i.issued_book_isbn=b.isbn group by 1;
```

9. **List Members Who Registered in the Last 180 Days**:
```sql
select * from members where reg_date >= current_date - interval 180 day ;
```

10. **List Employees with Their Branch Manager's Name and their branch details**:

```sql
select e.*,e2.emp_name as manager_name from employees as e join branch as b on b.branch_id = e.branch_id
join employees as e2 on e2.emp_id = manager_id;
```

Task 11. **Create a Table of Books with Rental Price Above a Certain Threshold**:
```sql
create table Book_rental_price as 
select * from books where rental_price >7;
select * from book_rental_price;
```

Task 12: **Retrieve the List of Books Not Yet Returned**
```sql
select distinct i.issued_book_name,datediff(current_date,i.issued_date) as delay_days,r.return_id from issued_status as i left join
return_status as r on r.issued_id = i.issued_id where r.return_id is null;
```

## Reports

- **Database Schema**: Detailed table structures and relationships.
- **Data Analysis**: Insights into book categories, employee salaries, member registration trends, and issued books.
- **Summary Reports**: Aggregated data on high-demand books and employee performance.

## Conclusion

This project demonstrates the application of SQL skills in creating and managing a library management system. It includes database setup, data manipulation, and advanced querying, providing a solid foundation for data management and analysis.
