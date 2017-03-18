# Setup ssh keys
ssh-keygen -t rsa -b 4096 -C "root@salt" -N ''
eval "$(ssh-agent)"
ssh-add

# copy all this shit to /var/lib/jenkins/.ssh/
# give permissions to jenins
# gotta copy known_hosts and id_rsa
# fuck you jenkins you're a bag of shit

# Client side debugging
# ssh -v root@192.168.2.3

# Server side debugging
# /etc/init.d/ssh stop
# /usr/sbin/sshd -d

# web box
# Subsystem sftp internal-sftp
# nano /etc/ssh/sshd_config

# Install Salt master
curl -L https://bootstrap.saltstack.com -o install_salt.sh
sudo sh install_salt.sh -P -M

# Get Jenkins repo
wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

apt-get update
apt-get upgrade

apt-get install git -y
apt-get install htop -y

# Install Jenkins
apt-get install jenkins -y
mkdir /var/build # folder for caching
chown jenkins: /var/build
chown jenkins: /root/.ssh/authorized_keys
ln -s /var/lib/jenkins /jenkins # symlink jenkins folder

# N.B custom Jenkins plugins
# - SSH Agent Plugin  

# Allow jenkins to sudo salt, ssh, sftp
sed -i '/jenkins/d' /etc/sudoers
echo 'jenkins ALL = NOPASSWD: /usr/bin/salt, /usr/bin/ssh, /usr/bin/sftp' >> /etc/sudoers

cat ~/.ssh/id_rsa | python /srv/provision/set_credentials.py > /var/lib/jenkins/credentials.xml
service jenkins restart

# Javascript build tools
apt-get install nodejs -y
ln -s `which nodejs` /usr/bin/node # node symlink
apt-get install npm -y 
npm install -g npm
sudo npm install -g n
sudo n stable
npm install -g webpack

