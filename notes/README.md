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
