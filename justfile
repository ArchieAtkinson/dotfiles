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

z-new name dir:
    #!/usr/bin/env fish
    cd {{dir}}
    zellij attach --create-background {{name}} options --default-layout default
    zellij action switch-session {{name}}
z-switch name:
    zellij action switch-session {{name}}
