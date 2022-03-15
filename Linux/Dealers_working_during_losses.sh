#!/bin/bash
echo "0310 Dealer Schedule"
awk -F " " '{print $1, $2, $5, $6}' 0310_Dealer_schedule | egrep '(05:00:00 AM|08:00:00 AM|02:00:00 PM|08:00:00 PM|11:00:00 PM|Dealer)'
echo
echo "0312 Dealer Schedule"
awk -F " " '{print $1, $2, $5, $6}' 0312_Dealer_schedule | egrep '(05:00:00 AM|08:00:00 AM|02:00:00 PM|08:00:00 PM|11:00:00 PM|Dealer)'
echo
echo "0315 Dealer Schedule"
awk -F " " '{print $1, $2, $5, $6}' 0315_Dealer_schedule | egrep '(05:00:00 AM|08:00:00 AM|02:00:00 PM|Dealer)'
