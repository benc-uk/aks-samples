#
# COPY AND RENAME ME! to vars.sh
#

# Change these
resGrp=""
location=""
clusterName=""
logWorkspaceName="" # MUST BE UNIQUE!
kubeVersion="1.14.7"

# Maybe change these
vmSize="Standard_D2s_v3"
minNodes="2"
maxNodes="5"

vnetName="aks-vnet"
subnetName="aks-subnet"
vnodesSubnetName="vnodes-subnet"

winAdminUser="winadmin"
winAdminPwd="Ch@ngeMe!2^secret"