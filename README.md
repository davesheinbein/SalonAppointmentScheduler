# Salon Appointment Scheduler

This project creates a PostgreSQL database for managing salon appointments, setting up tables with keys and relationships, and initializing services data for customer appointments. 

This project is part of the
[FreeCodeCamp Relational Database Certification](https://www.freecodecamp.org/learn/relational-database).
[Salon appointment scheduler project](https://www.freecodecamp.org/learn/relational-database/build-a-salon-appointment-scheduler-project/build-a-salon-appointment-scheduler).

## Table of Contents
1. [Create Database and Connect](#1-create-database-and-connect): Set up and connect to the database.
2. [Create Tables](#2-create-tables): Define tables for `appointments`, `customers`, and `services`.
3. [Initialize Services Data](#3-initialize-services-data): Add starting data to `services`.
4. [Primary and Foreign Key Constraints](#4-primary-and-foreign-key-constraints): Ensure data integrity with relationships.
5. [(Optional) Update Services and Customers](#5-optional-update-services-and-customers): Modify data for services and customers.
6. [Export Database to SQL File](#6-export-database-to-sql-file): Backup database with pg_dump.
7. [Create and Run Shell Script](#7-create-and-run-shell-script): Automate database setup.
8. [Project Flowchart](#8-project-flowchart): Overview of setup and workflow.
9. [Entity-Relationship Diagram (ERD)](#9-entity-relationship-diagram-erd): Visualize table relationships.

---

### 1. Create Database and Connect
To create and connect to the PostgreSQL database:
```sql
psql --username=freecodecamp --dbname=postgres;

CREATE DATABASE salon;

\c salon
```

### 2. Create Tables
Define tables for `appointments`, `customers`, and `services`:
```sql
CREATE TABLE appointments (
    appointment_id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    service_id INTEGER NOT NULL,
    time VARCHAR(50) NOT NULL
);

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    phone VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE services (
    service_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);
```

### 3. Initialize Services Data
Insert initial values into the `services` table:
```sql
INSERT INTO services VALUES
(1, 'cut'), (2, 'color'), (3, 'perm'), 
(4, 'style'), (5, 'trim');
```

### 4. Primary and Foreign Key Constraints
Assign primary and foreign key constraints for data integrity:
```sql
ALTER TABLE appointments ADD FOREIGN KEY (customer_id) REFERENCES customers (customer_id);
ALTER TABLE appointments ADD FOREIGN KEY (service_id) REFERENCES services (service_id);
```

### 5. (Optional) Update Services and Customers
You can update records in `services` and `customers` with the `UPDATE` command.

#### Update Services
To rename a service:
```sql
UPDATE services
SET name = 'new_service_name'
WHERE service_id = service_id_value;
```
Example:
```sql
UPDATE services
SET name = 'haircut'
WHERE service_id = 1;
```

#### Update Customers
To update customer details:
```sql
UPDATE customers
SET name = 'new_name', phone = 'new_phone_number'
WHERE customer_id = customer_id_value;
```
Example:
```sql
UPDATE customers
SET name = 'Jane Doe', phone = '123-456-7890'
WHERE customer_id = 1;
```

### 6. Export Database to SQL File
Export database schema and data:
```bash
pg_dump -cC --inserts -U freecodecamp salon > salon.sql
```

### 7. Create and Run Shell Script
Automate database management:
1. Create a shell script:
   ```bash
   touch salon.sh
   chmod +x salon.sh
   ```
2. Run the script:
   ```bash
   ./salon.sh
   ```

### 8. Project Flowchart
The flowchart shows the main steps for setting up the database.

```plaintext
+---------------------------+
|       Start Process       |
+---------------------------+
             |
             v
+---------------------------+
| Connect to PostgreSQL     |
| Command: psql --username=freecodecamp --dbname=postgres |
+---------------------------+
             |
             v
+---------------------------+
| Create 'salon' Database   |
| Command: CREATE DATABASE salon; |
+---------------------------+
             |
             v
+---------------------------+
| Connect to 'salon' Database |
| Command: \c salon           |
+---------------------------+
             |
             v
+---------------------------+
| Define Tables for         |
| appointments, customers,  |
| and services              |
+---------------------------+
             |
             v
+---------------------------+
| Insert Initial Data       |
| into Services Table       |
| Command: INSERT INTO services VALUES ... |
+---------------------------+
             |
             v
+---------------------------+
| Set Primary & Foreign     |
| Key Constraints           |
| Command: ALTER TABLE appointments ... |
+---------------------------+
             |
             v
+---------------------------+
| (Optional) Update Services|
| and Customer Records      |
| Command: UPDATE services ... or customers ... |
+---------------------------+
             |
             v
+---------------------------+
| Export Database to SQL    |
| Command: pg_dump -cC ...  |
+---------------------------+
             |
             v
+---------------------------+
| Create and Run Shell Script |
| Command: touch salon.sh; chmod +x salon.sh; ./salon.sh |
+---------------------------+
             |
             v
+---------------------------+
|        End Process        |
+---------------------------+
```

---

### 9. Entity-Relationship Diagram (ERD)

The ERD displays relationships between the `appointments`, `customers`, and `services` tables.

1. **Appointments Table**
   - **appointment_id** (Primary Key): Identifier for each appointment.
   - **customer_id** (Foreign Key): References `customer_id` in `customers`, linking an appointment to a customer.
   - **service_id** (Foreign Key): References `service_id` in `services`, linking an appointment to a service.
   - **time**: Time of the appointment.

2. **Customers Table**
   - **customer_id** (Primary Key): Unique identifier for each customer.
   - **name**: Customer’s name.
   - **phone**: Customer’s phone number (unique and not null).

3. **Services Table**
   - **service_id** (Primary Key): Identifier for each service.
   - **name**: Name of the service (e.g., cut, color).

ERD:
```plaintext
+--------------+      +--------------+       +--------------+
| CUSTOMERS    |      | APPOINTMENTS |       | SERVICES     |
+--------------+      +--------------+       +--------------+
| customer_id  |<-----| customer_id  |       | service_id   |
| name         |      | appointment_id       | name         |
| phone        |      | service_id   |------>|              |
+--------------+      | time         |       +--------------+
                      +--------------+
```
