#!/usr/bin/env bash
#apt-get update
#apt-get install p7zip-full
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
export LANG=UTF-8
export LANGUAGE=UTF-8

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
	python_ver=`python3 -h`
	if [[ -z ${python_ver} ]]; then
		echo -e "${Error} ��װPython3ʧ�ܣ����Ա��밲װ..."
		wget -N --no-check-certificate https://www.python.org/ftp/python/3.6.3/Python-3.6.3.tgz && tar zxvf Python-3.6.3.tgz && cd Python-3.6.3
		./configure --prefix=/opt/Python
		make && make install
		ln -s /opt/Python/bin/python3 /usr/bin/python3
	else
		echo -e "${Info} ��װPython3�ɹ�..."
	fi
	pip = 'pip3'
	if [[ -z ${pip} ]]; then
		echo -e "${Error} ��װPip3ʧ�ܣ����Ա��밲װ..."
		wget --no-check-certificate  https://pypi.python.org/packages/source/s/setuptools/setuptools-19.6.tar.gz#md5=c607dd118eae682c44ed146367a17e26
		tar -zxvf setuptools-19.6.tar.gz
		cd setuptools-19.6.tar.gz
		python3 setup.py build
		python3 setup.py install
		wget --no-check-certificate  https://pypi.python.org/packages/source/p/pip/pip-8.0.2.tar.gz#md5=3a73c4188f8dbad6a1e6f6d44d117eeb
		tar -zxvf pip-8.0.2.tar.gz
		cd pip-8.0.2
		python3 setup.py build
		python3 setup.py install
	else
		echo -e "${Info} ��װPip3�ɹ�..."
	fi
	pip = 'pip3'
	python_ver=`python3 -h`
	if [[ -z ${python_ver} ]]; then
		echo -e "${Error} ��װPython3ʧ�ܣ����Ա��밲װ..."
	if [[ -z ${pip} ]]; then
		echo -e "${Error} ��װPip3ʧ��..."
	#��װ����
	if [[ ${release} == "centos" ]]; then
			yum install python3-pip
			pip3 install --upgrade pip
			pip3 install oss2 cos-python-sdk-v5

		else
			apt-get install python3-pip
			pip3 install --upgrade pip
			pip3 install oss2 cos-python-sdk-v5
	fi
}
Centos_yum()
{
	rm -rf /var/lib/apt/lists/*
	rm -rf /var/lib/apt/lists/partial/*
	yum -y update
	yum install -y p7zip-full unzip
}
Debian_apt()
{
    rm -rf /var/lib/apt/lists/*
	rm -rf /var/lib/apt/lists/partial/*
	apt-get -y update
	apt-get install -y p7zip-full unzip
}
Download_backup_code()
{
	wget -N --no-check-certificate "https://github.com/LoneKingCode/PyBackup/archive/1.0.zip" -O PyBackup.zip
	unzip PyBackup.zip
	rm -rf PyBackup.zip
}
Start()
{
	check_sys
	[[ ${release} != "debian" ]] && [[ ${release} != "ubuntu" ]] && [[ ${release} != "centos" ]] && echo -e "${Error} ���ű���֧�ֵ�ǰϵͳ ${release} !" && exit 1
	if [[ ${release} == "centos" ]]; then
		Centos_yum
	else
		Debian_apt
	fi
	Check_python
	Download_backup_code
	echo -e "${Info} ִ�н����������ڽű�ִ��Ŀ¼..."
}

Start