#!/bin/sh

path=`pwd`
file1=$path/check.sh        #directory cli script
ip_file=$path/ip.txt
user=root # debug login user
guiuser=admin # WebUI login user
# output_file=$path/out.txt      # output files
csv_file=$path/csv.txt
#file2=$path/input.txt
file3=$path/dbread.txt
file4=$path/update.sh
file5=$path/fwstatus.sh
output_dir=$path/out
# > $output_file
> $csv_file
/usr/Systems/OTNE_1/script/dbread_pdu |grep '1830PSS-PHN' > $file3  # this line to retriving the OTE data base for all phtonic NEs to store there IP address and node id in dbread.txt file
# cat $file3 |awk '{print $5}'|sed 's/TL1//g; s/,//g' > $ip_file

# start cli session to get the shelf config
# printf "%s\n" "node,,,ip,,,shelf,,,slot,,,part_number,,,serial_number,,,Vendor,,,ActBank,,,FWA,,,FWB,," > $csv_file

InvProc () {
cat $ip_file | while read ip 
do
# ip variable bug fix
node_id=`grep "\b$ip\b" $file3 | awk '{print $2}'`
   $file1 $output_dir/$ip.$node_id.cli $ip $guiuser $guipass
#Report
done
}

# ScanProc () {
# cat $ip_file | while read ip 
# do
# #ip variable bug fix
# node_id=`grep "\b$ip\b" $file3 | awk '{print $2}'`
# grep S13X100 $output_dir/$ip.*.cli|awk '{print $1 " " $4 " " $5}'|sed -e 's/\// /' | while read shelf slot part serial
# do
# $file4 $output_dir/"$ip"_"$shelf"_"$slot".log $ip $shelf $slot $user $pass
# VendorData=`grep DATA $output_dir/"$ip"_"$shelf"_"$slot".log|awk '{print $2 $3 $4 $5 $6 $7 $8}'`
# VendorID=`echo $VendorData | xxd -r -p`
# if [ $VendorID == "" ]; then
# VendorID="N/A"
# else
# echo "continue"
# fi;
# echo "Here is the $VendorID"
# if [ $VendorID == "LUMENTU" ]; then
# $file5 $output_dir/"$ip"_"$shelf"_"$slot".status $ip $shelf $slot $user $pass
# UpgradeStatus=`grep DATA $output_dir/"$ip"_"$shelf"_"$slot".status|head -1|awk '{print $2}'`
# echo "Here is the $UpgradeStatus"
# FwVersionA=`grep DATA $output_dir/"$ip"_"$shelf"_"$slot".status|tail -2|head -1|awk '{print $2 "." $3}'`
# FwVersionB=`grep DATA $output_dir/"$ip"_"$shelf"_"$slot".status|tail -2|tail -1|awk '{print $2 "." $3}'`
# else
# echo "skip"
# UpgradeStatus="N/A"
# fi;
# Report
# done
# done
# }

# Report () {
# header=`echo "$node_id" "," "$ip" |  tr -d '\r'`
# shelf_id=`echo "$shelf" -d '\r'` 
# slot_id=`echo "$slot" -d '\r'`
# part_id=`echo "$part" -d '\r'`
# serial_id=`echo "$serial" -d '\r'`
# csv[0]=`echo "$header" | tr -d '\r'`
# csv[1]=`echo ","`
# csv[2]=`echo "$shelf"  | tr -d '\r'`
# csv[3]=`echo ","`
# csv[4]=`echo "$slot" | tr -d '\r'  `
# csv[5]=`echo ","`
# csv[6]=`echo "$part"  | tr -d '\r'`
# csv[7]=`echo ","`
# csv[8]=`echo "$serial"  | tr -d '\r'`
# csv[9]=`echo ","`
# csv[10]=`echo "$VendorID"  | tr -d '\r'`
# csv[11]=`echo ","`
# csv[12]=`echo "$UpgradeStatus"  | tr -d '\r'`
# csv[13]=`echo ","`
# csv[14]=`echo "$FwVersionA"  | tr -d '\r'`
# csv[15]=`echo ","`
# csv[16]=`echo "$FwVersionB"  | tr -d '\r'`
# csv[17]=`echo ","`
# test=`echo $(echo ${csv[@]})  |  tr ' ' ','`
# printf "%s\n" $test >> $csv_file
# }

#read input
echo
echo "1830 PSS poweroffset Audit & Update script"
echo
echo Please enter NE WEBUI credential :
IFS= read -rs webui_pass
guipass="$webui_pass"
echo
echo Please enter Action type :  "scan" :
read action_type
echo ActionType : $action_type

if [ $action_type == "scan" ]; then
InvProc
ScanProc
else
 echo "no action performed"
fi;
exit;
exit;
