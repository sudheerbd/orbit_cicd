add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu xenial-cran35/'
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
apt update
apt install -y  r-base
apt-get -y install libcurl4-openssl-dev
echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile
Rscript -e "install.packages('openxlsx')"
Rscript -e "install.packages('ggplot2')"
