#!/bin/bash
banner()
{
  printf " %-40s \n" "`echo -e "Nuyul Faucet cantodlo\n\n\n"`"
}
banner


merah='\e[91m'
cyan='\e[96m'
kuning='\e[93m'
oren='\033[0;33m' 
margenta='\e[95m'
biru='\e[94m'
ijo="\e[92m"
putih="\e[97m"
normal='\033[0m'
bold='\e[1m'
labelmerah='\e[41m'
labelijo='\e[42m'
labelkuning='\e[43m'
labelpp='\e[45m'
# RATIO


res1=$(date +%s)
register(){
    res1=$(date +%s)
    empas="${biru}${1}/${2}"
    stats="${margenta}[$(date +"%T")]"
	rand1=$(echo $((RANDOM%9999)))
	getMint=$(curl -s "https://mainnode.plexnode.org:1317/ethermint/evm/v1/cosmos_account/$1" -H "User-Agent: Mozilla/5.0 (iPhone X; CPU iPhone OS 12_1_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.1 Mobile/15E148 Safari/604.1" -H "Accept: application/json" -H "Accept-Language: id,en-US;q=0.7,en;q=0.3" -H "Accept-Encoding: gzip, deflate, br" -H "Referer: https://convert.canto.io/" -H "Origin: https://convert.canto.io" -H "Connection: keep-alive" -H "Sec-Fetch-Dest: empty" -H "Sec-Fetch-Mode: cors" -H "Sec-Fetch-Site: cross-site" | grep -Po '(?<="cosmos_address": ")[^"]*')
	gas=$(curl -s "https://bot.plexnode.wtf/" -X POST -H "User-Agent: Mozilla/5.0 (iPhone X; CPU iPhone OS 12_1_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.1 Mobile/15E148 Safari/604.1" -H "Accept: */*" -H "Accept-Language: id,en-US;q=0.7,en;q=0.3" -H "Accept-Encoding: gzip, deflate, br" -H "Referer: https://convert.canto.io/" -H "Content-Type: application/json" -H "Access-Control-Allow-Origin: true" -H "Origin: https://convert.canto.io" -H "Connection: keep-alive" -H "Sec-Fetch-Dest: empty" -H "Sec-Fetch-Mode: cors" -H "Sec-Fetch-Site: cross-site" -H "TE: trailers" --data-raw "{\"cantoAddress\":\"$getMint\"}")
	if [[ "$gas" =~ "Send" ]]; then
   echo -e "${3} => $1 - Mencoba mint"
   getStatus=$(curl -s "https://mainnode.plexnode.org:1317/cosmos/auth/v1beta1/accounts/$getMint" | jq -r '.message')
    if [[ "$getStatus" =~ "error" ]]; then
      echo -e "=> $1 - $getStatus"
      echo -e "$1" >> gagal2.txt
    else
      echo -e "=> $1 - Sukses mint"
    fi
  else
   echo -e "$1 - Gagal"
  fi

    
}
printf "${white}[+] Input File berisi Address : "; read LIST 
if [[ ! -f $LIST ]]; then
    echo "[-] File $LIST Not Exist" 
    exit 1
fi

totallines=$(wc -l < ${LIST});
itung=1
index=$((pp++))
printf " '-> Total MAILPASS On List :${white} ${bgreen} $(grep "" -c $LIST) ${cbg}\n"
printf "${white}[+] Threads          : "; read THREADS
printf "${white} '-> Set Threads To ${bgreen} $THREADS ${cbg}\n"
pp=1
IFS=$'\r\n' GLOBIGNORE='*' command eval 'mailist=($(cat $LIST))'
for (( i = 0; i < ${#mailist[@]}; i++ )); do
  index=$((itung++))
    username="${mailist[$i]}"
    IFS=' ' read -r -a array <<< "$username"
    email=${array[0]}
    password=${array[1]}
   tt=$(expr $pp % $THREADS)
   if [[ $tt == 0 && $pp > 0 ]]; then
   sleep 5
   fi
   let pp++
   jam=$(date '+%H')
   menit=$(date '+%M')
   detik=$(date '+%S')
   

	register "${email}" "${password}" "${index}" &
	
	
done
wait



