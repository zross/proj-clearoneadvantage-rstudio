# ClearOne AWS Notes

| Connection Info |                               |
|:----------------|:------------------------------|
| Host            | arsenic.clearoneadvantage.com |
| Username        | ubuntu                        |
| PEM             | _contact zev_                 |

## Initial steps

1. Download .pem file
1. Modify .pem file permissions
   `chmod 600 <PATH/TO/PEM>`
1. Connect to the ClearOne AWS server
   `ssh -i <PATH/TO/PEM> ubuntu@arsenic.clearoneadvantage.com`
1. Double check server OS. When I checked this was _Ubuntu 18.04.4 LTS_.

## Server steps

> At this point you need to be connected to the AWS server, the following
> commands are run on the server.

### Installing R

1. Check R version (shouldn't be installed at this point)
   `R --version`
1. Update apt sources
   Add the following line to `/etc/apt/sources.list`,
   `deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran40/`
1. Add key for new source
   `sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9`
1. Update apt packages
   `sudo apt update`
1. Install r-base
   `sudo apt install r-base`
1. Check R version (again), the version should be >= 4.0.0
   `R --version`

### Installing RStudio Server

1. Install gdebi
   `sudo apt install gdebi-core`
1. Retrieve rstudio server .deb file (see https://rstudio.com/products/rstudio/download-server/debian-ubuntu/ for latest version)
   `wget https://download2.rstudio.org/server/bionic/x86_64/rstudio-server-1.3.1073-amd64.deb`
   > Make sure to get the download link for the correct OS. Using the wrong link causes a lot of headache.
1. Sanity check `ls` and verify there is an rstudio-server-*.deb file in the current folder.
1. Install RStudio Server from .deb file
   `sudo gdebi rstudio-server-1.3.1073-amd64.deb`
1. Change default port from 8787 to 80, add the following to `/etc/rstudio/rserver.conf`,
   ```
   # Port
   www-port=80
   ```

### Installing Libraries and Drivers

1. Install curl, ssl, and xml libraries
   `sudo apt install libcurl4-openssl-dev libssl-dev libxml2-dev`
1. Install Java and rJava
   `sudo apt install default-jdk`

   Configure `JAVA_HOME` system variable
   Look up the folder path,
   `sudo update-alternatives --config java`
   Add this path to `/etc/environment` as `JAVA_HOME="<PATH/TO/JAVA/HOME>"`

   Install `r-cran-rjava`
   ```
   sudo add-apt-repository ppa:c2d4u.team/c2d4u4.0+
   sudo apt update
   sudo apt install r-cran-rjava
   ```
   > Double check the installation of rJava by dropping into an R shell
1. Install ODBC related libraries
   `sudo apt install unixodbc unixodbc-dev`
1. Install Microsoft SQL libraries
   ```
   sudo su
   curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
   curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
   exit

   sudo apt update
   sudo ACCEPT_EULA=Y apt-get install msodbcsql17
   sudo ACCEPT_EULA=Y apt-get install mssql-tools
   ```
1. Install FreeTDS
   ```
   wget ftp://ftp.freetds.org/pub/freetds/stable/freetds-1.2.tar.gz
   tar -xzf freetds-1.2.tar.gz
   cd freetds-1.2/
   ./configure --prefix=/usr/local --with-tdsver=7.3
   sudo make
   sudo make install
   ```


### Adding Users

1. Create user group (if not already created)
   `sudo groupadd <USER_GROUP>`
1. Create user
   `sudo useradd -m -d /home/<USER_NAME> -G <USER_GROUP> <USER_NAME>`
   > If `<USER_NAME>` includes characters such as "-" the username must be in quotes, i.e. `"r-jwu"`
1. Set password for user
   `sudo passwd <USER_NAME>`
1. Configure user (for this I created a script), which will setup their personal R library and default R environment
   `./bin/config.sh <USER_NAME>`
   > Remember to put the username in quotes if the username includes characters like "-"
