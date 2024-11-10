
#!/bin/bash

# Function to generate a new random username
generate_new_username() {
    tr </dev/urandom -dc A-Za-z0-9 | head -c8
}

# Function to generate a new random password
generate_new_password() {
    tr </dev/urandom -dc A-Za-z0-9 | head -c8
}

# Function to generate a new random port
generate_new_port() {
    echo $(($RANDOM % 64512 + 1024))  # Generate a port number between 1024 and 65535
}

# File path to the 3proxy configuration
config_file="/usr/local/etc/3proxy/3proxy.cfg"

# Function to update the 3proxy configuration file with new usernames and passwords
update_credentials() {
    # Display current users
    echo "Current users in 3proxy:"
    # Extract the users from the 3proxy config file
    local old_users=($(awk '/^users/ {for(i=2;i<=NF;i++) print $i}' $config_file | awk -F: '{print $1}'))
    
    if [ ${#old_users[@]} -eq 0 ]; then
        echo "No users found in 3proxy configuration."
        return
    fi
    
    for i in "${!old_users[@]}"; do
        echo "$((i+1))) ${old_users[$i]}"
    done

    read -p "Select the user you want to change (enter the number): " user_index
    user_index=$((user_index-1))  # Adjust for 0-based array indexing

    if [[ $user_index -ge 0 && $user_index -lt ${#old_users[@]} ]]; then
        read -p "Enter the new username: " new_user
        if [[ -z "$new_user" ]]; then
            echo "Username cannot be empty. Operation canceled."
            return
        fi

        read -p "Enter the new password: " new_pass
        if [[ -z "$new_pass" ]]; then
            echo "Password cannot be empty. Operation canceled."
            return
        fi
        
        old_user=${old_users[$user_index]}
        
        # Update the users list in the config file
        sed -i "s/${old_user}:CL:[^ ]*/${new_user}:CL:${new_pass}/g" $config_file
        
        # Update the allow list in the config file
        sed -i "s/allow ${old_user}/allow ${new_user}/g" $config_file

        echo "User ${old_user} changed to ${new_user} with new password ${new_pass}"
    else
        echo "Invalid selection."
    fi
}


# Function to update the 3proxy configuration file with new port numbers
update_ports() {
    # Display current ports
    echo "Current ports in 3proxy:"
    local old_ports=($(grep -oP '(?<=-p)[0-9]+' $config_file))
    
    if [ ${#old_ports[@]} -eq 0 ]; then
        echo "No ports found in 3proxy configuration."
        return
    fi
    
    for i in "${!old_ports[@]}"; do
        echo "$i) ${old_ports[$i]}"
    done

    read -p "Select the port you want to change (enter the number): " port_index

    if [[ $port_index -ge 0 && $port_index -lt ${#old_ports[@]} ]]; then
        read -p "Enter the new port: " new_port
        old_port=${old_ports[$port_index]}
        sed -i "s/-p${old_port}/-p${new_port}/g" $config_file
        echo "Port ${old_port} changed to ${new_port}"
    else
        echo "Invalid selection."
    fi
}


# Main script
while true; do
    echo "Please select an action:"
    echo "1) Change usernames and passwords"
    echo "2) Change ports"
    echo "3) Exit"
    read -p "Enter your choice: " choice

    case $choice in
        1) update_credentials ;;
        2) update_ports ;;
        3) exit ;;
        *) echo "Invalid choice. Please enter 1, 2, or 3." ;;
    esac
done

