#!/bin/bash

# Define a variable PSQL to store the psql command with options for connecting to the database
# --username: specifies the user to connect as (freecodecamp)
# --dbname: specifies the database name (salon)
# -t: suppresses the printing of the column names in the output
# --no-align: removes the alignment of the output for easier parsing
# -c: allows executing a command (SQL query) directly
PSQL="psql --username=freecodecamp --dbname=salon -t --no-align -c"

# Print the salon header, creating visual separation in the terminal output
echo -e "\n~~~~~ MY SALON ~~~~~"
# Welcome message for the user, prompting them for the next action
echo -e "\nWelcome to My Salon, how can I help you?"

# Function to display available services from the database
DISPLAY_SERVICES() {
  # Print a message indicating what will be shown next
  echo -e "\nServices offered:"
  # Execute a SQL query to retrieve service IDs and names from the services table
  SERVICES=$($PSQL "SELECT service_id, name FROM services")
  
  # Process each line of the query result
  # IFS="|" sets the Internal Field Separator to "|" so we can split each line based on this character
  # read SERVICE_ID SERVICE_NAME reads the fields into the corresponding variables
  echo "$SERVICES" | while IFS="|" read SERVICE_ID SERVICE_NAME
  do
    # Print the service ID followed by the service name in a user-friendly format
    echo "$SERVICE_ID) $SERVICE_NAME"
  done
}

# Function to handle the user's service selection
SERVICE_SELECTION() {
  # Call the function to display the available services
  DISPLAY_SERVICES
  
  # Read user input for the selected service ID
  # The read command captures the user's input and stores it in SERVICE_ID_SELECTED
  read SERVICE_ID_SELECTED
  
  # Execute a SQL query to get the name of the selected service using the ID provided by the user
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED")

  # Check if the SERVICE_NAME variable is empty, indicating that the user input was invalid
  if [[ -z $SERVICE_NAME ]]
  then
    # Notify the user that the service was not found
    echo -e "\nI could not find that service. What would you like today?"
    # Recursively call the SERVICE_SELECTION function to allow the user to select again
    SERVICE_SELECTION
  else
    # Prompt the user for their phone number
    echo -e "\nWhat's your phone number?"
    # Capture the phone number input from the user
    read CUSTOMER_PHONE
    
    # Query the database to check if the customer already exists using the provided phone number
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
    
    # Check if the CUSTOMER_NAME variable is empty, indicating that the phone number is not found in the database
    if [[ -z $CUSTOMER_NAME ]]
    then
      # If the customer is new, ask for their name
      echo -e "\nI don't have a record for that phone number, what's your name?"
      # Capture the customer's name input
      read CUSTOMER_NAME
      
      # Execute an SQL INSERT command to add the new customer to the database
      # The values are wrapped in single quotes to properly format the SQL command
      INSERT_CUSTOMER=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE')")
    fi
    
    # Retrieve the customer ID from the database based on the phone number
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
    
    # Ask the user for their preferred appointment time
    echo -e "\nWhat time would you like your $SERVICE_NAME, $CUSTOMER_NAME?"
    # Capture the time input from the user
    read SERVICE_TIME
    
    # Insert a new appointment record into the appointments table
    # The appointment includes the customer ID, selected service ID, and requested time
    INSERT_APPOINTMENT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
    
    # Check if the insertion was successful by matching the output with "INSERT 0 1", which indicates one row was added
    if [[ $INSERT_APPOINTMENT == "INSERT 0 1" ]]
    then
      # Confirm the appointment details to the user in a friendly format
      echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
    fi
  fi
}

# Start the appointment process by calling the SERVICE_SELECTION function
SERVICE_SELECTION
