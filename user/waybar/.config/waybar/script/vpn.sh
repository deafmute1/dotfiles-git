#!/bin/bash

CONNECTION=$(LC_ALL=C nmcli -t connection show --active | awk -F ':' '
{ if($3 == "vpn") {
    vpn_name=$1
  } else if ($3 == "tun"){
    tun_name=$1
  } else if ($3 == "tap"){
    tun_name=$1
  } else if ($3 == "wireguard") {
    tun_name=$1
  }
}
END{if (vpn_name) {printf("%s", vpn_name)}  else if(tun_name) {printf("%s", tun_name)}}')


if [[ -z "$CONNECTION" ]]; then
    exit 1
else
    echo $CONNECTION  
    exit 0 
fi
