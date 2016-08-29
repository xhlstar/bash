cp /mnt/libnl.* /usr/lib
mkdir -p /tmp/dhcpv6
cd /tmp/dhcpv6/
touch dhcp6c.pid
mkdir -p /usr/local/bin
cp /mnt/wide_mkduid.pl /usr/bin
chmod 755 wide_mkduid.pl
wide_mkduid.pl -m `ifconfig eth0.4095 |grep HWaddr |awk '{print $5}'`
