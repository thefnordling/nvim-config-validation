#!/bin/bash

# Bash script test for Neovim configuration validation
# Tests LSP features, formatting, and linting

set -euo pipefail

# Global variables
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly LOG_FILE="${SCRIPT_DIR}/test.log"
readonly DATA_FILE="${SCRIPT_DIR}/people.json"

# Initialize logging
log_message() {
    local level="$1"
    local message="$2"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    echo "[$timestamp] [$level] $message" | tee -a "$LOG_FILE"
}

# Function for testing autocomplete and go-to-definition
validate_email() {
    local email="$1"
    
    if [[ ! "$email" =~ ^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$ ]]; then
        log_message "ERROR" "Invalid email format: $email"
        return 1
    fi
    
    log_message "INFO" "Email validated: $email"
    return 0
}

# Function with intentional shellcheck issues for testing linting
create_backup() {
    local source_file="$1"
    local backup_dir="${SCRIPT_DIR}/backups"
    
    # Missing quotes - shellcheck will warn about this
    mkdir -p $backup_dir
    
    if [[ -f "$source_file" ]]; then
        local backup_name="backup_$(date +%Y%m%d_%H%M%S).bak"
        cp "$source_file" "${backup_dir}/${backup_name}"
        log_message "INFO" "Created backup: ${backup_name}"
    else
        log_message "WARN" "Source file not found: $source_file"
    fi
}

# Function with array handling for testing syntax highlighting
process_user_list() {
    local emails=("alice@example.com" "bob@test.org" "charlie@domain.co.uk" "invalid-email")
    local valid_emails=()
    local invalid_count=0
    
    log_message "INFO" "Processing ${#emails[@]} email addresses"
    
    for email in "${emails[@]}"; do
        if validate_email "$email"; then
            valid_emails+=("$email")
        else
            ((invalid_count++))
        fi
    done
    
    log_message "INFO" "Valid emails: ${#valid_emails[@]}, Invalid: $invalid_count"
    
    # Export valid emails for use by other functions
    printf '%s\n' "${valid_emails[@]}"
}

# Function for testing command line argument parsing
parse_arguments() {
    local verbose=false
    local output_file=""
    local action="test"
    
    while [[ $# -gt 0 ]]; do
        case $1 in
            -v|--verbose)
                verbose=true
                shift
                ;;
            -o|--output)
                output_file="$2"
                shift 2
                ;;
            -a|--action)
                action="$2"
                shift 2
                ;;
            -h|--help)
                show_help
                exit 0
                ;;
            *)
                log_message "ERROR" "Unknown argument: $1"
                exit 1
                ;;
        esac
    done
    
    # Export variables for use in other functions
    export VERBOSE="$verbose"
    export OUTPUT_FILE="$output_file"
    export ACTION="$action"
}

# Function demonstrating error handling
safe_execute() {
    local command="$1"
    local description="$2"
    
    log_message "INFO" "Executing: $description"
    
    if eval "$command"; then
        log_message "INFO" "Successfully executed: $description"
        return 0
    else
        log_message "ERROR" "Failed to execute: $description"
        return 1
    fi
}

# Function for testing file operations
generate_test_data() {
    local output_file="${1:-$DATA_FILE}"
    
    log_message "INFO" "Generating test data to: $output_file"
    
    cat > "$output_file" << EOF
{
  "people": [
    {
      "name": "Alice Johnson",
      "email": "alice@example.com",
      "age": 30,
      "active": true
    },
    {
      "name": "Bob Smith", 
      "email": "bob@test.org",
      "age": 25,
      "active": true
    },
    {
      "name": "Carol Davis",
      "email": "carol@company.com", 
      "age": 35,
      "active": false
    }
  ]
}
EOF
    
    log_message "INFO" "Test data generated successfully"
}

# Function for testing mathematical operations
calculate_statistics() {
    local numbers=("$@")
    local sum=0
    local count=${#numbers[@]}
    
    if [[ $count -eq 0 ]]; then
        log_message "ERROR" "Cannot calculate statistics for empty array"
        return 1
    fi
    
    # Calculate sum
    for num in "${numbers[@]}"; do
        sum=$((sum + num))
    done
    
    # Calculate average (bash only supports integer arithmetic)
    local average=$((sum / count))
    
    echo "Count: $count"
    echo "Sum: $sum" 
    echo "Average: $average"
    
    log_message "INFO" "Statistics calculated for $count numbers"
}

# Help function
show_help() {
    cat << EOF
Usage: $0 [OPTIONS]

Bash script for testing Neovim configuration features.

Options:
    -v, --verbose       Enable verbose logging
    -o, --output FILE   Specify output file
    -a, --action ACTION Specify action to perform
    -h, --help         Show this help message

Actions:
    test      Run all tests (default)
    backup    Create backup files
    data      Generate test data only
    stats     Calculate sample statistics

Examples:
    $0 --verbose --action test
    $0 --output results.txt --action data
    $0 --action stats
    
EOF
}

# Main execution function
main() {
    # Clear previous log
    > "$LOG_FILE"
    
    log_message "INFO" "Starting Bash Neovim test script"
    log_message "INFO" "Script: $0"
    log_message "INFO" "Working directory: $SCRIPT_DIR"
    
    # Parse command line arguments
    parse_arguments "$@"
    
    if [[ "$VERBOSE" == "true" ]]; then
        log_message "INFO" "Verbose mode enabled"
    fi
    
    # Execute based on action
    case "$ACTION" in
        "test")
            log_message "INFO" "Running full test suite"
            
            # Test email processing
            log_message "INFO" "Testing email validation"
            readarray -t valid_emails < <(process_user_list)
            log_message "INFO" "Found ${#valid_emails[@]} valid emails"
            
            # Test file operations
            generate_test_data
            
            # Test backup functionality  
            if [[ -f "$DATA_FILE" ]]; then
                create_backup "$DATA_FILE"
            fi
            
            # Test statistics
            log_message "INFO" "Testing statistics calculation"
            calculate_statistics 10 20 30 40 50
            ;;
            
        "backup")
            log_message "INFO" "Creating backup files"
            create_backup "$DATA_FILE"
            ;;
            
        "data")
            log_message "INFO" "Generating test data only"
            generate_test_data "${OUTPUT_FILE:-$DATA_FILE}"
            ;;
            
        "stats")
            log_message "INFO" "Calculating sample statistics"
            calculate_statistics 5 10 15 20 25 30
            ;;
            
        *)
            log_message "ERROR" "Unknown action: $ACTION"
            show_help
            exit 1
            ;;
    esac
    
    log_message "INFO" "Script completed successfully"
    
    if [[ -n "$OUTPUT_FILE" ]]; then
        log_message "INFO" "Output saved to: $OUTPUT_FILE"
    fi
}

# Script entry point
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi