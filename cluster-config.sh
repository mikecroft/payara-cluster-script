#!/bin/bash - 
#===============================================================================
#
#          FILE: config-cluster.sh
# 
#         USAGE: ./config-cluster.sh 
# 
#   DESCRIPTION: Really basic script to create config cluster
# 
#        AUTHOR: Mike Croft 
#  ORGANIZATION: Payara
#       CREATED: 19/10/15 08:14
#===============================================================================

set -o nounset                              # Treat unset variables as an error

$NODE1=
$DAS=

cat << EOF > pfile
AS_ADMIN_PASSWORD=admin
EOF



$ASADMIN --user admin --passwordfile=pfile --port 4848 create-cluster cluster
$ASADMIN --user admin --passwordfile=pfile --port 4848 create-node-config --nodehost $NODE1 node1
$ASADMIN --user admin --passwordfile=pfile --port 4848 create-local-instance --cluster cluster instance0
$ASADMIN --user admin --passwordfile=pfile --port 4848 start-local-instance --sync  full instance0



# Run on node1
$ASADMIN --user admin --passwordfile=pfile --port 4848 --host $DAS create-local-instance --node node1 --cluster cluster instance1
$ASADMIN --user admin --passwordfile=pfile --port 4848 --host $DAS start-local-instance --sync  full instance1

