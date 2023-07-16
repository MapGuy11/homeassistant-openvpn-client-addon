#!/usr/bin/env bash
set +u

CONFIG_PATH=/data/options.json

OVPNFILE="$(jq --raw-output '.ovpnfile' $CONFIG_PATH)"
OPENVPN_CONFIG=/share/${OVPNFILE}

########################################################################################################################
# Initialize the tun interface for OpenVPN if not already available
# Arguments:
#   None
# Returns:
#   None
########################################################################################################################
function init_tun_interface(){
    # create the tunnel for the openvpn client

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
        echo "File ${OPENVPN_CONFIG} not found"
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

    echo "Wait until the user uploads the files."
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

echo "Setup the VPN connection with the following OpenVPN configuration."

# try to connect to the server using the used defined configuration
openvpn --config ${OPENVPN_CONFIG}