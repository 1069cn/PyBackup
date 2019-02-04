#!/usr/bin/env bash
#apt-get update
#apt-get install p7zip-full
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[��Ϣ]${Font_color_suffix}"
Error="${Red_font_prefix}[����]${Font_color_suffix}"
Tip="${Green_font_prefix}[ע��]${Font_color_suffix}"

check_sys(){
	if [[ -f /etc/redhat-release ]]; then
		release="centos"
	elif cat /etc/issue | grep -q -E -i "debian"; then
		release="debian"
	elif cat /etc/issue | grep -q -E -i "ubuntu"; then
		release="ubuntu"
	elif cat /etc/issue | grep -q -E -i "centos|red hat|redhat"; then
		release="centos"
	elif cat /proc/version | grep -q -E -i "debian"; then
		release="debian"
	elif cat /proc/version | grep -q -E -i "ubuntu"; then
		release="ubuntu"
	elif cat /proc/version | grep -q -E -i "centos|red hat|redhat"; then
		release="centos"
    fi
	bit=`uname -m`
}
Check_python(){
	python_ver=`python3 -h`
	if [[ -z ${python_ver} ]]; then
		echo -e "${Info} û�а�װPython3����ʼ��װ..."
		if [[ ${release} == "centos" ]]; then
			yum install -y python3
			yum install python3-pip
			pip3 install --upgrade pip
			pip3 install oss2 cos-python-sdk-v5

		else
			apt-get install -y python3
			apt-get install python3-pip
			pip3 install --upgrade pip
			pip3 install oss2 cos-python-sdk-v5
		fi
	fi
}
Centos_yum()
{
	yum update
	yum install -y p7zip-full unzip
}
Debian_apt()
{
	apt-get update
	apt-get install -y p7zip-full unzip
}
Download_backup_code()
{
	cd "/usr/local/"
	wget -N --no-check-certificate "https://github.comXXXXXXXXXX/archive/AutoBackup.zip"
	unzip AutoBackup.zip
	rm -rf AutoBackup.zip
}
Start()
{
	check_sys
	[[ ${release} != "debian" ]] && [[ ${release} != "ubuntu" ]] && [[ ${release} != "centos" ]] && echo -e "${Error} ���ű���֧�ֵ�ǰϵͳ ${release} !" && exit 1
	if [[ ${release} == "centos" ]]; then
		Centos_yum
	else
		Debian_apt
	Check_python
	Download_backup_code
}

Start