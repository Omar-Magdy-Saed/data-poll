#!/usr//local/bin/expect -f
set output [lindex $argv 0]
set ipaddress [lindex $argv 1]
set shelf [lindex $argv 2]
set slot [lindex $argv 3]
log_file -noappend $output
set timeout 10000
spawn ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null cli@$ipaddress
expect {
 "*assword:" {
 send -- "cli\r"
 exp_continue
}
 "*name:" {
 send -- "admin\n"
 expect "*assword:"
 send -- "admin\n"
# interact
}
}
expect "Do you acknowledge? (Y/N)?"
send -- "Y\n"
expect "*#"
send -- "pag st dis\n"
expect "*#"
send -- "alm $shelf/$slot \n"
expect "*#"
send -- "sh cond $shelf/$slot \n"
expect "*#"
send -- "sh card inv $shelf/$slot \n"
expect "*#"
send -- "sh firm card $shelf/$slot det\n"
expect "*#"
send -- "sh int br $shelf/$slot \n"
expect "*#"
send -- "pag st ena\n"
expect "*#"
send -- "logout\n"
expect eof
