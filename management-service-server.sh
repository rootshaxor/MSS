#!/bin/bash
clear

banner()
{
echo -e "$merah"
echo "[+]=====o00=================[+] [+]=================00o=====[+] "
echo "         \|   ___    __oo0__________0oo__     ___   |/          "
echo "          \__{0V0}__/[===================]\__{0V0}__/           "
echo -e "              \^/     ||   $kun_c SYSADMIN$merah   ||     \^/               "
echo -e "              |H|     ||   $kun_c  NEVER$merah     ||     |H|               "
echo -e "              /V\     ||   $kun_c  SLEEP$merah     ||     /V\               "
echo "             /   \   [===================]   /   \              "
echo "          _./     \._                     _./     \._           "
echo "    [====o00=======00o====]         [====o00=======00o====]     "
echo -e "{+}{+}{+}{+}{+}{+}{+}{+}{+}{+}-{+}{+}{+}{+}{+}{+}{+}{+}{+}{+}{+} $N"
}


#Warna
merah='\033[0;31m'
merah_c='\033[1;31m'
hijau_c='\033[1;32m'
biru_c='\033[1;34m'
kun_c='\033[1;33m'
N='\033[00m'

if [[ $(id -u) == 0 ]];
    then
        sleep 0.1
    else
        echo -e $merah"please run $(basename $0) as administrator (sudo)$N"
        exit
fi

PS3="$(basename $0) =>"
config="conf/service.list"

if [[ -f $config ]]; then
        sleep 0.1
    else
        echo "File $config Not Found"
        exit
    fi

start()
{
clear
            echo -e $biru_c"==================================="
            echo -e $merah"SERVICE\t  RUNNING\t   STATUS"
            echo -e $biru_c"==================================="
    for i in $(cat $config)
        do
            
            echo -e $merah_c"$i\t $hijau_c Starting\t $merah_c $(systemctl start $i 2>/dev/null) $N[$biru_c$(systemctl status $i | grep "Active:" | awk {'print $2'})$N]"
    done
	read -p "back to menu ..." back
    $0
}

stop()
{
clear
            echo -e $biru_c"==================================="
            echo -e $merah"SERVICE\t  RUNNING\t   STATUS"
            echo -e $biru_c"==================================="
for i in $(cat $config)
        do
            echo -e $merah_c"$i\t $hijau_c Stoping\t $(systemctl stop $i 2>/dev/null) $N[$biru_c$(systemctl status $i | grep "Active:" | awk {'print $2'})$N]"
    done
	read -p "back to menu ..." back
    $0
}


status()
{
clear
            echo -e $biru_c"==================================="
            echo -e $merah"SERVICE\t  RUNNING\t   STATUS"
            echo -e $biru_c"==================================="
for i in $(cat $config)
       do
            echo -e $merah_c"$i\t $hijau_c Status\t $N[$biru_c$(systemctl status $i | grep "Active:" | awk {'print $2'})$N]"
    done
	read -p "back to menu ..." back
    $0
}



restart()
{
clear
            echo -e $biru_c"==================================="
            echo -e $merah"SERVICE\t  RUNNING\t   STATUS"
            echo -e $biru_c"==================================="
   for i in $(cat $config)
        do
            echo -e $merah_c"$i\t $hijau_c Restarting\t $(systemctl restart $i 2>/dev/null) $N[$biru_c$(systemctl status $i | grep "Active:" | awk {'print $2'})$N]"
    done
    read -p "back to menu ..." back
    $0
}

add(){
    clear
    echo -e "$biru_c"
    read -p 'Name Service : ' name_service
        if [[ -n $(cat $config | grep "$name_service") ]]; then
            echo -e $merah "$name_service Alredy on List !!! $N"
            sleep 1
            add
        else
            if [[ -f "/usr/lib/systemd/system/$name_service.service" ]]; then
                echo "$name_service" >> $config
                echo -e $hijau_c"Add $service_name Succes !!! $N"
                read -p "back to menu ..." back
                $0
            else
                echo -e $merah"Not Found Service $name_service !!!"
                sleep 1
                add
            fi
        fi
}

remove()
{
    clear
    echo -e $merah_c"Warning!!!"
    echo -e $merah"Remove Service manualy !!!"
    sleep 1
    nano $config
    $0
}

list()
{
    echo -e "$merah_c"
    clear
    less $config
    $0
}

keluar()
{
    clear
    echo -e $hijau_c"Thanks Using $(basename $0) $N"
    sleep 1
    clear && exit
}


banner
echo -e "$hijau_c"
select management in "Start" "Stop" "Status" "Restart" "Add Service" "List Service" "Remove Service" "Exit"
    do
        case $management in
        "Start") start;;
        "Stop") stop;;
        "Status") status;;
        "Restart") restart;;
        "Add Service") add;;
        "List Service") list;;
        "Remove Service") remove;; 
        "Exit") keluar;;
        *) echo -e $merah"Please Select value on list"; sleep 1; $0;;
        esac
done
echo -e "$N"