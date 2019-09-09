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
{% if MODULE != "MFEXT" %}
    {% if '.ci' in MFCOM_VERSION %}
        {% set MFCOM_BRANCH = MFCOM_VERSION.split('.')[0:-2]|join('.') %}
    {% else %}
        {% set MFCOM_BRANCH = MFCOM_VERSION.split('.')[0:2]|join('.') %}
    {% endif %}
{% else %}
    {% set MFCOM_BRANCH = "NOT_USED" %}
{% endif %}
{% if '.ci' in MODULE_VERSION %}
    {% set MODULE_BRANCH = MODULE_VERSION.split('.')[0:-2]|join('.') %}
{% else %}
    {% set MODULE_BRANCH = MODULE_VERSION.split('.')[0:2]|join('.') %}
{% endif %}
# DEBUG: MFEXT_BRANCH: {{MFEXT_BRANCH}}
# DEBUG: MFCOM_BRANCH: {{MFCOM_BRANCH}}
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
    {% elif METWORK_BUILD_OS == "generic" %}
        {% set RELEASE_BUILD_SUFFIX = ".gen" %}
    {% endif %}
{% endif %}
{% set version_release = [VERSION_BUILD, RELEASE_BUILD + RELEASE_BUILD_SUFFIX] %}
{% set version_release_string = version_release|join('-') %}
{% set epoch_vr = ["9", version_release_string] %}
{% set FULL_VERSION = epoch_vr|join(':') %}
{% set _TARGET_LINK = MODULE_HOME + "/../metwork-" + MODULE_LOWERCASE %}
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
    {% if MODULE == "MFEXT" %}
        # DEBUG: dependencies_command: {{ "_packaging_get_module_dependencies " + MODULE_BRANCH + " " + MFEXT_BRANCH }}
        {% set dependencies = ("_packaging_get_module_dependencies " + MODULE_BRANCH + " " + MFEXT_BRANCH)|shell|from_json %}
    {% else %}
        # DEBUG: dependencies_command: {{ "_packaging_get_module_dependencies " + MODULE_BRANCH + " " + MFEXT_BRANCH + " " + MFCOM_BRANCH}}
        {% set dependencies = ("_packaging_get_module_dependencies " + MODULE_BRANCH + " " + MFEXT_BRANCH + " " + MFCOM_BRANCH)|shell|from_json %}
    {% endif %}
{% endif %}
{% set minimal_layers = [] %}
{% set minimal_system_dependencies = [] %}


########################
##### MAIN PACKAGE #####
########################
# Note: it will be deleted for addons (in the calling Makefile)
# content: symbolic link + home directory  + everything that is not in {{MODULE_HOME}}
%define __jar_repack %{nil}
%define __os_install_post %{nil}
%define debug_package %{nil}
Name: metwork-{{MODULE_LOWERCASE}}
{% if MODULE_LOWERCASE == "mfext" %}
Summary: metwork {{MODULE_LOWERCASE}} symbolic link
{% else %}
Summary: metwork {{MODULE_LOWERCASE}} symbolic link and stuff around the {{MODULE_LOWERCASE}} unix user
{% endif %}
Version: {{VERSION_BUILD}}
Release: {{RELEASE_BUILD}}{{RELEASE_BUILD_SUFFIX}}
Epoch: 9
License: Meteo
Source0: {{MODULE_LOWERCASE}}-{{VERSION_BUILD}}-{{RELEASE_BUILD}}-linux64.tar
Group: Applications/Multimedia
URL: http://metwork.meteo.fr
Buildroot: %{_topdir}/tmp/%{name}-root
Packager: Fabien MARTY <fabien.marty@meteo.fr>
Vendor: Metwork
ExclusiveOs: linux
AutoReq: no
AutoProv: no
Requires: metwork-{{MODULE_LOWERCASE}}-{{MODULE_BRANCH}} = {{FULL_VERSION}}
Provides: metwork-{{MODULE_LOWERCASE}}-minimal = {{FULL_VERSION}}
Obsoletes: metwork-{{MODULE_LOWERCASE}}-minimal < {{FULL_VERSION}}
{% if MODULE_LOWERCASE == "mfext" %}
%description
This package provides the {{TARGET_LINK}} symbolic link
{% else %}
%description
This package provides the {{TARGET_LINK}} symbolic link
and the stuff around the {{MODULE_LOWERCASE}} unix user.
{% endif %}


{% if MFEXT_ADDON == "0" %}
#################################
##### SUFFIXED MAIN PACKAGE #####
#################################
# Content: everything in {{MODULE_HOME}} and all minimal layers
%package {{MODULE_BRANCH}}
Summary: metwork {{MODULE_LOWERCASE}} minimal module (default layer)
Group: Applications/Multimedia
AutoReq: no
AutoProv: no
# <to be removed someday>
Obsoletes: metwork-{{MODULE_LOWERCASE}}-core-{{MODULE_BRANCH}}
Obsoletes: metwork-{{MODULE_LOWERCASE}}-layer-python-{{MODULE_BRANCH}}
{% if MODULE == "MFADMIN" %}
Obsoletes: metwork-mfadmin-layer-monitoring-{{MODULE_BRANCH}}
Obsoletes: metwork-mfadmin-layer-python3-{{MODULE_BRANCH}}
{% elif MODULE == "MFEXT" %}
Obsoletes: metwork-mfext-scientific-{{MODULE_BRANCH}}
Obsoletes: metwork-mfext-scientific
Obsoletes: metwork-mfext-python2-{{MODULE_BRANCH}}
Obsoletes: metwork-mfext-python2
Obsoletes: metwork-mfext-devtools-{{MODULE_BRANCH}}
Obsoletes: metwork-mfext-devtools
Obsoletes: metwork-mfext-layer-python3_devtools_jupyter-{{MODULE_BRANCH}}
{% endif %}
# </to be removed someday>
Provides: metwork-{{MODULE_LOWERCASE}}-minimal-{{MODULE_BRANCH}} = {{FULL_VERSION}}
Obsoletes: metwork-{{MODULE_LOWERCASE}}-minimal-{{MODULE_BRANCH}} < {{FULL_VERSION}}
{% for DEP in dependencies %}
    {% if DEP.type == "metwork" %}
        {# metwork layer dependencies #}
        {% if DEP.module == MODULE_LOWERCASE %}
            {# Because this dependency will be embedded in this package #}
            {{ minimal_layers.append(DEP.label)|replace('None', '') }}
            {% if (MODULE_BRANCH == "integration" or MODULE_BRANCH == "master") and DEP.name == "root" %}
                # we don't obsoletes root layer for the moment to avoid some issues with postun
                # => we provide a new layer-root dummy package
                # FIXME: to be removed someday
Requires: metwork-{{MODULE_LOWERCASE}}-layer-root-{{MODULE_BRANCH}} >= {{FULL_VERSION}}
            {% else %}
Provides: {{DEP.rpm}} = {{FULL_VERSION}}
Obsoletes: {{DEP.rpm}} < {{FULL_VERSION}}
            {% endif %}
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
This package contains minimal (readonly) files and directories for {{MODULE_LOWERCASE}} module.
Everything is in {{MODULE_HOME}}/
{% endif %}

{% if MFEXT_ADDON == "0" %}
    {% if MODULE_BRANCH == "master" or MODULE_BRANCH == "integration" %}
        # DUMMY TEMPORARY LAYER-ROOT PACKAGE to avoid some issues with postun
%package layer-root-{{MODULE_BRANCH}}
Summary: dummy package to deal with update issues
Group: Applications/Multimedia
AutoReq: no
AutoProv: no
Requires: metwork-{{MODULE_LOWERCASE}}-{{MODULE_BRANCH}} >= {{FULL_VERSION}}
%description layer-root-{{MODULE_BRANCH}}
Dummy package to deal with update issues
    {% endif %}
{% endif %}

{% if MFEXT_ADDON == "0" %}
########################
##### FULL PACKAGE #####
########################
# Content: everything in {{MODULE_HOME}} and all available layers
%package full
Summary: metwork {{MODULE_LOWERCASE}} module (with all layers)
Group: Applications/Multimedia
AutoReq: no
AutoProv: no
Requires: metwork-{{MODULE_LOWERCASE}} = {{FULL_VERSION}}
{% for DEP in layers %}
    {% if DEP.module == MODULE_LOWERCASE %}
        {% if DEP.label not in minimal_layers %}
Requires: metwork-{{MODULE_LOWERCASE}}-layer-{{DEP.name}}-{{MODULE_BRANCH}} = {{FULL_VERSION}}
        {% endif %}
    {% else %}
Requires: metwork-{{MODULE_LOWERCASE}}-layer-{{DEP.name}}-{{MODULE_BRANCH}}
    {% endif %}
{% endfor %}
%description full
This package contains all (readonly) files and directories for {{MODULE_LOWERCASE}} module.
Everything is in {{MODULE_HOME}}/
{% endif %}


#######################
#### EXTRA LAYERS #####
#######################
# Content: one RPM for one extra layers
{% for LAYER in layers %}
    {% if LAYER.label not in minimal_layers %}
%package layer-{{LAYER.name}}-{{MODULE_BRANCH}}
Summary: metwork {{MODULE_LOWERCASE}} {{LAYER.name}} extra layer
Group: Applications/Multimedia
AutoReq: no
AutoProv: no
Provides: metwork-{{MODULE_LOWERCASE}}-layer-{{LAYER.name}} = {{FULL_VERSION}}
Provides: metwork-{{MODULE_LOWERCASE}}-layer-{{LAYER.name}}-{{MODULE_BRANCH}} = {{FULL_VERSION}}
Obsoletes: metwork-{{MODULE_LOWERCASE}}-layer-{{LAYER.name}} < {{FULL_VERSION}}
Obsoletes: metwork-{{MODULE_LOWERCASE}}-layer-{{LAYER.name}}-{{MODULE_BRANCH}} < {{FULL_VERSION}}
{% if MFEXT_ADDON == "0" %}
Requires: metwork-{{MODULE_LOWERCASE}}-{{MODULE_BRANCH}} = {{FULL_VERSION}}
{% else %}
Requires: metwork-{{MODULE_LOWERCASE}}-{{MODULE_BRANCH}}
{% endif %}
        {% if MODULE == "MFEXT" %}
            {% set layer_dependencies = ("_packaging_get_layer_dependencies " + LAYER.name + " " + MODULE_BRANCH + " " + MFEXT_BRANCH)|shell|from_json %}
        {% else %}
            {% set layer_dependencies = ("_packaging_get_layer_dependencies " + LAYER.name + " " + MODULE_BRANCH + " " + MFEXT_BRANCH + " " + MFCOM_BRANCH)|shell|from_json %}
        {% endif %}
        {% for LDEP in layer_dependencies %}
            {% if LDEP.type == "metwork" %}
                {% if LDEP.label not in minimal_layers %}
                    {# metwork layer dependencies #}
                    {% if LDEP.module == MODULE_LOWERCASE and LDEP.addon == MFEXT_ADDON_NAME|default('no') %}
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
metwork {{MODULE_LOWERCASE}} {{LAYER.name}} extra layer. Everything is in
{{MODULE_HOME}}/opt/{{LAYER.name}}
    {% endif %}
{% endfor %}


########################
##### prep SECTION #####
########################
%prep
cd %{_builddir} || exit 1
rm -Rf %{name}-%{version}-{{RELEASE_BUILD}}
rm -Rf {{MODULE_LOWERCASE}}-%{version}-{{RELEASE_BUILD}}
cat %{_sourcedir}/{{MODULE_LOWERCASE}}-%{version}-{{RELEASE_BUILD}}-linux64.tar | tar -xf -
mkdir %{name}-%{version}-{{RELEASE_BUILD}}
mv {{MODULE_LOWERCASE}}-%{version}-{{RELEASE_BUILD}} %{name}-%{version}-{{RELEASE_BUILD}}/
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
            groupadd metwork >/dev/null 2>&1 || true
        fi
        N=`cat /etc/passwd |grep '^{{MODULE_LOWERCASE}}:' |wc -l`
        if test ${N} -eq 0; then
            useradd -d /home/{{MODULE_LOWERCASE}} -g metwork -s /bin/bash {{MODULE_LOWERCASE}} >/dev/null 2>&1 || true
            # FIXME: we don't probably want default passwords
            echo {{MODULE_LOWERCASE}} |passwd --stdin {{MODULE_LOWERCASE}} >/dev/null 2>&1 || true
            {% if MODULE == "MFDATA" %}
                # FIXME: depose is a french word
                useradd -M -d /home/{{MODULE_LOWERCASE}}/var/in -g metwork -s /sbin/nologin depose >/dev/null 2>&1 || true
                # FIXME: we don't probably want default passwords
                echo depose |passwd --stdin {{MODULE_LOWERCASE}} >/dev/null 2>&1 || true
                chmod g+rx /home/{{MODULE_LOWERCASE}} >/dev/null 2>&1 || true
            {% endif %}
            rm -Rf /home/{{MODULE_LOWERCASE}}
            chown -R {{MODULE_LOWERCASE}}:metwork /home/{{MODULE_LOWERCASE}}.rpmsave* >/dev/null 2>&1 || true
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
mkdir -p %{buildroot}/{{MODULE_HOME}} 2>/dev/null
ln -s {{MODULE_HOME}} %{buildroot}{{TARGET_LINK}}
{% if MODULE_HAS_HOME_DIR == "1" %}
    mkdir -p %{buildroot}/home/{{MODULE_LOWERCASE}} 2>/dev/null
{% endif %}
mv metwork-{{MODULE_LOWERCASE}}-%{version}-{{RELEASE_BUILD}}/{{MODULE_LOWERCASE}}-%{version}-{{RELEASE_BUILD}}/* %{buildroot}{{MODULE_HOME}}/
mv metwork-{{MODULE_LOWERCASE}}-%{version}-{{RELEASE_BUILD}}/{{MODULE_LOWERCASE}}-%{version}-{{RELEASE_BUILD}}/.layerapi2* %{buildroot}{{MODULE_HOME}}/ 2>/dev/null || true
mv metwork-{{MODULE_LOWERCASE}}-%{version}-{{RELEASE_BUILD}}/{{MODULE_LOWERCASE}}-%{version}-{{RELEASE_BUILD}}/.dhash* %{buildroot}{{MODULE_HOME}}/ 2>/dev/null || true
rm -Rf %{buildroot}{{MODULE_HOME}}/html_doc
{% if MODULE_HAS_HOME_DIR == "1" %}
    ln -s {{MODULE_HOME}}/share/bashrc %{buildroot}/home/{{MODULE_LOWERCASE}}/.bashrc
    ln -s {{MODULE_HOME}}/share/bash_profile %{buildroot}/home/{{MODULE_LOWERCASE}}/.bash_profile
    chmod -R go-rwx %{buildroot}/home/{{MODULE_LOWERCASE}}
    chmod -R u+rX %{buildroot}/home/{{MODULE_LOWERCASE}}
    {% if MODULE == "MFDATA" %}
        chmod g+rx %{buildroot}/home/{{MODULE_LOWERCASE}}
    {% endif %}
{% endif %}
chmod -R a+rX %{buildroot}{{MODULE_HOME}}
rm -Rf %{_builddir}/%{name}-%{version}-{{RELEASE_BUILD}} 2>/dev/null
{% if MODULE == "MFCOM" %}
    mkdir -p %{buildroot}/etc/security/limits.d/
    cat >%{buildroot}/etc/security/limits.d/50-metwork.conf <<EOF
    @metwork    soft    nofile  65536
    @metwork    hard    nofile  65536
    @metwork    soft    nproc  100000
    @metwork    hard    nproc  100000
    EOF
{% endif %}


{% if MFEXT_ADDON == "0" %}
#####################################################################
##### post SECTION (POSTINSTALLATION) FOR MAIN SUFFIXED PACKAGE #####
#####################################################################
%post {{MODULE_BRANCH}}
    if test -f /etc/metwork.config; then
        # to flush caches
        touch /etc/metwork.config >/dev/null 2>&1
    fi
    {% if MODULE != "MFCOM" and MODULE != "MFEXT" %}
        if ! test -f /etc/metwork.config; then
            echo GENERIC >/etc/metwork.config
        fi
    {% endif %}
    {% if MODULE != "MFCOM" and MODULE != "MFEXT" %}
        if ! test -d /etc/metwork.config.d/{{MODULE_LOWERCASE}}; then
            mkdir -p /etc/metwork.config.d/{{MODULE_LOWERCASE}}
            {% if MODULE == "MFDATA" %}
                mkdir -p /etc/metwork.config.d/{{MODULE_LOWERCASE}}/external_plugins
            {% elif MODULE == "MFSERV" %}
                mkdir -p /etc/metwork.config.d/{{MODULE_LOWERCASE}}/external_plugins
            {% elif MODULE == "MFBASE" %}
                mkdir -p /etc/metwork.config.d/{{MODULE_LOWERCASE}}/external_plugins
            {% endif %}
        fi
    {% endif %}
    {% if MODULE != "MFCOM" and MODULE != "MFEXT" %}
        if ! test -d /etc/rc.d/init.d; then mkdir -p /etc/rc.d/init.d; fi
        cp -f {{MFCOM_HOME}}/bin/metwork /etc/rc.d/init.d/metwork >/dev/null 2>&1
        chmod 0755 /etc/rc.d/init.d/metwork
        chown root:root /etc/rc.d/init.d/metwork
        if test `/sbin/chkconfig --list metwork 2>/dev/null |wc -l` -eq 0; then
            /sbin/chkconfig --add metwork >/dev/null 2>&1
        fi
    {% endif %}
    {% if MODULE == "MFDATA" %}
        mkdir -p /home/{{MODULE_LOWERCASE}}/var/in >/dev/null 2>&1
        chown -R {{MODULE_LOWERCASE}}:metwork /home/{{MODULE_LOWERCASE}}/var >/dev/null 2>&1
        chmod g+rX /home/{{MODULE_LOWERCASE}} >/dev/null 2>&1
        chmod g+rX /home/{{MODULE_LOWERCASE}}/var >/dev/null 2>&1
        chmod g+rX /home/{{MODULE_LOWERCASE}}/var/in >/dev/null 2>&1
    {% endif %}
{% endif %}


{% if MFEXT_ADDON == "0" %}
#########################################################################
##### postun SECTION (POSTUNINSTALLATION) FOR MAIN SUFFIXED PACKAGE #####
#########################################################################
%postun {{MODULE_BRANCH}}
    if [ "$1" = "0" ]; then # last uninstall only
        rm -Rf {{TARGET_LINK}} 2>/dev/null
        rm -Rf {{MODULE_HOME}} 2>/dev/null
        # see https://stackoverflow.com/questions/40396945/
        # date-command-is-giving-erroneous-output-while-using-inside-rpm-spec-file
        export SAVE_SUFFIX="rpmsave`date '+%Y%m%d%H%M%''S'`"
        {% if MODULE_HAS_HOME_DIR == "1" %}
            if test -d /home/{{MODULE_LOWERCASE}}; then
                echo "Saving old /home/{{MODULE_LOWERCASE}} to /home/{{MODULE_LOWERCASE}}.${SAVE_SUFFIX} ..."
                mv /home/{{MODULE_LOWERCASE}} /home/{{MODULE_LOWERCASE}}.${SAVE_SUFFIX}
                rm -Rf /home/{{MODULE_LOWERCASE}}.${SAVE_SUFFIX}/log
                rm -Rf /home/{{MODULE_LOWERCASE}}.${SAVE_SUFFIX}/tmp
                {% if MODULE == "MFDATA" %}
                    rm -Rf /home/{{MODULE_LOWERCASE}}.${SAVE_SUFFIX}/var/in
                {% endif %}
                mkdir /home/{{MODULE_LOWERCASE}}
            fi
            userdel -f -r {{MODULE_LOWERCASE}} 2>/dev/null
            rm -Rf /home/{{MODULE_LOWERCASE}} 2>/dev/null
        {% endif %}
        {% if MODULE == "MFCOM" %}
            rm -f /etc/rc.d/init.d/metwork >/dev/null 2>&1
        {% endif %}
        N=`find /etc/metwork.config.d/{{MODULE_LOWERCASE}} -type f 2>/dev/null |wc -l`
        if test ${N} -gt 0; then
            echo "Saving old /etc/metwork.config.d/{{MODULE_LOWERCASE}} to /etc/metwork.config.d/{{MODULE_LOWERCASE}}.${SAVE_SUFFIX} ..."
            mv /etc/metwork.config.d/{{MODULE_LOWERCASE}} /etc/metwork.config.d/{{MODULE_LOWERCASE}}.${SAVE_SUFFIX}
        fi
        rm -Rf /etc/metwork.config.d/{{MODULE_LOWERCASE}}
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
{% if MODULE_HAS_HOME_DIR == "1" %}
%defattr(-,{{MODULE_LOWERCASE}},metwork,-)
/home/{{MODULE_LOWERCASE}}
{% endif %}
{% if MODULE == "MFCOM" %}
/etc/security/limits.d/50-metwork.conf
{% endif %}


{% if MFEXT_ADDON == "0" %}
##################################################
#### files SECTION FOR MAIN SUFFIXED PACKAGE #####
##################################################
%files {{MODULE_BRANCH}}
%defattr(-,root,root,-)
{% set tmp_list = "cd ${MODULE_HOME}; ls -a |grep -v '^\.$' |grep -v '^\.\.$' |grep -v '^tmp$' |grep -v '^opt$' |grep -v '\.tar$' |grep -v '^rpm$' |grep -v '^html_doc' 2>/dev/null"|shell %}
{% set root_list = tmp_list.split('\n')[:-1] %}
{% for entry in root_list %}
{{MODULE_HOME}}/{{ entry }}
{% endfor %}
%dir {{MODULE_HOME}}/opt
{% for LAYER in layers %}
    {% if LAYER.label in minimal_layers %}
        {% if LAYER.name != "root" %}
{{MODULE_HOME}}/opt/{{LAYER.name}}
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
###########################################################################
#### files SECTION FOR layer-{{LAYER.name}}-{{MODULE_BRANCH}} PACKAGE #####
###########################################################################
%files layer-{{LAYER.name}}-{{MODULE_BRANCH}}
%defattr(-,root,root,-)
{{MODULE_HOME}}/opt/{{LAYER.name}}
    {% endif %}
{% endfor %}

{% if MFEXT_ADDON == "0" %}
    {% if MODULE_BRANCH == "master" or MODULE_BRANCH == "integration" %}
%files layer-root-{{MODULE_BRANCH}}
%defattr(-,root,root,-)
    {% endif %}
{% endif %}
