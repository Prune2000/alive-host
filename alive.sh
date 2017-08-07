cdl="""
 █████                                                        █████
 █                                                                █
 █   ███████ ██    ██  ██  ██ █████   ██  ██ ██████ █████ ██████  █      
 █   ██   ██ ██    ██  ██  ██ ██      ██  ██ ██  ██ ██      ██	  █     
 █   ███████ ██    ██  ██  ██ █████   ██████ ██  ██  ████   ██	  █      
 █   ██   ██ ██    ██  ██  ██ ██      ██  ██ ██  ██    ██   ██	  █      
 █   ██   ██ ████  ██   ████  █████   ██  ██ ██████ █████   ██	  █
 █   by Corben Douglas (@sxcurity)                                █
 █████                                                        █████
"""
# some totally rad colors my doods
BLU="\e[94m"
RED="\e[91m"
RST="\e[0m"
GRN="\e[92m"
YEL="\e[93m"

# logo 
echo -e $GRN
cat <<EOF
$cdl
EOF
echo -e $RST

# Catch error
if [ -z "$1" ]; then
	echo -e "$RED [+] ERROR: Usage: $0 hosts.txt$RST\n"
else

INPUT="$1"

if [ ! -f $INPUT ]; then
	echo -e "$RED [+] ERROR: Input file does not exist!$RST\n"
else	
	# touch it and make sure it's empty for when you re-run this script :p	
	touch alive_hosts.txt && cat /dev/null &> alive_hosts.txt
	
	for domain in `cat $INPUT` 
	do
		# Added trap because ctrl+c would stop 
                # showing text in my shell for some reason
		trap "reset && echo -e '\n $RED Ctrl+C was Pressed!\n' && exit" INT

		echo -e "$BLU Probing$RST" $domain
		if [[ $(nmap -Pn -sP $domain)  = *Host* ]]; then
			echo -e $domain\ >> alive_hosts.txt
		fi
	done
echo -e '\n'
echo -e "$GRN [+] Alive Hosts saved to$RED alive_hosts.txt $RST\n"
fi
fi
