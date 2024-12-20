# datamodelling_and_design_course
# Database to represent a bank customer  
This project involved designing a database to represent a bank customer. The database was created to enable customers to access all typical banking services, such as holding multiple credit cards, loans, and accounts. 
The project was completed in two key parts:
## 1. Entity Relationship Diagram (ERD):
A logical ERD was created to represent the database structure, including all tables, columns, data types, relationships, and cardinalities. The diagram was created using a tool like Draw.io.

## 2. Database Implementation in MS-SQL:
The database was implemented using MS-SQL syntax. All relevant tables and relationships were defined to ensure the database accurately reflected the modeled structure.

### Part 1 – Entity Relationship Diagram
The logical ERD visually represented the database and included:

- All necessary tables with their respective columns.
- The data types for each column.
- The relationships and cardinalities between tables.

### Part 2 – The Database
The database consisted of the following tables:

Customers:
This table stores all customer-specific details, including:
Name
Gender
Address
Date of Birth
National ID Number
Contact Information

Cards:
This table stores details about individual cards, such as:
Card Type (Credit/Debit)
Issue Date
Expiry Month
Expiry Year
CVV2 Code

Accounts:
This table heols information about specific accounts, including:
Balance
Creation Date

Dispositions:
A bridge table connected to Customers, Accounts, and Cards.

Transactions:
This table, linked to Accounts, records each transaction. Key columns included:
Transaction Date
Transaction Type (Deposit/Withdrawal)
Amount
Account Balance

Loans:
This table, linked to Accounts, records loan information. Key columns included:
Loan Date
Loan Amount
Duration (in months)
Payments
Outstanding Debt

The final result was a fully designed and implemented database that accurately reflected the relationships and attributes associated with a bank customer.
