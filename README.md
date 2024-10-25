# Salon Appointment Scheduler

This project sets up a database for managing salon appointments. It includes creating a PostgreSQL database, setting up tables with required keys and relationships, and initializing data for services offered by the salon.

## Table of Contents
1. [Create Database and Connect](#create-database-and-connect)
2. [Create Tables](#create-tables)
3. [Initialize Services Data](#initialize-services-data)
4. [Primary and Foreign Key Constraints](#primary-and-foreign-key-constraints)
5. [Export Database to SQL File](#export-database-to-sql-file)
6. [Create and Run Shell Script](#create-and-run-shell-script)

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

### 5. Export Database to SQL File
Export the database structure and data to an SQL file:
```bash
pg_dump -cC --inserts -U freecodecamp salon > salon.sql
```

### 6. Create and Run Shell Script
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

This setup establishes a PostgreSQL database for scheduling and managing salon appointments with initial data for services.
