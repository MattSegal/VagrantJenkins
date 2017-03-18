# Install Salt minion
curl -L https://bootstrap.saltstack.com -o install_salt.sh
sudo sh install_salt.sh
# service salt-minion status

# Add salt master to hosts file
sed -i '/salt/d' /etc/hosts
echo '192.168.2.2 salt' >> /etc/hosts

apt-get install htop -y
