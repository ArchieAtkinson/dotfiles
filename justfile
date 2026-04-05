@vpn arg:
    sudo systemctl {{arg}} openvpn-tunnelbear.service


AIRPODS_UUID := "80:95:3A:D6:F3:38"

airpods:
    #!/usr/bin/env bash
    if bluetoothctl -- info {{AIRPODS_UUID}} 2>/dev/null | grep -q "Connected: yes"; then
        bluetoothctl -- disconnect {{AIRPODS_UUID}}
    else
        bluetoothctl -- connect {{AIRPODS_UUID}}
    fi

