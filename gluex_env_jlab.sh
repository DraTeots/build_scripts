#!/bin/bash
if [ -z $1 ]
    then
    VERSION_XML=/group/halld/www/halldweb/html/dist/version_jlab.xml
else
    VERSION_XML=$1
fi
export BUILD_SCRIPTS=/group/halld/Software/build_scripts
export BMS_OSNAME=`$BUILD_SCRIPTS/osrelease.pl`
# farm-specific set-up
nodename=`uname -n`
if [[ $nodename =~ ^farm* || $nodename =~ ^ifarm* || $nodename =~ ^qcd* || $nodename =~ ^gluon* ]]
    then
    export http_proxy=http://jprox.jlab.org:8081
    export https_proxy=https://jprox.jlab.org:8081
fi
if [[ $BMS_OSNAME == *CentOS6* || $BMS_OSNAME == *RHEL6* ]]
    then
    GCC_HOME=/apps/gcc/4.9.2
    export PATH=${GCC_HOME}/bin:${PATH}
    export LD_LIBRARY_PATH=${GCC_HOME}/lib64:${GCC_HOME}/lib
    export BMS_OSNAME=`$BUILD_SCRIPTS/osrelease.pl`
fi
export GLUEX_TOP=/group/halld/Software/builds/$BMS_OSNAME
# perl on the cue
export PATH=/apps/perl/bin:$PATH
# finish the rest of the environment
. $BUILD_SCRIPTS/gluex_env_version.sh $VERSION_XML
export JANA_CALIB_URL=$CCDB_CONNECTION
export JANA_RESOURCE_DIR=/group/halld/www/halldweb/html/resources
# python on the cue
export PATH=/apps/python/PRO/bin:$PATH
export LD_LIBRARY_PATH=/apps/python/PRO/lib:$LD_LIBRARY_PATH
