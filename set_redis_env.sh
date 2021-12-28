# for old Linux core < 5.4
sudo sysctl -w net.core.somaxconn=65535
sudo sysctl vm.overcommit_memory=1