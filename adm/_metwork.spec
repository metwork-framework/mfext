###################################
##### COMPUTE MODULE SUFFIXES #####
###################################
{% if '.ci' in MFEXT_VERSION %}
    {# Example: integration.ci392.87ed9bd or release_0.7.ci392.87ed9bd #}
    {# This is a little bit complexe because we can have dots in branch name #}
    {% set MFEXT_BRANCH = MFEXT_VERSION.split('.')[0:-2]|join('.') %}
{% else %}
    {# Example: 0.7.5 #}
    {% set MFEXT_BRANCH = MFEXT_VERSION.split('.')[0:2]|join('.') %}
{% endif %}
{% if '.ci' in MFMODULE_VERSION %}
    {% set MODULE_BRANCH = MFMODULE_VERSION.split('.')[0:-2]|join('.') %}
{% else %}
    {% set MODULE_BRANCH = MFMODULE_VERSION.split('.')[0:2]|join('.') %}
{% endif %}
# DEBUG: MFEXT_BRANCH: {{MFEXT_BRANCH}}
# DEBUG: MODULE_BRANCH: {{MODULE_BRANCH}}


##############################
##### SET MISC VARIABLES #####
##############################
{% if MFEXT_ADDON is not defined %}
    {% set MFEXT_ADDON = "0" %}
{% endif %}
{% set RELEASE_BUILD_SUFFIX = "" %}
{% if METWORK_BUILD_OS is defined %}
    {% if METWORK_BUILD_OS == "centos6" %}
        {% set RELEASE_BUILD_SUFFIX = ".el6" %}
    {% elif METWORK_BUILD_OS == "centos7" %}
        {% set RELEASE_BUILD_SUFFIX = ".el7" %}
    {% elif METWORK_BUILD_OS == "centos8" %}
        {% set RELEASE_BUILD_SUFFIX = ".el8" %}
    {% elif METWORK_BUILD_OS == "generic" %}
        {% set RELEASE_BUILD_SUFFIX = ".gen" %}
    {% endif %}
{% endif %}
{% set version_release = [VERSION_BUILD, RELEASE_BUILD + RELEASE_BUILD_SUFFIX] %}
{% set version_release_string = version_release|join('-') %}
{% set epoch_vr = ["10", version_release_string] %}
{% set FULL_VERSION = epoch_vr|join(':') %}
{% set _TARGET_LINK = MFMODULE_HOME + "/../metwork-" + MFMODULE_LOWERCASE %}
{% set _TARGET_LINK_COMMAND = "readlink -m " + _TARGET_LINK %}
{% set TARGET_LINK = _TARGET_LINK_COMMAND|shell %}
# DEBUG: MFEXT_ADDON: {{MFEXT_ADDON}}
# DEBUG: MFEXT_ADDON_NAME: {{MFEXT_ADDON_NAME|default('')}}
# DEBUG: FULL_VERSION: {{FULL_VERSION}}
# DEBUG: TARGET_LINK: {{TARGET_LINK}}


############################################
##### COMPUTE LAYERS AND DEPENDENCIES ######
############################################
{% if MFEXT_ADDON == "1" %}
    #  DEBUG: layers_command: {{"_packaging_get_module_layers " + MFEXT_ADDON_NAME}}
    {% set layers = ("_packaging_get_module_layers " + MFEXT_ADDON_NAME)|shell|from_json %}
{% else %}
    #  DEBUG: layers_command: _packaging_get_module_layers
    {% set layers = "_packaging_get_module_layers"|shell|from_json %}
    # DEBUG: dependencies_command: {{ "_packaging_get_module_dependencies " + MODULE_BRANCH + " " + MFEXT_BRANCH }}
    {% set dependencies = ("_packaging_get_module_dependencies " + MODULE_BRANCH + " " + MFEXT_BRANCH)|shell|from_json %}
{% endif %}
{% set minimal_layers = [] %}
{% set minimal_system_dependencies = [] %}


########################
##### MAIN PACKAGE #####
########################
# Note: it will be deleted for addons (in the calling Makefile)
# content: symbolic link + home directory  + everything that is not in {{MFMODULE_HOME}}
%define __jar_repack %{nil}
%define __os_install_post %{nil}
%define debug_package %{nil}
%define _build_id_links none
Name: metwork-{{MFMODULE_LOWERCASE}}
{% if MFMODULE_LOWERCASE == "mfext" %}
Summary: metwork {{MFMODULE_LOWERCASE}} symbolic link
{% else %}
Summary: metwork {{MFMODULE_LOWERCASE}} symbolic link and stuff around the {{MFMODULE_LOWERCASE}} unix user
{% endif %}
Version: {{VERSION_BUILD}}
Release: {{RELEASE_BUILD}}{{RELEASE_BUILD_SUFFIX}}
Epoch: 10
License: Meteo
Source0: {{MFMODULE_LOWERCASE}}-{{VERSION_BUILD}}-{{RELEASE_BUILD}}-linux64.tar
Group: Applications/Multimedia
URL: http://metwork.meteo.fr
Buildroot: %{_topdir}/tmp/%{name}-root
Packager: Fabien MARTY <fabien.marty@meteo.fr>
Vendor: Metwork
ExclusiveOs: linux
AutoReqProv: no
Requires: metwork-{{MFMODULE_LOWERCASE}}-{{MODULE_BRANCH}} = {{FULL_VERSION}}
Provides: metwork-{{MFMODULE_LOWERCASE}}-minimal = {{FULL_VERSION}}
Obsoletes: metwork-{{MFMODULE_LOWERCASE}}-minimal < {{FULL_VERSION}}
{% if MFMODULE_LOWERCASE == "mfext" %}
%description
This package provides the {{TARGET_LINK}} symbolic link
{% else %}
%description
This package provides the {{TARGET_LINK}} symbolic link
and the stuff around the {{MFMODULE_LOWERCASE}} unix user.
{% endif %}


{% if MFEXT_ADDON == "0" %}
#################################
##### SUFFIXED MAIN PACKAGE #####
#################################
# Content: everything in {{MFMODULE_HOME}} and all minimal layers
%package {{MODULE_BRANCH}}
%define _build_id_links none
Summary: metwork {{MFMODULE_LOWERCASE}} minimal module (default layer)
Group: Applications/Multimedia
AutoReqProv: no
# <to be removed someday>
Obsoletes: metwork-{{MFMODULE_LOWERCASE}}-core-{{MODULE_BRANCH}}
Obsoletes: metwork-{{MFMODULE_LOWERCASE}}-layer-python-{{MODULE_BRANCH}}
{% if MFMODULE == "MFADMIN" %}
Obsoletes: metwork-mfadmin-layer-monitoring-{{MODULE_BRANCH}}
Obsoletes: metwork-mfadmin-layer-python3-{{MODULE_BRANCH}}
{% elif MFMODULE == "MFEXT" %}
Obsoletes: metwork-mfext-layer-tcltk-{{MODULE_BRANCH}}
Obsoletes: metwork-mfext-scientific-{{MODULE_BRANCH}}
Obsoletes: metwork-mfext-scientific
Obsoletes: metwork-mfext-devtools-{{MODULE_BRANCH}}
Obsoletes: metwork-mfext-devtools
{% endif %}
# </to be removed someday>
Provides: metwork-{{MFMODULE_LOWERCASE}}-minimal-{{MODULE_BRANCH}} = {{FULL_VERSION}}
Obsoletes: metwork-{{MFMODULE_LOWERCASE}}-minimal-{{MODULE_BRANCH}} < {{FULL_VERSION}}
{% for DEP in dependencies %}
    {% if DEP.type == "metwork" %}
        {# metwork layer dependencies #}
        {% if DEP.module == MFMODULE_LOWERCASE %}
            {# Because this dependency will be embedded in this package #}
            {{ minimal_layers.append(DEP.label)|replace('None', '') }}
Provides: {{DEP.rpm}} = {{FULL_VERSION}}
Obsoletes: {{DEP.rpm}} < {{FULL_VERSION}}
        {% else %}
            {# Because this is a dependency on another module #}
Requires: {{DEP.rpm}}
        {% endif %}
    {% else %}
        {# system dependencies #}
        {% if METWORK_BUILD_OS|default('unknown') in DEP.oss or "all" in DEP.oss %}
Requires: {{DEP.name}}
            {{ minimal_system_dependencies.append(DEP.name)|replace('None', '') }}
        {% endif %}
    {% endif %}
{% endfor %}
%description {{MODULE_BRANCH}}
This package contains minimal (readonly) files and directories for {{MFMODULE_LOWERCASE}} module.
Everything is in {{MFMODULE_HOME}}/
{% endif %}

{% if MFEXT_ADDON == "0" %}
########################
##### FULL PACKAGE #####
########################
# Content: everything in {{MFMODULE_HOME}} and all available layers
%package full
%define _build_id_links none
Summary: metwork {{MFMODULE_LOWERCASE}} module (with all layers)
Group: Applications/Multimedia
AutoReqProv: no
Requires: metwork-{{MFMODULE_LOWERCASE}} = {{FULL_VERSION}}
{% for DEP in layers %}
    {% if DEP.module == MFMODULE_LOWERCASE %}
        {% if DEP.label not in minimal_layers %}
Requires: metwork-{{MFMODULE_LOWERCASE}}-layer-{{DEP.name}}-{{MODULE_BRANCH}} = {{FULL_VERSION}}
        {% endif %}
    {% else %}
Requires: metwork-{{MFMODULE_LOWERCASE}}-layer-{{DEP.name}}-{{MODULE_BRANCH}}
    {% endif %}
{% endfor %}
%description full
This package contains all (readonly) files and directories for {{MFMODULE_LOWERCASE}} module.
Everything is in {{MFMODULE_HOME}}/
{% endif %}


#######################
#### EXTRA LAYERS #####
#######################
# Content: one RPM for one extra layers
{% for LAYER in layers %}
    {% if LAYER.label not in minimal_layers %}
%package layer-{{LAYER.name}}-{{MODULE_BRANCH}}
%define _build_id_links none
Summary: metwork {{MFMODULE_LOWERCASE}} {{LAYER.name}} extra layer
Group: Applications/Multimedia
AutoReqProv: no
Provides: metwork-{{MFMODULE_LOWERCASE}}-layer-{{LAYER.name}} = {{FULL_VERSION}}
Provides: metwork-{{MFMODULE_LOWERCASE}}-layer-{{LAYER.name}}-{{MODULE_BRANCH}} = {{FULL_VERSION}}
Obsoletes: metwork-{{MFMODULE_LOWERCASE}}-layer-{{LAYER.name}} < {{FULL_VERSION}}
Obsoletes: metwork-{{MFMODULE_LOWERCASE}}-layer-{{LAYER.name}}-{{MODULE_BRANCH}} < {{FULL_VERSION}}
{% if MFEXT_ADDON == "0" %}
Requires: metwork-{{MFMODULE_LOWERCASE}}-{{MODULE_BRANCH}} = {{FULL_VERSION}}
{% else %}
Requires: metwork-{{MFMODULE_LOWERCASE}}-{{MODULE_BRANCH}}
{% endif %}
        {% set layer_dependencies = ("_packaging_get_layer_dependencies " + LAYER.name + " " + MODULE_BRANCH + " " + MFEXT_BRANCH)|shell|from_json %}
        {% for LDEP in layer_dependencies %}
            {% if LDEP.type == "metwork" %}
                {% if LDEP.label not in minimal_layers %}
                    {# metwork layer dependencies #}
                    {% if LDEP.module == MFMODULE_LOWERCASE and LDEP.addon == MFEXT_ADDON_NAME|default('no') %}
Requires: {{LDEP.rpm}} = {{FULL_VERSION}}
                    {% else %}
Requires: {{LDEP.rpm}}
                    {% endif %}
                {% endif %}
            {% else %}
                {# system dependencies #}
                {% if LDEP.name not in minimal_system_dependencies %}
                    {% if METWORK_BUILD_OS|default('unknown') in LDEP.oss or "all" in LDEP.oss %}
Requires: {{LDEP.name}}
                    {% endif %}
                {% endif %}
            {% endif %}
        {% endfor %}
%description layer-{{LAYER.name}}-{{MODULE_BRANCH}}
metwork {{MFMODULE_LOWERCASE}} {{LAYER.name}} extra layer. Everything is in
{{MFMODULE_HOME}}/opt/{{LAYER.name}}
    {% endif %}
{% endfor %}


########################
##### prep SECTION #####
########################
%prep
cd %{_builddir} || exit 1
rm -Rf %{name}-%{version}-{{RELEASE_BUILD}}
rm -Rf {{MFMODULE_LOWERCASE}}-%{version}-{{RELEASE_BUILD}}
cat %{_sourcedir}/{{MFMODULE_LOWERCASE}}-%{version}-{{RELEASE_BUILD}}-linux64.tar | tar -xf -
mkdir %{name}-%{version}-{{RELEASE_BUILD}}
mv {{MFMODULE_LOWERCASE}}-%{version}-{{RELEASE_BUILD}} %{name}-%{version}-{{RELEASE_BUILD}}/
cd %{name}-%{version}-{{RELEASE_BUILD}}
rm -f mf*_link


{% if MFEXT_ADDON == "0" %}
    {% if MODULE_HAS_HOME_DIR == "1" %}
###################################################################
##### pre SECTION (PREINSTALLATION) FOR MAIN SUFFIXED PACKAGE #####
###################################################################
%pre {{MODULE_BRANCH}}
        N=`cat /etc/group |grep '^metwork:' |wc -l`
        if test ${N} -eq 0; then
            # try with getent
            R=`getent group metwork |grep '^metwork:' |wc -l`
            if test ${R} -eq 0; then
                echo "INFO: creating metwork unix local group"
                groupadd metwork >/dev/null 2>&1 || true
            fi
        fi
        N=`cat /etc/passwd |grep '^{{MFMODULE_LOWERCASE}}:' |wc -l`
        if test ${N} -eq 0; then
            echo "INFO: creating {{MFMODULE_LOWERCASE}} unix local user"
            useradd -d /home/{{MFMODULE_LOWERCASE}} -g metwork -s /bin/bash {{MFMODULE_LOWERCASE}} >/dev/null 2>&1 || true
            chown -R {{MFMODULE_LOWERCASE}}:metwork /home/{{MFMODULE_LOWERCASE}}.rpmsave* >/dev/null 2>&1 || true
        fi
    {% endif %}
{% endif %}


#########################
##### build SECTION #####
#########################
# Note: nothing because is built in calling Makefile
%build


###########################
##### install SECTION #####
###########################
%install
echo "INFO: install section"
mkdir -p %{buildroot}/{{MFMODULE_HOME}} 2>/dev/null
ln -s {{MFMODULE_HOME}} %{buildroot}{{TARGET_LINK}}
mv metwork-{{MFMODULE_LOWERCASE}}-%{version}-{{RELEASE_BUILD}}/{{MFMODULE_LOWERCASE}}-%{version}-{{RELEASE_BUILD}}/* %{buildroot}{{MFMODULE_HOME}}/
mv metwork-{{MFMODULE_LOWERCASE}}-%{version}-{{RELEASE_BUILD}}/{{MFMODULE_LOWERCASE}}-%{version}-{{RELEASE_BUILD}}/.layerapi2* %{buildroot}{{MFMODULE_HOME}}/ 2>/dev/null || true
mv metwork-{{MFMODULE_LOWERCASE}}-%{version}-{{RELEASE_BUILD}}/{{MFMODULE_LOWERCASE}}-%{version}-{{RELEASE_BUILD}}/.dhash* %{buildroot}{{MFMODULE_HOME}}/ 2>/dev/null || true
rm -Rf %{buildroot}{{MFMODULE_HOME}}/html_doc
chmod -R a+rX %{buildroot}{{MFMODULE_HOME}}
rm -Rf %{_builddir}/%{name}-%{version}-{{RELEASE_BUILD}} 2>/dev/null


{% if MFEXT_ADDON == "0" %}
#####################################################################
##### post SECTION (POSTINSTALLATION) FOR MAIN SUFFIXED PACKAGE #####
#####################################################################
%post {{MODULE_BRANCH}}
    if test -f /etc/metwork.config; then
        # to flush caches
        touch /etc/metwork.config >/dev/null 2>&1
    fi
    {% if MFMODULE != "MFEXT" %}
        if ! test -f /etc/metwork.config; then
            echo GENERIC >/etc/metwork.config
        fi
    {% endif %}
    {% if MFMODULE != "MFEXT" %}
        if ! test -d /etc/metwork.config.d/{{MFMODULE_LOWERCASE}}; then
            mkdir -p /etc/metwork.config.d/{{MFMODULE_LOWERCASE}}
            {% if MFMODULE == "MFDATA" %}
                mkdir -p /etc/metwork.config.d/{{MFMODULE_LOWERCASE}}/plugins
            {% elif MFMODULE == "MFSERV" %}
                mkdir -p /etc/metwork.config.d/{{MFMODULE_LOWERCASE}}/plugins
            {% elif MFMODULE == "MFBASE" %}
                mkdir -p /etc/metwork.config.d/{{MFMODULE_LOWERCASE}}/plugins
            {% endif %}
        fi
    {% endif %}
    {% if MFMODULE != "MFEXT" %}
        if ! test -d /etc/rc.d/init.d; then mkdir -p /etc/rc.d/init.d; fi
        cp -f {{MFEXT_HOME}}/bin/metwork /etc/rc.d/init.d/metwork >/dev/null 2>&1
        chmod 0755 /etc/rc.d/init.d/metwork
        chown root:root /etc/rc.d/init.d/metwork
        if test -d /usr/lib/systemd/system; then
            if ! test -f /usr/lib/systemd/system/metwork.service; then
                echo "INFO: creating metwork systemd service"
            fi
            cp -f {{MFEXT_HOME}}/share/metwork.service /usr/lib/systemd/system/metwork.service
            systemctl daemon-reload >/dev/null 2>&1 || true
            systemctl enable metwork.service >/dev/null 2>&1 || true
        else
            if test `/sbin/chkconfig --list metwork 2>/dev/null |wc -l` -eq 0; then
                /sbin/chkconfig --add metwork >/dev/null 2>&1
            fi
        fi
    {% endif %}
    {% if MFMODULE != "MFEXT" %}
        if test -d /home/{{MFMODULE_LOWERCASE}}; then
            echo "INFO: /home/{{MFMODULE_LOWERCASE}} is existing, we don't change any permission"
            rm -f /home/{{MFMODULE_LOWERCASE}}/.bashrc
            ln -s {{MFMODULE_HOME}}/share/bashrc /home/{{MFMODULE_LOWERCASE}}/.bashrc 
            chown {{MFMODULE_LOWERCASE}}:metwork /home/{{MFMODULE_LOWERCASE}}/.bashrc
            rm -f /home/{{MFMODULE_LOWERCASE}}/.bash_profile
            ln -s {{MFMODULE_HOME}}/share/bash_profile /home/{{MFMODULE_LOWERCASE}}/.bash_profile 
            chown {{MFMODULE_LOWERCASE}}:metwork /home/{{MFMODULE_LOWERCASE}}/.bash_profile
        else
            echo "INFO: Creating /home/{{MFMODULE_LOWERCASE}} with default permissions"
            mkdir -p /home/{{MFMODULE_LOWERCASE}}
            ln -s {{MFMODULE_HOME}}/share/bashrc /home/{{MFMODULE_LOWERCASE}}/.bashrc 
            ln -s {{MFMODULE_HOME}}/share/bash_profile /home/{{MFMODULE_LOWERCASE}}/.bash_profile 
            chmod -R go-rwx /home/{{MFMODULE_LOWERCASE}}
            chmod -R u+rX /home/{{MFMODULE_LOWERCASE}}
            {% if MFMODULE == "MFDATA" %}
                chmod g+rx /home/{{MFMODULE_LOWERCASE}}
                chmod o+x /home/{{MFMODULE_LOWERCASE}}
            {% endif %}
        fi
        {% if MFMODULE == "MFDATA" %}
            if ! test -d /home/{{MFMODULE_LOWERCASE}}/var/in
                mkdir -p /home/{{MFMODULE_LOWERCASE}}/var/in >/dev/null 2>&1
                chown -R {{MFMODULE_LOWERCASE}}:metwork /home/{{MFMODULE_LOWERCASE}}/var >/dev/null 2>&1
                chmod g+rX /home/{{MFMODULE_LOWERCASE}} >/dev/null 2>&1
                chmod g+rX /home/{{MFMODULE_LOWERCASE}}/var >/dev/null 2>&1
                chmod g+rX /home/{{MFMODULE_LOWERCASE}}/var/in >/dev/null 2>&1
            fi
        {% endif %}
    {% endif %}
    {% if MFMODULE != "MFEXT" %}
        if test -d /etc/security/limits.d; then
            if ! test -f /etc/security/limits.d/50-metwork.conf; then
                echo "INFO: creating /etc/security/limits.d/50-metwork.conf file"
            fi
            cat >/etc/security/limits.d/50-metwork.conf <<EOF
@metwork    soft    nofile  65536
@metwork    hard    nofile  65536
@metwork    soft    nproc  100000
@metwork    hard    nproc  100000
EOF
        fi
    {% endif %}
    {% if MFMODULE == "MFEXT" %}
        if test -f /etc/metwork.config.d/mfserv/set_cap_net_bind_service; then
            NGINX="{{MFEXT_HOME}}/opt/openresty/nginx/sbin/nginx"
            if test -f "${NGINX}"; then
                echo "INFO: setting cap_net_bind_service on ${NGINX}"
                setcap cap_net_bind_service=+ep "${NGINX}" >/dev/null 2>&1 || true
            fi
        fi
    {% endif %}
{% endif %}


{% if MFEXT_ADDON == "0" %}
#########################################################################
##### postun SECTION (POSTUNINSTALLATION) FOR MAIN SUFFIXED PACKAGE #####
#########################################################################
%postun {{MODULE_BRANCH}}
    echo "INFO: postuninstall {{MODULE_BRANCH}} section"
    {% if MODULE_HAS_HOME_DIR == "1" %}
        #Remove system crontab (it will be rebuilt by module start and it may fix #1557)
        crontab -r -u {{MFMODULE_LOWERCASE}} || true
    {% endif %}
    if [ "$1" = "0" ]; then # last uninstall only
        rm -Rf {{MFMODULE_HOME}} 2>/dev/null
        # see https://stackoverflow.com/questions/40396945/
        # date-command-is-giving-erroneous-output-while-using-inside-rpm-spec-file
        export SAVE_SUFFIX="rpmsave`date '+%Y%m%d%H%M%''S'`"
        {% if MODULE_HAS_HOME_DIR == "1" %}
            if test -d /home/{{MFMODULE_LOWERCASE}}; then
                echo "INFO: saving (but not removing) old /home/{{MFMODULE_LOWERCASE}} to /home/{{MFMODULE_LOWERCASE}}.${SAVE_SUFFIX} ..."
                cp -Rp /home/{{MFMODULE_LOWERCASE}} /home/{{MFMODULE_LOWERCASE}}.${SAVE_SUFFIX}
                rm -Rf /home/{{MFMODULE_LOWERCASE}}.${SAVE_SUFFIX}/log
                rm -Rf /home/{{MFMODULE_LOWERCASE}}.${SAVE_SUFFIX}/tmp
                {% if MFMODULE == "MFDATA" %}
                    rm -Rf /home/{{MFMODULE_LOWERCASE}}.${SAVE_SUFFIX}/var/in
                {% endif %}
            fi
        {% endif %}
        N=`find /etc/metwork.config.d/{{MFMODULE_LOWERCASE}} -type f 2>/dev/null |wc -l`
        if test ${N} -gt 0; then
            echo "INFO: saving (but not removing) old /etc/metwork.config.d/{{MFMODULE_LOWERCASE}} to /etc/metwork.config.d/{{MFMODULE_LOWERCASE}}.${SAVE_SUFFIX} ..."
            cp -Rp /etc/metwork.config.d/{{MFMODULE_LOWERCASE}} /etc/metwork.config.d/{{MFMODULE_LOWERCASE}}.${SAVE_SUFFIX}
        fi
    fi
{% endif %}


#########################
##### clean SECTION #####
#########################
%clean
rm -fr %{buildroot}


#########################################
#### files SECTION FOR MAIN PACKAGE #####
#########################################
%files
%defattr(-,root,root,-)
{{TARGET_LINK}}


{% if MFEXT_ADDON == "0" %}
##################################################
#### files SECTION FOR MAIN SUFFIXED PACKAGE #####
##################################################
%files {{MODULE_BRANCH}}
%defattr(-,root,root,-)
{% set tmp_list = "cd ${MFMODULE_HOME}; ls -a |grep -v '^\.$' |grep -v '^\.\.$' |grep -v '^tmp$' |grep -v '^opt$' |grep -v '\.tar$' |grep -v '^rpm$' |grep -v '^html_doc' 2>/dev/null"|shell %}
{% set root_list = tmp_list.split('\n')[:-1] %}
{% for entry in root_list %}
{{MFMODULE_HOME}}/{{ entry }}
{% endfor %}
%dir {{MFMODULE_HOME}}/opt
{% for LAYER in layers %}
    {% if LAYER.label in minimal_layers %}
        {% if LAYER.name != "root" %}
{{MFMODULE_HOME}}/opt/{{LAYER.name}}
        {% endif %}
    {% endif %}
{% endfor %}
{% endif %}


{% if MFEXT_ADDON == "0" %}
#########################################
#### files SECTION FOR FULL PACKAGE #####
#########################################
%files full
%defattr(-,root,root,-)
# empty
{% endif %}


{% for LAYER in layers %}
    {% if LAYER.label not in minimal_layers %}
        {% if LAYER.name != "root" %}
###########################################################################
#### files SECTION FOR layer-{{LAYER.name}}-{{MODULE_BRANCH}} PACKAGE #####
###########################################################################
%files layer-{{LAYER.name}}-{{MODULE_BRANCH}}
%defattr(-,root,root,-)
{{MFMODULE_HOME}}/opt/{{LAYER.name}}
        {% endif %}
    {% endif %}
{% endfor %}
