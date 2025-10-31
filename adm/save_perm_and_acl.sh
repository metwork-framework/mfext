#!/bin/bash

#Shell to save permissions and acl in order to automatically restore them at install
cd "${HOME}"
#File to keep permissions of /home/${MFMODULE_LOWERCASE} to be able to restore it
echo 'INFO: saving /home/"${MFMODULE_LOWERCASE}" permissions'
touch .home_"${MFMODULE_LOWERCASE}".perm
chmod --reference=/home/"${MFMODULE_LOWERCASE}" .home_"${MFMODULE_LOWERCASE}".perm
chown --reference=/home/"${MFMODULE_LOWERCASE}" .home_"${MFMODULE_LOWERCASE}".perm
#Files to keep ACLs on /home/${MFMODULE_LOWERCASE} to be able to restore them
if [ "${MFMODULE}" == "MFDATA" ]; then
    echo 'INFO: saving ACLs on /home/"${MFMODULE_LOWERCASE}"'
    getfacl . > .home_"${MFMODULE_LOWERCASE}".acl
    cd var && getfacl . > "${HOME}"/.home_"${MFMODULE_LOWERCASE}"_var.acl
    cd in && getfacl . > "${HOME}"/.home_"${MFMODULE_LOWERCASE}"_var_in.acl
    if [ -d incoming ]; then
        cd incoming && getfacl . > "${HOME}"/.home_"${MFMODULE_LOWERCASE}"_var_in_incoming.acl
    fi
fi
