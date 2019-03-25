{% if MFEXT_ADDON is not defined %}
    {% set MFEXT_ADDON = "0" %}
{% endif %}
{% if '.ci' in MFEXT_VERSION %}
    {% set MFEXT_BRANCH = MFEXT_VERSION.split('.')[0:-2]|join('.') %}
{% else %}
    {% set MFEXT_BRANCH = MFEXT_VERSION.split('.')[0:2]|join('.') %}
{% endif %}
{% if MODULE != "MFEXT" -%}
    {% if '.ci' in MFCOM_VERSION %}
        {% set MFCOM_BRANCH = MFCOM_VERSION.split('.')[0:-2]|join('.') %}
    {% else %}
        {% set MFCOM_BRANCH = MFCOM_VERSION.split('.')[0:2]|join('.') %}
    {% endif %}
{% endif -%}
{% if '.ci' in MODULE_VERSION %}
    {% set MODULE_BRANCH = MODULE_VERSION.split('.')[0:-2]|join('.') %}
{% else %}
    {% set MODULE_BRANCH = MODULE_VERSION.split('.')[0:2]|join('.') %}
{% endif %}
%define __jar_repack %{nil}
%define __os_install_post %{nil}
%define debug_package %{nil}
{% set version_release = [VERSION_BUILD, RELEASE_BUILD] -%}
{% set version_release_string = version_release|join('-') -%}
{% set epoch_vr = [EPOCH, version_release_string] -%}
{% set FULL_VERSION = epoch_vr|join(':') -%}
{% set _TARGET_LINK = MODULE_HOME + "/../metwork-" + MODULE_LOWERCASE -%}
{% set _TARGET_LINK_COMMAND = "readlink -m " + _TARGET_LINK -%}
{% set TARGET_LINK = _TARGET_LINK_COMMAND|shell -%}

{% set liste = 'cd $MODULE_HOME; ls -da bin config lib include share .layerapi2* 2>/dev/null'|shell -%}
{% set root_list = liste.split('\n')[:-1] -%}
{% if MFEXT_ADDON == "1" %}
{% set liste2 = 'if test -d $MODULE_HOME/opt; then cd $MODULE_HOME/opt; for REP in *; do if test -f "${REP}/.mfextaddon"; then echo ${REP}; fi; done; fi'|shell -%}
{% else %}
{% set liste2 = 'if test -d $MODULE_HOME/opt; then cd $MODULE_HOME/opt; ls -d *; fi'|shell -%}
{% endif %}
{% set full_layers_list = liste2.split('\n')[:-1] -%}

Name: metwork-{{MODULE_LOWERCASE}}
Summary: metwork {{MODULE_LOWERCASE}} module
Version: {{VERSION_BUILD}}
Release: {{RELEASE_BUILD}}
Epoch: {{EPOCH}}
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
Requires: metwork-{{MODULE_LOWERCASE}}-layer-root-{{MODULE_BRANCH}} = {{FULL_VERSION}}
{% for layer in full_layers_list -%}
Requires: metwork-{{MODULE_LOWERCASE}}-layer-{{layer}}-{{MODULE_BRANCH}} = {{FULL_VERSION}}
{% endfor -%}
Provides: metwork-{{MODULE_LOWERCASE}}-full = {{FULL_VERSION}}
%description
This package provides the full {{MODULE_LOWERCASE}} module of the metwork framework

{% if MFEXT_ADDON == "0" %}
%package minimal
Summary: metwork {{MODULE_LOWERCASE}} minimal module (default layer)
Group: Applications/Multimedia
AutoReq: no
AutoProv: no
Requires: metwork-{{MODULE_LOWERCASE}}-minimal-{{MODULE_BRANCH}} = {{FULL_VERSION}}
%description minimal
Minimal "individual layer" rpm list to install for module {{MODULE_LOWERCASE}}

%package minimal-{{MODULE_BRANCH}}
Summary: metwork {{MODULE_LOWERCASE}} minimal module (default layer) branch {{MODULE_BRANCH}}
Group: Applications/Multimedia
AutoReq: no
AutoProv: no
Requires: metwork-{{MODULE_LOWERCASE}}-layer-default-{{MODULE_BRANCH}} = {{FULL_VERSION}}
# Minimal rpm must have the "layer root" rpm in dependency
Requires: metwork-{{MODULE_LOWERCASE}}-layer-root-{{MODULE_BRANCH}} = {{FULL_VERSION}}
# -e "s/^#+//" to add not loaded dependencies
{% set cmd = 'cat ' + MODULE_HOME + '/opt/default' + '/.layerapi2_dependencies| grep -v "^-" | sed -e "s/{METWORK_PYTHON_MODE}/3/g" | sed -e "s/^#+//" | grep -v "{"' -%}
{% set deps = cmd|shell -%}
{% set deps_list = deps.split('\n')[:-1] -%}
{% for d in deps_list -%}
{% set layer_dep = d.split('@')[0] -%}
{% set module_dep = (d+'@').split('@')[1] -%}
{% if module_dep == "mfext" -%}
{% set branch = MFEXT_BRANCH -%}
{% elif module_dep == "mfcom" -%}
{% set branch = MFCOM_BRANCH -%}
{% else -%}
{% set branch = MODULE_BRANCH -%}
{% endif -%}
{% if module_dep == MODULE_LOWERCASE -%}
Requires: metwork-{{module_dep}}-layer-{{layer_dep}}-{{branch}} = {{FULL_VERSION}}
{% else -%}
# Do not specify version for layers out of the current module
Requires: metwork-{{module_dep}}-layer-{{layer_dep}}-{{branch}}
{% endif -%}
{% endfor -%}
%description minimal-{{MODULE_BRANCH}}
Minimal rpm list to install for module {{MODULE_LOWERCASE}} + link /opt/metwork-{{MODULE_LOWERCASE}}

%package layer-root-{{MODULE_BRANCH}}
Summary: metwork {{MODULE_LOWERCASE}} root layer
Group: Applications/Multimedia
AutoReq: no
AutoProv: no
Obsoletes: metwork-{{MODULE_LOWERCASE}}-core-{{MODULE_BRANCH}}
{% if MODULE == "MFADMIN" -%}
Obsoletes: metwork-mfadmin-layer-monitoring-{{MODULE_BRANCH}}
{% endif -%}
{% if MODULE == "MFEXT" -%}
{% if METWORK_BUILD_OS|default('unknown') == "centos7" -%}
Requires: openssl >= 1:1.0.2
Requires: openssl-libs >= 1:1.0.2
#Fixme : libgfortran because numpy is installed in layers python2[3]
#rather than in layers python2[3]_scientific
Requires: libgfortran
Requires: libicu
{% else -%}
Requires: openssl
{% endif -%}
Requires: which
Requires: /usr/bin/lscpu, /usr/bin/wget
{% endif -%}
{% set cmd = 'cat ' + MODULE_HOME + '/.layerapi2_dependencies| grep -v "^-" | sed -e "s/{METWORK_PYTHON_MODE}/3/g" | sed -e "s/^#+//" | grep -v "{"' -%}
{% set deps = cmd|shell -%}
{% set deps_list = deps.split('\n')[:-1] -%}
{% for d in deps_list -%}
{% set layer_dep = d.split('@')[0] -%}
{% set module_dep = (d+'@').split('@')[1] -%}
{% if module_dep == "mfext" -%}
{% set branch = MFEXT_BRANCH -%}
{% elif module_dep == "mfcom" -%}
{% set branch = MFCOM_BRANCH -%}
{% else -%}
{% set branch = MODULE_BRANCH -%}
{% endif -%}
{% if module_dep == MODULE_LOWERCASE -%}
Requires: metwork-{{module_dep}}-layer-{{layer_dep}}-{{branch}} = {{FULL_VERSION}}
{% else -%}
# Do not specify version for layers out of the current module
Requires: metwork-{{module_dep}}-layer-{{layer_dep}}-{{branch}}
{% endif -%}
{% endfor -%}
%description layer-root-{{MODULE_BRANCH}}
metwork {{MODULE_LOWERCASE}} root layer
{% endif %}

{% for layer in full_layers_list %}
%package layer-{{layer}}-{{MODULE_BRANCH}}
Summary: metwork {{MODULE_LOWERCASE}} {{layer}} layer
Group: Applications/Multimedia
AutoReq: no
AutoProv: no
# -e "s/^#+//" to add not loaded dependencies
{% set cmd = 'cat ' + MODULE_HOME + '/opt/' + layer + '/.layerapi2_dependencies| grep -v "^-" | sed -e "s/{METWORK_PYTHON_MODE}/3/g" | sed -e "s/^#+//" | grep -v "{"' -%}
{% set deps = cmd|shell -%}
{% set deps_list = deps.split('\n')[:-1] -%}
{% for d in deps_list -%}
{% set layer_dep = d.split('@')[0] -%}
{% set module_dep = (d+'@').split('@')[1] -%}
{% if module_dep == "mfext" -%}
{% set branch = MFEXT_BRANCH -%}
{% elif module_dep == "mfcom" -%}
{% set branch = MFCOM_BRANCH -%}
{% else -%}
{% set branch = MODULE_BRANCH -%}
{% endif -%}
{% if module_dep == MODULE_LOWERCASE -%}
# We don't want "root layer rpm" of the module in dependency of the single layer rpms
# Only minimal rpm, which is in dependency of all single layer rpms, has this dependency
# (to avoid "circle" dependencies issues and to make sure the root layer rpm is the
# last uninstalled rpm, which is better because this rpm removes all module files in
# a rough way)
{% if layer_dep != "root" -%}
{% if MFEXT_ADDON == "1" %}
Requires: metwork-{{module_dep}}-layer-{{layer_dep}}-{{branch}}
{% else %}
Requires: metwork-{{module_dep}}-layer-{{layer_dep}}-{{branch}} = {{FULL_VERSION}}
{% endif -%}
{% endif -%}
{% else -%}
# Do not specify version for layers out of the current module
Requires: metwork-{{module_dep}}-layer-{{layer_dep}}-{{branch}}
{% endif -%}
{% if layer == "scientific" and MODULE_LOWERCASE == "mfext" -%}
#Add "scientific" system dependencies (specified in meta layer scientific)
Requires: metwork-mfext-scientific-{{MFEXT_BRANCH}} = {{FULL_VERSION}}
{% endif -%}
{% if layer == "python2" and MODULE_LOWERCASE == "mfserv" -%}
Provides: metwork-mfserv-python2 = {{FULL_VERSION}}
Provides: metwork-mfserv-python2-{{MODULE_LOWERCASE}} = {{FULL_VERSION}}
{% endif -%}
{% if layer == "nodejs" and MODULE_LOWERCASE == "mfserv" -%}
Provides: metwork-mfserv-nodejs = {{FULL_VERSION}}
Provides: metwork-mfserv-nodejs-{{MODULE_LOWERCASE}} = {{FULL_VERSION}}
{% endif -%}
{% if layer == "python2" and MODULE_LOWERCASE == "mfdata" -%}
Provides: metwork-mfdata-python2 = {{FULL_VERSION}}
Provides: metwork-mfdata-python2-{{MODULE_LOWERCASE}} = {{FULL_VERSION}}
{% endif -%}
# Every single layer rpm must have the minimal module rpm in dependency
# to prevent single layer installation
{% if MFEXT_ADDON == "1" %}
Requires: metwork-{{MODULE_LOWERCASE}}-minimal-{{MODULE_BRANCH}}
{% else %}
Requires: metwork-{{MODULE_LOWERCASE}}-minimal-{{MODULE_BRANCH}} = {{FULL_VERSION}}
{% endif -%}
{% endfor -%}
%description layer-{{layer}}-{{MODULE_BRANCH}}
metwork {{MODULE_LOWERCASE}} {{layer}} layer
{% endfor -%}

{% if MFEXT_ADDON == "0" %}
{% if MODULE == "MFEXT" -%}
%package devtools-{{MFEXT_BRANCH}}
Summary: metwork {{MODULE_LOWERCASE}} meta devtools layers
Group: Applications/Multimedia
AutoReq: no
AutoProv: no
Requires: metwork-mfext-layer-devtools-{{MFEXT_BRANCH}} = {{FULL_VERSION}}
Requires: metwork-mfext-layer-python3_devtools-{{MFEXT_BRANCH}} = {{FULL_VERSION}}
Requires: metwork-mfext-layer-python3_devtools_jupyter-{{MFEXT_BRANCH}} = {{FULL_VERSION}}
Provides: metwork-mfext-devtools = {{FULL_VERSION}}
%description devtools-{{MFEXT_BRANCH}}
metwork {{MODULE_LOWERCASE}} meta devtools layers

%package scientific-{{MFEXT_BRANCH}}
Summary: metwork {{MODULE_LOWERCASE}} meta scientific layers
Group: Applications/Multimedia
AutoReq: no
AutoProv: no
Requires: metwork-mfext-layer-scientific-{{MFEXT_BRANCH}} = {{FULL_VERSION}}
Requires: metwork-mfext-layer-python3_scientific-{{MFEXT_BRANCH}} = {{FULL_VERSION}}
Requires: libX11 libXext pango fontconfig freetype libgfortran libgomp libjpeg-turbo atlas libpng
Provides: metwork-mfext-scientific = {{FULL_VERSION}}
{% if METWORK_BUILD_OS|default('unknown') == "centos7" -%}
Requires: libquadmath
{% endif -%}
%description scientific-{{MFEXT_BRANCH}}
metwork {{MODULE_LOWERCASE}} meta scientific layers

%package python2-{{MFEXT_BRANCH}}
Summary: metwork {{MODULE_LOWERCASE}} python2 layers
Group: Applications/Multimedia
AutoReq: no
AutoProv: no
Requires: metwork-mfext-layer-python2-{{MFEXT_BRANCH}} = {{FULL_VERSION}}
Requires: metwork-mfext-layer-python2_scientific-{{MFEXT_BRANCH}} = {{FULL_VERSION}}
Requires: metwork-mfext-layer-python2_devtools-{{MFEXT_BRANCH}} = {{FULL_VERSION}}
Provides: metwork-mfext-python2 = {{FULL_VERSION}}
%description python2-{{MFEXT_BRANCH}}
Alias for python2 layers

{% endif -%}
{% endif -%}

%prep
cd %{_builddir} || exit 1
rm -Rf %{name}-%{version}-%{release}
rm -Rf {{MODULE_LOWERCASE}}-%{version}-%{release}
cat %{_sourcedir}/{{MODULE_LOWERCASE}}-%{version}-%{release}-linux64.tar | tar -xf -
mkdir %{name}-%{version}-%{release}
mv {{MODULE_LOWERCASE}}-%{version}-%{release} %{name}-%{version}-%{release}/
cd %{name}-%{version}-%{release}
rm -f mf*_link

{% if MFEXT_ADDON == "0" %}
{% if MODULE_HAS_HOME_DIR == "1" -%}
%pre layer-root-{{MODULE_BRANCH}}
N=`cat /etc/group |grep '^metwork:' |wc -l`
if test ${N} -eq 0; then
  groupadd metwork >/dev/null 2>&1 || true
fi
N=`cat /etc/passwd |grep '^{{MODULE_LOWERCASE}}:' |wc -l`
if test ${N} -eq 0; then
  useradd -d /home/{{MODULE_LOWERCASE}} -g metwork -s /bin/bash {{MODULE_LOWERCASE}} >/dev/null 2>&1 || true
  echo {{MODULE_LOWERCASE}} |passwd --stdin {{MODULE_LOWERCASE}} >/dev/null 2>&1 || true
  {% if MODULE == "MFDATA" -%}
     useradd -M -d /home/{{MODULE_LOWERCASE}}/var/in -g metwork -s /sbin/nologin depose >/dev/null 2>&1 || true
     echo depose |passwd --stdin {{MODULE_LOWERCASE}} >/dev/null 2>&1 || true
     chmod g+rx /home/{{MODULE_LOWERCASE}} >/dev/null 2>&1 || true
  {% endif -%}
  rm -Rf /home/{{MODULE_LOWERCASE}}
  chown -R {{MODULE_LOWERCASE}}:metwork /home/{{MODULE_LOWERCASE}}.rpmsave* >/dev/null 2>&1 || true
fi
{% endif -%}
{% endif %}

%build

%install
mkdir -p %{buildroot}/{{MODULE_HOME}} 2>/dev/null
ln -s {{MODULE_HOME}} %{buildroot}{{TARGET_LINK}}
{% if MODULE_HAS_HOME_DIR == "1" -%}
mkdir -p %{buildroot}/home/{{MODULE_LOWERCASE}} 2>/dev/null
{% endif -%}
mv metwork-{{MODULE_LOWERCASE}}-%{version}-%{release}/{{MODULE_LOWERCASE}}-%{version}-%{release}/* %{buildroot}{{MODULE_HOME}}/
mv metwork-{{MODULE_LOWERCASE}}-%{version}-%{release}/{{MODULE_LOWERCASE}}-%{version}-%{release}/.layerapi2* %{buildroot}{{MODULE_HOME}}/ 2>/dev/null || true
rm -Rf %{buildroot}{{MODULE_HOME}}/html_doc
{% if MODULE_HAS_HOME_DIR == "1" -%}
ln -s {{MODULE_HOME}}/share/bashrc %{buildroot}/home/{{MODULE_LOWERCASE}}/.bashrc
ln -s {{MODULE_HOME}}/share/bash_profile %{buildroot}/home/{{MODULE_LOWERCASE}}/.bash_profile
chmod -R go-rwx %{buildroot}/home/{{MODULE_LOWERCASE}}
chmod -R u+rX %{buildroot}/home/{{MODULE_LOWERCASE}}
{% if MODULE == "MFDATA" -%}
chmod g+rx %{buildroot}/home/{{MODULE_LOWERCASE}}
{% endif -%}
{% endif -%}
chmod -R a+rX %{buildroot}{{MODULE_HOME}}
rm -Rf %{_builddir}/%{name}-%{version}-%{release} 2>/dev/null
{% if MODULE == "MFCOM" -%}
mkdir -p %{buildroot}/etc/security/limits.d/
cat >%{buildroot}/etc/security/limits.d/50-metwork.conf <<EOF
@metwork    soft    nofile  65536
@metwork    hard    nofile  65536
@metwork    soft    nproc  100000
@metwork    hard    nproc  100000
EOF
{% endif -%}

{% if MFEXT_ADDON == "0" %}
%post layer-root-{{MODULE_BRANCH}}
if test -f /etc/metwork.config; then
  touch /etc/metwork.config >/dev/null 2>&1
fi
if ! test -d /etc/metwork.config.d/{{MODULE_LOWERCASE}}; then
    mkdir -p /etc/metwork.config.d/{{MODULE_LOWERCASE}}
    {% if MODULE == "MFDATA" -%}
        mkdir -p /etc/metwork.config.d/{{MODULE_LOWERCASE}}/external_plugins
    {% elif MODULE == "MFSERV" -%}
        mkdir -p /etc/metwork.config.d/{{MODULE_LOWERCASE}}/external_plugins
    {% elif MODULE == "MFBASE" -%}
        mkdir -p /etc/metwork.config.d/{{MODULE_LOWERCASE}}/external_plugins
    {% endif -%}
fi
if ! test -f /etc/metwork.config; then
    echo GENERIC >/etc/metwork.config
fi
{% if MODULE != "MFCOM" and MODULE != "MFEXT" -%}
  if ! test -d /etc/rc.d/init.d; then mkdir -p /etc/rc.d/init.d; fi
  cp -f {{MFCOM_HOME}}/bin/metwork /etc/rc.d/init.d/metwork >/dev/null 2>&1
  chmod 0755 /etc/rc.d/init.d/metwork
  chown root:root /etc/rc.d/init.d/metwork
  if test `/sbin/chkconfig --list metwork 2>/dev/null |wc -l` -eq 0; then
    /sbin/chkconfig --add metwork >/dev/null 2>&1
  fi
{% endif -%}
{% if MODULE == "MFDATA" -%}
   mkdir -p /home/{{MODULE_LOWERCASE}}/var/in >/dev/null 2>&1
   chown -R {{MODULE_LOWERCASE}}:metwork /home/{{MODULE_LOWERCASE}}/var >/dev/null 2>&1
   chmod g+rX /home/{{MODULE_LOWERCASE}} >/dev/null 2>&1
   chmod g+rX /home/{{MODULE_LOWERCASE}}/var >/dev/null 2>&1
   chmod g+rX /home/{{MODULE_LOWERCASE}}/var/in >/dev/null 2>&1
{% endif -%}

%postun layer-root-{{MODULE_BRANCH}}
if [ "$1" = "0" ]; then # last uninstall only
  rm -Rf {{TARGET_LINK}} 2>/dev/null
  rm -Rf {{MODULE_HOME}} 2>/dev/null
  # see https://stackoverflow.com/questions/40396945/
  # date-command-is-giving-erroneous-output-while-using-inside-rpm-spec-file
  export SAVE_SUFFIX="rpmsave`date '+%Y%m%d%H%M%''S'`"
  {% if MODULE_HAS_HOME_DIR == "1" -%}
  if test -d /home/{{MODULE_LOWERCASE}}; then
    echo "Saving old /home/{{MODULE_LOWERCASE}} to /home/{{MODULE_LOWERCASE}}.${SAVE_SUFFIX} ..."
    mv /home/{{MODULE_LOWERCASE}} /home/{{MODULE_LOWERCASE}}.${SAVE_SUFFIX}
    rm -Rf /home/{{MODULE_LOWERCASE}}.${SAVE_SUFFIX}/log
    rm -Rf /home/{{MODULE_LOWERCASE}}.${SAVE_SUFFIX}/tmp
    {% if MODULE == "MFDATA" -%}
      rm -Rf /home/{{MODULE_LOWERCASE}}.${SAVE_SUFFIX}/var/in
    {% endif %}
    mkdir /home/{{MODULE_LOWERCASE}}
  fi
  userdel -f -r {{MODULE_LOWERCASE}} 2>/dev/null
  rm -Rf /home/{{MODULE_LOWERCASE}} 2>/dev/null
  {% endif -%}
  {% if MODULE == "MFCOM" -%}
    rm -f /etc/rc.d/init.d/metwork >/dev/null 2>&1
  {% endif -%}
  N=`find /etc/metwork.config.d/{{MODULE_LOWERCASE}} -type f 2>/dev/null |wc -l`
  if test ${N} -gt 0; then
      echo "Saving old /etc/metwork.config.d/{{MODULE_LOWERCASE}} to /etc/metwork.config.d/{{MODULE_LOWERCASE}}.${SAVE_SUFFIX} ..."
      mv /etc/metwork.config.d/{{MODULE_LOWERCASE}} /etc/metwork.config.d/{{MODULE_LOWERCASE}}.${SAVE_SUFFIX}
  fi
  rm -Rf /etc/metwork.config.d/{{MODULE_LOWERCASE}}
fi
{% endif -%}

%clean
rm -fr %{buildroot}

%files
%defattr(-,root,root,-)
{{TARGET_LINK}}

{% if MFEXT_ADDON == "0" %}
%files minimal
%defattr(-,root,root,-)
{{TARGET_LINK}}

%files minimal-{{MODULE_BRANCH}}
%defattr(-,root,root,-)

%files layer-root-{{MODULE_BRANCH}}
%defattr(-,root,root,-)
{% if MODULE_HAS_HOME_DIR == "1" -%}
%defattr(-,{{MODULE_LOWERCASE}},metwork,-)
/home/{{MODULE_LOWERCASE}}
{% endif -%}
{% for fic_or_repo in root_list -%}
{{MODULE_HOME}}/{{fic_or_repo}}
{% endfor -%}
{% if MODULE == "MFCOM" -%}
/etc/security/limits.d/50-metwork.conf
{% endif -%}
{% endif %}

{% for layer in full_layers_list -%}
%files layer-{{layer}}-{{MODULE_BRANCH}}
%defattr(-,root,root,-)
{{MODULE_HOME}}/opt/{{layer}}

{% endfor -%}

{% if MFEXT_ADDON == "0" %}
{% if MODULE == "MFEXT" -%}
%files devtools-{{MFEXT_BRANCH}}
%defattr(-,root,root,-)

%files scientific-{{MFEXT_BRANCH}}
%defattr(-,root,root,-)

%files python2-{{MFEXT_BRANCH}}
%defattr(-,root,root,-)
{% endif -%}
{% endif %}
