#!/bin/bash

#
# Used to configure new users on the ClearOne server
#

USER="$1"
USER_HOME="/home/$USER"
USER_R="$USER_HOME/R"
USER_R_LIB="$USER_R/library"

if [[ ! -d $USER_R ]]; then
    mkdir $USER_R
    chown $USER:$USER $USER_R
fi

if [[ ! -d $USER_R_LIB ]]; then
    mkdir $USER_R_LIB
    chown $USER:$USER $USER_R_LIB
fi

USER_RENV="$USER_HOME/.Renviron"
if [[ -f $USER_RENV ]]; then
    echo "Moving existing .Renviron to .Renviron.old"
    mv $USER_RENV "$USER_HOME/.Renviron.old"
else
    touch $USER_RENV
    chown $USER:$USER $USER_RENV
fi

cat <<EOF > $USER_RENV
# R user library
R_LIBS=$USER_R_LIB
EOF
