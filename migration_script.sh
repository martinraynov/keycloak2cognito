#!/bin/sh

OUTPUT_FILE="output.csv"

################ Functions ################
validate_params()
{
    if [ -z "${USER_POOL_ID}" ]; then echo "Environment variable \$REGISTRY_HOST is empty, please set this before executing the script" && exit 1; fi
}

create_migration_file()
{
    echo "username|email|firstname|lastname" > $OUTPUT_FILE
    for f in exports/*; do
        echo "File -> $f"
        cat ${f} | jq -r '.users[] | (.username | split("@") | .[0]+"__"+.[1]) + "|" + .email + "|" + .firstName + "|" + .lastName' >> output.csv
    done
}

create_cognito_users() 
{
    echo "create_cognito_user"
    sed 1d $OUTPUT_FILE | while read line
    do
        # Create Cognito User
        echo "Integrating line : $line"
        echo $line | awk -F'|' '{cmd="aws cognito-idp admin-create-user --user-pool-id '$USER_POOL_ID' \
        --username "$1" \
        --user-attributes Name=email,Value="$2" Name=name,Value="$3" Name=family_name,Value="$4" Name=email_verified,Value=false \
        | jq"; system(cmd)}'
        echo "End of integration"
        echo "------------------"
    done
}
###########################################

################## Main ###################
validate_params
remove_error_log
create_migration_file
create_cognito_users
###########################################
