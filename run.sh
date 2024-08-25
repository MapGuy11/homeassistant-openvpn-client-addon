#!/usr/bin/env bash
set +u

CONFIG_PATH=/data/options.json
OPENVPN_CONFIG_PATH=/config

OVPNFILE="$(jq --raw-output '.ovpnfile' $CONFIG_PATH)"
OPENVPN_CONFIG=/config/${OVPNFILE}

USERNAME="$(jq --raw-output '.username' $CONFIG_PATH)"
PASSWORD="$(jq --raw-output '.password' $CONFIG_PATH)"

########################################################################################################################
# Initialize the tun interface for OpenVPN if not already available
# Arguments:
#   None
# Returns:
#   None
########################################################################################################################
function init_tun_interface(){
    # create the tunnel for the OpenVPN client
    mkdir -p /dev/net
    if [ ! -c /dev/net/tun ]; then
        mknod /dev/net/tun c 10 200
    fi
}
########################################################################################################################
# Check if all required files are available.
# Globals:
#   REQUIRED_FILES
#   STORAGE_LOCATION
# Arguments:
#   None
# Returns:
#   0 if all files are available and 1 otherwise
########################################################################################################################
function check_files_available(){
    failed=0

    if [[ ! -f ${OPENVPN_CONFIG} ]]
    then
        echo "We could not find your ${OPENVPN_CONFIG}. Did you put it in the ${OPENVPN_CONFIG_PATH} directory?"
        echo ""
        failed=1
        break
    fi

    if [[ ${failed} == 0 ]]
    then
        return 0
    else
        return 1
    fi
}

########################################################################################################################
# Wait until the user has uploaded all required certificates and keys in order to setup the VPN connection.
# Globals:
#   REQUIRED_FILES
#   CLIENT_CONFIG_LOCATION
# Arguments:
#   None
# Returns:
#   None
########################################################################################################################
function wait_configuration(){
    echo "Waiting for user to put the OpenVPN configuration file in ${OPENVPN_CONFIG_PATH}"
    # therefore, wait until the user upload the required certification files
    while true; do
        check_files_available

        if [[ $? == 0 ]]
        then
            break
        fi

        sleep 5
    done
    echo "All files available!"
}

init_tun_interface

# wait until the user uploaded the configuration files
wait_configuration

echo ""
echo ""
echo "Setting up the VPN connection with the following OpenVPN configuration: ${OPENVPN_CONFIG}"
echo ""
echo ""

AUTH_FILE="/etc/openvpn/auth.txt"

if [[ -n "$USERNAME" ]] && [[ -n "$PASSWORD" ]]; then
    echo "Using provided username and password"
    echo "$USERNAME" > $AUTH_FILE
    echo "$PASSWORD" >> $AUTH_FILE
    chmod 600 $AUTH_FILE
    AUTH_OPTION="--auth-user-pass $AUTH_FILE"
else
    echo "No username and password provided, skipping auth-user-pass"
    AUTH_OPTION=""
fi

# try to connect to the server using the user-defined configuration and credentials (if provided)
openvpn --config ${OPENVPN_CONFIG} $AUTH_OPTION
