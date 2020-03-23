sudo wget https://images.rdoproject.org/pike/delorean/current-tripleo-rdo/overcloud-full.tar --no-check-certificate
sudo wget https://images.rdoproject.org/pike/delorean/current-tripleo-rdo/ironic-python-agent.tar --no-check-certificate
mkdir ~/images
tar -xpvf ironic-python-agent.tar -C ~/images/
tar -xpvf overcloud-full.tar -C ~/images/
. stackrc #preparation part ends here
openstack overcloud image upload --image-path ~/images/
neutron subnet-update  ctlplane-subnet --dns-nameserver 8.8.8.8
openstack overcloud node import --introspect --provide instackenv.json
openstack baremetal node set --property capabilities='profile:compute,boot_option:local' compute1-bravo
#openstack baremetal node set --property capabilities='profile:compute,boot_option:local' compute2-hotel
openstack baremetal node set --property capabilities='profile:control,boot_option:local' controller1-charlie
git clone https://github.com/hiraetari/heat-templates.git
openstack overcloud deploy --templates /heat-templates
