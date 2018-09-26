#!/bin/bash
# OpenShift non namespaced objects:
# oc get --raw /oapi/v1/ |  python -c 'import json,sys ; resources = "\n".join([o["name"] for o in json.load(sys.stdin)["resources"] if not o["namespaced"] and "create" in o["verbs"] and "delete" in o["verbs"] ]) ; print resources'
# Kubernetes non namespaced objects:
# oc get --raw /api/v1/ |  python -c 'import json,sys ; resources = "\n".join([o["name"] for o in json.load(sys.stdin)["resources"] if not o["namespaced"] and "create" in o["verbs"] and "delete" in o["verbs"] ]) ; print resources'

set -eo pipefail

die(){
  echo "$1"
  exit $2
}

usage(){
  echo "$0 <projectname>"
  echo "  projectname  The OCP project to be exported"
  echo "Examples:"
  echo "    $0 myproject"
}

exportlist(){
  if [ "$#" -lt "3" ]; then
    echo "Invalid parameters"
    return
  fi

  KIND=$1
  BASENAME=$2
  DELETEPARAM=$3

  echo "Exporting '${KIND}' resources to global/${BASENAME}.json"

  BUFFER=$(oc get ${KIND} --export -o json || true)

  # return if resource type unknown or access denied
  if [ -z "${BUFFER}" ]; then
    echo "Skipped: no data"
    return
  fi

  # return if list empty
  if [ "$(echo ${BUFFER} | jq '.items | length > 0')" == "false" ]; then
    echo "Skipped: list empty"
    return
  fi

  echo ${BUFFER} | jq ${DELETEPARAM} > global/${BASENAME}.json
}

namespaces(){
  exportlist \
    namespaces \
    namespaces \
    'del('\
'.items[].metadata.uid,'\
'.items[].metadata.selfLink,'\
'.items[].metadata.resourceVersion,'\
'.items[].metadata.creationTimestamp,'\
'.items[].metadata.namespace,'\
'.items[].status)'
}

nodes(){
  exportlist \
    nodes \
    nodes \
    'del('\
'.items[].metadata.uid,'\
'.items[].metadata.selfLink,'\
'.items[].metadata.resourceVersion,'\
'.items[].metadata.creationTimestamp,'\
'.items[].metadata.namespace,'\
'.items[].status)'
}

persistentvolumes(){
  exportlist \
    persistentvolumes \
    persistentvolumes \
    'del('\
'.items[].metadata.uid,'\
'.items[].metadata.selfLink,'\
'.items[].metadata.resourceVersion,'\
'.items[].metadata.creationTimestamp,'\
'.items[].metadata.namespace,'\
'.items[].status)'
}

securitycontextconstraints(){
  exportlist \
    securitycontextconstraints \
    securitycontextconstraints \
    'del('\
'.items[].metadata.uid,'\
'.items[].metadata.selfLink,'\
'.items[].metadata.resourceVersion,'\
'.items[].metadata.creationTimestamp,'\
'.items[].metadata.namespace)'
}

clusternetworks(){
  exportlist \
    clusternetworks \
    clusternetworks \
    'del('\
'.items[].metadata.uid,'\
'.items[].metadata.selfLink,'\
'.items[].metadata.resourceVersion,'\
'.items[].metadata.creationTimestamp,'\
'.items[].metadata.namespace)'
}

clusterresourcequotas(){
  exportlist \
    clusterresourcequotas \
    clusterresourcequotas \
    'del('\
'.items[].metadata.uid,'\
'.items[].metadata.selfLink,'\
'.items[].metadata.resourceVersion,'\
'.items[].metadata.creationTimestamp,'\
'.items[].metadata.namespace)'
}

clusterrolebindings(){
  exportlist \
    clusterrolebindings \
    clusterrolebindings \
    'del('\
'.items[].metadata.uid,'\
'.items[].metadata.selfLink,'\
'.items[].metadata.resourceVersion,'\
'.items[].metadata.creationTimestamp,'\
'.items[].metadata.namespace)'
}

clusterroles(){
  exportlist \
    clusterroles \
    clusterroles \
    'del('\
'.items[].metadata.uid,'\
'.items[].metadata.selfLink,'\
'.items[].metadata.resourceVersion,'\
'.items[].metadata.creationTimestamp,'\
'.items[].metadata.namespace)'
}

groups(){
  exportlist \
    groups \
    groups \
    'del('\
'.items[].metadata.uid,'\
'.items[].metadata.selfLink,'\
'.items[].metadata.resourceVersion,'\
'.items[].metadata.creationTimestamp,'\
'.items[].metadata.namespace)'
}

hostsubnets(){
  exportlist \
    hostsubnets \
    hostsubnets \
    'del('\
'.items[].metadata.uid,'\
'.items[].metadata.selfLink,'\
'.items[].metadata.resourceVersion,'\
'.items[].metadata.creationTimestamp,'\
'.items[].metadata.namespace)'
}

identities(){
  exportlist \
    identities \
    identities \
    'del('\
'.items[].metadata.uid,'\
'.items[].metadata.selfLink,'\
'.items[].metadata.resourceVersion,'\
'.items[].metadata.creationTimestamp,'\
'.items[].metadata.namespace)'
}

images(){
  exportlist \
    images \
    images \
    'del('\
'.items[].metadata.uid,'\
'.items[].metadata.selfLink,'\
'.items[].metadata.resourceVersion,'\
'.items[].metadata.creationTimestamp,'\
'.items[].metadata.namespace)'
}

imagesignatures(){
  exportlist \
    imagesignatures \
    imagesignatures \
    'del('\
'.items[].metadata.uid,'\
'.items[].metadata.selfLink,'\
'.items[].metadata.resourceVersion,'\
'.items[].metadata.creationTimestamp,'\
'.items[].metadata.namespace)'
}

netnamespaces(){
  exportlist \
    netnamespaces \
    netnamespaces \
    'del('\
'.items[].metadata.uid,'\
'.items[].metadata.selfLink,'\
'.items[].metadata.resourceVersion,'\
'.items[].metadata.creationTimestamp,'\
'.items[].metadata.namespace)'
}

oauthaccesstokens(){
  exportlist \
    oauthaccesstokens \
    oauthaccesstokens \
    'del('\
'.items[].metadata.uid,'\
'.items[].metadata.selfLink,'\
'.items[].metadata.resourceVersion,'\
'.items[].metadata.creationTimestamp,'\
'.items[].metadata.namespace)'
}

oauthauthorizetokens(){
  exportlist \
    oauthauthorizetokens \
    oauthauthorizetokens \
    'del('\
'.items[].metadata.uid,'\
'.items[].metadata.selfLink,'\
'.items[].metadata.resourceVersion,'\
'.items[].metadata.creationTimestamp,'\
'.items[].metadata.namespace)'
}

oauthclientauthorizations(){
  exportlist \
    oauthclientauthorizations \
    oauthclientauthorizations \
    'del('\
'.items[].metadata.uid,'\
'.items[].metadata.selfLink,'\
'.items[].metadata.resourceVersion,'\
'.items[].metadata.creationTimestamp,'\
'.items[].metadata.namespace)'
}

oauthclients(){
  exportlist \
    oauthclients \
    oauthclients \
    'del('\
'.items[].metadata.uid,'\
'.items[].metadata.selfLink,'\
'.items[].metadata.resourceVersion,'\
'.items[].metadata.creationTimestamp,'\
'.items[].metadata.namespace)'
}

projects(){
  exportlist \
    projects \
    projects \
    'del('\
'.items[].metadata.uid,'\
'.items[].metadata.selfLink,'\
'.items[].metadata.resourceVersion,'\
'.items[].metadata.creationTimestamp,'\
'.items[].metadata.namespace,'\
'.items[].status)'
}

useridentitymappings(){
  exportlist \
    useridentitymappings \
    useridentitymappings \
    'del('\
'.items[].metadata.uid,'\
'.items[].metadata.selfLink,'\
'.items[].metadata.resourceVersion,'\
'.items[].metadata.creationTimestamp,'\
'.items[].metadata.namespace)'
}

users(){
  exportlist \
    users \
    users \
    'del('\
'.items[].metadata.uid,'\
'.items[].metadata.selfLink,'\
'.items[].metadata.resourceVersion,'\
'.items[].metadata.creationTimestamp,'\
'.items[].metadata.namespace)'
}

if [[ ( $@ == "--help") ||  $@ == "-h" ]]
then
  usage
  exit 0
fi

for i in jq oc
do
  command -v $i >/dev/null 2>&1 || die "$i required but not found" 3
done

mkdir -p global

clusternetworks
clusterresourcequotas
clusterrolebindings
clusterroles
groups
hostsubnets
identities
images
imagesignatures
netnamespaces
oauthaccesstokens
oauthauthorizetokens
oauthclientauthorizations
oauthclients
projects
useridentitymappings
users
namespaces
nodes
persistentvolumes
securitycontextconstraints

exit 0
