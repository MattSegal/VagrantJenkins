# # Get Jenkins repo
wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

apt-get update
apt-get upgrade

apt-get install git -y
apt-get install htop -y

# # Jenkins
apt-get install jenkins -y
mkdir /var/build # folder for caching
chown jenkins: /var/build
chown jenkins: /root/.ssh/authorized_keys
ln -s /var/lib/jenkins /jenkins # symlink jenkins folder

# N.B custom Jenkins plugins
  # - SSH Agent Plugin  

# Javascript build tools
apt-get install nodejs -y
ln -s `which nodejs` /usr/bin/node # node symlink
apt-get install npm -y 
npm install -g npm
sudo npm install -g n
sudo n stable
npm install -g webpack

