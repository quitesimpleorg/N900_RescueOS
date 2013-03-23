#/bin/bash
#Original by ShadowJK. http://enivax.net/jk/n900/ 
if [ -e /run/charger-runned ] ; then
echo "Script already started. Delete run/charger-runned if you are sure no other instance is running"
exit
fi
touch /run/charger-runned
echo "Charger: " $(cat /sys/devices/platform/musb_hdrc/charger)

I2CGET=/usr/bin/i2cget
I2CSET=/usr/bin/i2cset

if pgrep bme_RX-51; then
	echo "BME is running. Exiting."
	exit
fi

configure()
{
  echo -n "Pre-Config Status: " $($I2CGET -y 2 0x6b 0x00)
  echo -n ", " $($I2CSET -y 2 0x6b 0x00) "." 

  # Disable charger for configuration:
  # $I2CSET -y 2 0x6b 0x01 0xcc # No limit, 3.4V weak threshold, enable term, charger disable

  # Register 0x04
  # 8: reset
  # 4: 27.2mV  # charge current
  # 2: 13.6mV
  # 1: 6.8mV
  # 8: N/A
  # 4: 13.6mV # termination current
  # 2: 6.8mV
  # 1: 3.4mV
  # 7-1250 6-1150 5-1050 4-950 3-850 2-750 1-650 0-550
  # 7-400 6-350 5-300 4-250 3-200 2-150 1-100 0-50
  $I2CSET -y -m 0xFF 2 0x6b 0x04 0x42;

  # Register 0x02
  # 8: .640 V
  # 4: .320 V
  # 2: .160 V
  # 1: .080
  # 8: .040
  # 4: .020 (+ 3.5)
  # 2: otg pin active at high (default 1)
  # 1: enable otg pin
  $I2CSET -y -m 0xfc 2 0x6b 0x02 0x8c; 
  REGV=4200
  # 4.24 = 3.5 + .640 + .08 + .02 = 94 
  # 4.22 = 3.5 + ,640 + .08 = 90
  # 4.2 = 3.5 + .640 + .040 + .02 = 8c
  # 4.16 = 3.5 + .640V + .020 = 84
  # 4.1 = 3.5 + .320 + .160 + .08 + .04 = 78
  # 4.0 = 3.5 + .320 + .160 + .02 = 64
  # 3.9 = 3.5 + .320 + .080 = 50

  # Register 0x1
  # 8: 00 = 100, 01 = 500, 10 = 800mA
  # 4: 11 = no limit
  # 2: 200mV weak threshold default 1
  # 1: 100mV weak treshold defsult 1 (3.4 - 3.7)
  # 8: enable termination
  # 4: charger disable
  # 2: high imp mode
  # 1: boost
  $I2CSET -y 2 0x6b 0x01 0x08; 
  #hotswap: c0
  #normal: c8


  # Register 0x00
  # 8: Read:  OTG Pin Status
  #    Write: Timer Reset
  # 4: Enable Stat Pin
  # 2: Stat : 00 Ready 01 In Progress
  # 1:      : 10 Done  11 Fault
  # 8: Boost Mode
  # 4: Fault: 000 Normal 001 VBUS OVP 010 Sleep Mode 
  # 2:        011 Poor input or Vbus < UVLO 
  # 1:        100 Battery OVP 101 Thermal Shutdown
  #           110 Timer Fault 111 NA
  $I2CSET -y 2 0x6b 0x00 0x00; 

  # Softstart

  $I2CSET -y 2 0x6b 0x01 0xc8;
  sleep 1
  #echo " Unlimited: " $($I2CGET -y 2 0x6b 0x00)
  #$I2CSET -y 2 0x6b 0x00 0x80 # timer reset
  cat /sys/devices/platform/musb_hdrc/charger >/dev/null
}

configure

# Initialize variables
FULL=0
MODE="STANDBY"
WALLCHARGER=0

# Assuming a nice round number 20mOhm for bq27200 sense resistor
RS=21

# Assuming this much resistance between charger and battery
CR=131

BQPATH="/sys/class/power_supply/bq27200-0"

get_nac ()
{
    NAC=$(cat $BQPATH/charge_now)
    NAC=$((NAC/1000))
}
get_rsoc ()
{
    RSOC=$(cat $BQPATH/capacity)
}
get_volt ()
{
   VOLT=$(cat $BQPATH/voltage_now)
   VOLT=$((VOLT/1000))
}
get_rate ()
{
    RATE=$(cat $BQPATH/current_now)
    RATE=$((RATE/1000))
    RATE=$((-RATE))
}
calculate_system_use ()
{
    SYSTEM_USE=$(( ($REGV *1000 - $VOLT*1000) / $CR - $RATE ))
    if [ $(($SYSTEM_USE+$RATE)) -gt 950 ] ; then
        SYSTEM_USE=$((950-RATE))
    fi
}
decode_status()
{
  S=$1
  SOTG=$((S/128))
  S=$((S-SOTG*128))

  SSPIN=$((S/64))
  S=$((S-SSPIN*64))

  SSTAT=$((S/16))
  S=$((S-SSTAT*16))

  SBOOST=$((S/8))
  S=$((S-SBOOST*8))

  SFAULT=$((S))

#  if [ $SSTAT -eq 0 ] ; then
#    echo charger status: Ready 
#  fi
#  if [ $SSTAT -eq 1 ] ; then
#    echo charger status: InProgress 
#  fi
#  if [ $SSTAT -eq 2 ] ; then
#    echo charger status: Done 
#  fi
  if [ $SSTAT -eq 3 ] || [ $SFAULT -ne 0 ]; then
    echo -n $(date) charger status: Fault: 
    case $SFAULT in
     0 )
       echo NoFault  ;;
     1 )
       echo VbusOVP ;;
     2 )
       echo SleepMode ;;
     3 )
       echo Poor Input or VBus UnderVoltage ;;
     4 )
       echo Battery Overvoltage Protection ;;
     5 )
       echo Thermal Shutdown ;;
     6 )
       echo TimerFault ;;
     7 )
       echo Unknown ;;
    esac
  fi
}


SLEEPTIME=15

while true ; do
   STATUS=$($I2CGET -y 2 0x6b 0x00)
   #echo $STATUS

   $I2CSET -y -m 0x80 2 0x6b 0x00 0x80; # timer reset
   get_nac
   get_rsoc
   get_volt
   get_rate

   # Sanity
   if [ $VOLT -gt 4200 ] ; then
      echo "***CRITICAL*** Battery voltage $VOLT exceeds 4.2V!!!"
      exit 2
   fi

   if [ $MODE == "STANDBY" ] ; then
      if [ $STATUS == 0x10 ] || [ $STATUS == 0x90 ] ; then
         MODE="CHARGING" ; SLEEPTIME=5
         echo $(date) "standby -> CHARGING. Current available capacity: " $NAC "mAh, " $RSOC " percent."
         WALLCHARGER=$(cat /sys/devices/platform/musb_hdrc/charger)
      fi
   fi

   if [ $MODE == "CHARGING" ] ; then
      if [ $STATUS == 0x00 ] ; then
         MODE="STANDBY" ; SLEEPTIME=15
         echo $(date) "charging -> STANDBY. Current available capacity: " $NAC "mAh, " $RSOC " percent."
         WALLCHARGER=0
         # This will stop USB from eating power as long as you haven't plugged it into a PC
#       ####  echo 0 > /sys/devices/platform/musb_hdrc/connect
      fi
   fi

   if [ $STATUS == 0x20 ] && [ $FULL == 0 ] ; then
      echo "Charge done"
      #echo $(date) "FULL: " $NAC "mAh" >> /home/user/MyDocs/charger.log
      FULL=1
   fi

   if [ $STATUS == 0x00 ] && [ $FULL == 1 ] ; then
      FULL=0
   fi

   calculate_system_use
   decode_status $STATUS
   echo Status: $STATUS Mode: $MODE Full: $FULL Wall: $WALLCHARGER Voltage: $VOLT NAC: $NAC level: $RSOC % Rate: $RATE System: "-"$SYSTEM_USE Ch: $(($SYSTEM_USE+$RATE))
   sleep $SLEEPTIME
done
