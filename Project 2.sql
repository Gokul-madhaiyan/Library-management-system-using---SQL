create database Project2;
use project2;
select * from Books;
select * from branch;
select * from employees;
select * from issued_status;
select * from members;
select * from returen_status;


-- Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"
insert books values('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');

-- Task 2: Update an Existing Member's Address
update members set member_address = '125 oak St' where member_id = 'c101';



-- Task 3: Delete a Record from the Issued Status Table 
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.
delete from issued_status where issued_id ='IS121';

-- Task 4: Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the employee with emp_id = 'E101'.
select * from issued_status where issued_emp_id = 'E101';



-- Task 5: List Members Who Have Issued More Than One Book -- Objective: Use GROUP BY to find members who have issued more than one book.

select i.issued_emp_id,
	  e.emp_name,
      count(i.issued_id) as Count_of_issuedBook  
      from 
      issued_status as i  
      join 
      employees as e on e.emp_id = i.issued_emp_id
      group by 1,2 having count(*) >1;



-- CTAS
-- Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt
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


-- Task 7. Retrieve All Books in a Specific Category: 'classic'
select * from books where category ='classic';

  
-- Task 8: Find Total Rental Income by Category:

select b.category,sum(b.rental_price) as Price from books as b join issued_status as i on i.issued_book_isbn=b.isbn group by 1;

-- task 9 List Members Who Registered in the Last 180 Days:
select * from members where reg_date >= current_date - interval 180 day ;

-- task 10 List Employees with Their Branch Manager's Name and their branch details:
select e.*,e2.emp_name as manager_name from employees as e join branch as b on b.branch_id = e.branch_id
join employees as e2 on e2.emp_id = manager_id;

-- Task 11. Create a Table of Books with Rental Price Above a Certain Threshold 7USD:
create table Book_rental_price as 
select * from books where rental_price >7;
select * from book_rental_price;

-- Task 12: Retrieve the List of Books Not Yet Returned
select distinct i.issued_book_name,datediff(current_date,i.issued_date) as delay_days,r.return_id from issued_status as i left join return_status as r on r.issued_id = i.issued_id where r.return_id is null;

select * from issued_status;
select * from return_status;



