apt-get install software-properties-common
apt-get update
apt-get remove --purge libreoffice*
add-apt-repository ppa:libreoffice/libreoffice-prereleases
apt-get update && apt-get -y install libreoffice
