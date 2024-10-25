# Salon Appointment Scheduler

This project sets up a database for managing salon appointments. It includes creating a PostgreSQL database, setting up tables with required keys and relationships, and initializing data for services offered by the salon.

## Table of Contents
1. Create Database and Connect
2. Create Tables
3. Initialize Services Data
4. Primary and Foreign Key Constraints
5. (Optional) Update Services and Customers
6. Export Database to SQL File
7. Create and Run Shell Script

---

### 1. Create Database and Connect
To create and connect to the database:
```sql
psql --username=freecodecamp --dbname=postgres;

CREATE DATABASE salon;

\c salon
```

### 2. Create Tables
Create the necessary tables for appointments, customers, and services:
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
Insert initial data into the `services` table:
```sql
INSERT INTO services VALUES
(1, 'cut'), (2, 'color'), (3, 'perm'), 
(4, 'style'), (5, 'trim');
```

### 4. Primary and Foreign Key Constraints
Assign primary and foreign key constraints to ensure data integrity:
```sql
ALTER TABLE appointments ADD FOREIGN KEY (customer_id) REFERENCES customers (customer_id);
ALTER TABLE appointments ADD FOREIGN KEY (service_id) REFERENCES services (service_id);
```

### 5. (Optional) Update Services and Customers
To update existing records in the `services` or `customers` tables, you can use the `UPDATE` statement as needed.

#### Updating Services
To change the name of a service, use:
```sql
UPDATE services
SET name = 'new_service_name'
WHERE service_id = service_id_value;
```
For example, to change 'cut' to 'haircut':
```sql
UPDATE services
SET name = 'haircut'
WHERE service_id = 1;
```

#### Updating Customers
To update a customer's details, such as their name or phone number, use:
```sql
UPDATE customers
SET name = 'new_name', phone = 'new_phone_number'
WHERE customer_id = customer_id_value;
```
For example, to change a customer's name and phone number:
```sql
UPDATE customers
SET name = 'Jane Doe', phone = '123-456-7890'
WHERE customer_id = 1;
```

### 6. Export Database to SQL File
Export the database structure and data to an SQL file:
```bash
pg_dump -cC --inserts -U freecodecamp salon > salon.sql
```

### 7. Create and Run Shell Script
1. Create a shell script for managing the database:
   ```bash
   touch salon.sh
   chmod +x salon.sh
   ```
2. Run the shell script:
   ```bash
   ./salon.sh
   ```

---

This setup establishes a PostgreSQL database for scheduling and managing salon appointments, with initial data for services. You can easily update the services and customer records using SQL commands as demonstrated above, if needed.
