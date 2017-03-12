# Bootstrap salt
curl -L https://bootstrap.saltstack.com -o bootstrap_salt.sh
sudo sh bootstrap_salt.sh

# tell minion to use local files for config
 sed -i '/#file_client: remote/c\file_client: local' /etc/salt/minion

# apply salt state
salt-call --local state.apply -l debug