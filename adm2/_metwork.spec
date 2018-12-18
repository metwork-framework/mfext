{% set MFEXT_BRANCH = MFEXT_VERSION.split('.')[0:-2]|join('.') -%}
{% if MODULE != "MFEXT" -%}
{% set MFCOM_BRANCH = MFCOM_VERSION.split('.')[0:-2]|join('.') -%}
{% endif -%}
{% set MODULE_BRANCH = MODULE_VERSION.split('.')[0:-2]|join('.') -%}
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
{% set liste2 = 'cd $MODULE_HOME/opt; ls -d *'|shell -%}
{% set layers_list = liste2.split('\n')[:-1] -%}

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
Obsoletes: metwork-{{MODULE_LOWERCASE}}-full
{% if MODULE == "MFEXT" -%}
Requires: metwork-mfext-core-{{MFEXT_BRANCH}} = {{FULL_VERSION}}, metwork-mfext-python2-{{MFEXT_BRANCH}} = {{FULL_VERSION}}, metwork-mfext-devtools-{{MFEXT_BRANCH}} = {{FULL_VERSION}}, metwork-mfext-python2-devtools-{{MFEXT_BRANCH}} = {{FULL_VERSION}}, metwork-mfext-scientific-{{MFEXT_BRANCH}} = {{FULL_VERSION}}, metwork-mfext-python2-scientific-{{MFEXT_BRANCH}} = {{FULL_VERSION}}, metwork-mfext-nodejs-{{MFEXT_BRANCH}} = {{FULL_VERSION}}, metwork-mfext-mapserver-{{MFEXT_BRANCH}} = {{FULL_VERSION}}, metwork-mfext-monitoring-{{MFEXT_BRANCH}} = {{FULL_VERSION}}
{% else -%}
Requires: metwork-mfext
{% if MODULE == "MFCOM" -%}
Requires: metwork-mfcom-core-{{MFCOM_BRANCH}} = {{FULL_VERSION}}, metwork-mfcom-python2-{{MFEXT_BRANCH}} = {{FULL_VERSION}}
{% else -%}
Requires: metwork-mfcom
{% if MODULE == "MFDATA" -%}
Requires: metwork-mfdata-core-{{MODULE_BRANCH}} = {{FULL_VERSION}}, metwork-mfdata-python2-{{MODULE_BRANCH}} = {{FULL_VERSION}}
{% else -%}
{% if MODULE == "MFSERV" -%}
Requires: metwork-mfserv-core-{{MODULE_BRANCH}} = {{FULL_VERSION}}, metwork-mfserv-python2-{{MODULE_BRANCH}} = {{FULL_VERSION}}, metwork-mfserv-nodejs-{{MODULE_BRANCH}}
{% else -%}
Requires: metwork-{{MODULE_LOWERCASE}}-core-{{MODULE_BRANCH}} = {{FULL_VERSION}}
{% endif -%}
{% endif -%}
{% endif -%}
{% endif -%}

%description
This package provides the full {{MODULE_LOWERCASE}} module of the metwork framework

%package layer-root-{{MODULE_BRANCH}}
Summary: metwork {{MODULE_LOWERCASE}} root layer
Group: Applications/Multimedia
AutoReq: no
AutoProv: no
{% if MODULE == "MFEXT" -%}
{% if METWORK_BUILD_OS|default('unknown') == "centos7" -%}
Requires: openssl >= 1.0.2
Requires: openssl-libs >= 1.0.2
#Fixme : libgfortran because numpy is installed in layers python2[3]
#rather than in layers python2[3]_scientific
Requires: libgfortran
Requires: libicu
{% else -%}
Requires: openssl
{% endif -%}
Requires: which
Requires: /usr/bin/lscpu
{% endif -%}
%description layer-root-{{MODULE_BRANCH}}
metwork {{MODULE_LOWERCASE}} root layer

{% for layer in layers_list -%}
%package layer-{{layer}}-{{MODULE_BRANCH}}
Summary: metwork {{MODULE_LOWERCASE}} {{layer}} layer
Group: Applications/Multimedia
AutoReq: no
AutoProv: no
{% set liste = 'cd $MODULE_HOME; ls -da * .layerapi2*|grep -v opt'|shell -%}
{% set cmd = 'cat ' + MODULE_HOME + '/opt/' + layer + '/.layerapi2_dependencies| grep -v "^-" | grep -v "{"'  -%}
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
Requires: metwork-{{module_dep}}-layer-{{layer_dep}}-{{branch}}
{% endfor -%}
%description layer-{{layer}}-{{MODULE_BRANCH}}
metwork {{MODULE_LOWERCASE}} {{layer}} layer
{% endfor -%}


%package core-{{MODULE_BRANCH}}
Summary: metwork {{MODULE_LOWERCASE}} meta core layers
Group: Applications/Multimedia
AutoReq: no
AutoProv: no
{% if MODULE == "MFEXT" -%}
Requires: metwork-mfext-layer-root-{{MFEXT_BRANCH}}
Requires: metwork-mfext-layer-core-{{MFEXT_BRANCH}}
Requires: metwork-mfext-layer-default-{{MFEXT_BRANCH}}
Requires: metwork-mfext-layer-python-{{MFEXT_BRANCH}}
Requires: metwork-mfext-layer-openresty-{{MFEXT_BRANCH}}
Requires: metwork-mfext-layer-python3-{{MFEXT_BRANCH}}
Requires: metwork-mfext-layer-python3_core-{{MFEXT_BRANCH}}
Requires: metwork-mfext-layer-python3_circus-{{MFEXT_BRANCH}}
Requires: metwork-mfext-layer-rpm-{{MFEXT_BRANCH}}
{% elif MODULE == "MFCOM" -%}
Requires: metwork-mfext-core-{{MFEXT_BRANCH}}
Requires: metwork-mfcom-layer-root-{{MFCOM_BRANCH}}
Requires: metwork-mfcom-layer-python3-{{MFCOM_BRANCH}}
{% elif MODULE == "MFDATA" or MODULE == "MFSERV" -%}
Requires: metwork-mfcom-core-{{MFCOM_BRANCH}}
Requires: metwork-{{MODULE_LOWERCASE}}-layer-root-{{MODULE_BRANCH}}
Requires: metwork-{{MODULE_LOWERCASE}}-layer-python3-{{MODULE_BRANCH}}
{% else -%}
Requires: metwork-mfcom-core-{{MFCOM_BRANCH}}
Requires: metwork-{{MODULE_LOWERCASE}}-layer-root-{{MODULE_BRANCH}}
{% for layer in layers_list -%}
Requires: metwork-{{MODULE_LOWERCASE}}-layer-{{layer}}-{{MODULE_BRANCH}}
{% endfor -%}
{% endif -%}
%description core-{{MODULE_BRANCH}}
metwork {{MODULE_LOWERCASE}} meta core layers

{% if MODULE == "MFCOM" or MODULE == "MFDATA" or MODULE == "MFEXT" or MODULE == "MFSERV" -%}
%package python2-{{MODULE_BRANCH}}
Summary: metwork {{MODULE_LOWERCASE}} meta python2 layers
Group: Applications/Multimedia
AutoReq: no
AutoProv: no
Requires: metwork-{{MODULE_LOWERCASE}}-layer-python2-{{MODULE_BRANCH}}
%description python2-{{MODULE_BRANCH}}
metwork {{MODULE_LOWERCASE}} meta python2 layers
{% endif -%}

{% if MODULE == "MFSERV" -%}
%package nodejs-{{MODULE_BRANCH}}
Summary: metwork {{MODULE_LOWERCASE}} meta nodejs layers
Group: Applications/Multimedia
AutoReq: no
AutoProv: no
Requires: metwork-{{MODULE_LOWERCASE}}-layer-nodejs-{{MODULE_BRANCH}}
%description nodejs-{{MODULE_BRANCH}}
metwork {{MODULE_LOWERCASE}} meta nodejs layers
{% endif -%}

{% if MODULE == "MFEXT" -%}
%package devtools-{{MFEXT_BRANCH}}
Summary: metwork {{MODULE_LOWERCASE}} meta devtools layers
Group: Applications/Multimedia
AutoReq: no
AutoProv: no
Requires: metwork-mfext-layer-devtools-{{MFEXT_BRANCH}}
Requires: metwork-mfext-layer-python3_devtools-{{MFEXT_BRANCH}}
Requires: metwork-mfext-layer-python3_devtools_jupyter-{{MFEXT_BRANCH}}
%description devtools-{{MFEXT_BRANCH}}
metwork {{MODULE_LOWERCASE}} meta devtools layers

%package python2-devtools-{{MFEXT_BRANCH}}
Summary: metwork {{MODULE_LOWERCASE}} meta python2 devtools layers
Group: Applications/Multimedia
AutoReq: no
AutoProv: no
Requires: metwork-mfext-layer-python2_devtools-{{MFEXT_BRANCH}}
%description python2-devtools-{{MFEXT_BRANCH}}
metwork {{MODULE_LOWERCASE}} meta python2 devtools layers

%package scientific-{{MFEXT_BRANCH}}
Summary: metwork {{MODULE_LOWERCASE}} meta scientific layers
Group: Applications/Multimedia
AutoReq: no
AutoProv: no
Requires: metwork-mfext-layer-scientific-{{MFEXT_BRANCH}}
Requires: metwork-mfext-layer-python3_scientific-{{MFEXT_BRANCH}}
Requires: libX11 libXext pango fontconfig freetype libgfortran libgomp libjpeg-turbo atlas libpng
{% if METWORK_BUILD_OS|default('unknown') == "centos7" -%}
Requires: libquadmath
{% endif -%}
%description scientific-{{MFEXT_BRANCH}}
metwork {{MODULE_LOWERCASE}} meta scientific layers

%package nodejs-{{MFEXT_BRANCH}}
Summary: metwork {{MODULE_LOWERCASE}} meta nodejs layers
Group: Applications/Multimedia
AutoReq: no
AutoProv: no
Requires: metwork-mfext-layer-nodejs-{{MFEXT_BRANCH}}
%description nodejs-{{MFEXT_BRANCH}}
metwork {{MODULE_LOWERCASE}} meta nodejs layers

%package java-{{MFEXT_BRANCH}}
Summary: metwork {{MODULE_LOWERCASE}} meta java layers
Group: Applications/Multimedia
AutoReq: no
AutoProv: no
Requires: metwork-mfext-layer-java-{{MFEXT_BRANCH}}
%description java-{{MFEXT_BRANCH}}
metwork {{MODULE_LOWERCASE}} meta java layers

%package mapserver-{{MFEXT_BRANCH}}
Summary: metwork {{MODULE_LOWERCASE}} meta mapserver layers
Group: Applications/Multimedia
AutoReq: no
AutoProv: no
Requires: metwork-mfext-layer-mapserver-{{MFEXT_BRANCH}}
%description mapserver-{{MFEXT_BRANCH}}
metwork {{MODULE_LOWERCASE}} meta mapserver layers

%package python2-scientific-{{MFEXT_BRANCH}}
Summary: metwork {{MODULE_LOWERCASE}} meta python2 scientific layers
Group: Applications/Multimedia
AutoReq: no
AutoProv: no
Requires: metwork-mfext-layer-python2_scientific-{{MFEXT_BRANCH}}
%description python2-scientific-{{MFEXT_BRANCH}}
metwork {{MODULE_LOWERCASE}} meta python2 scientific layers

%package monitoring-{{MFEXT_BRANCH}}
Summary: metwork {{MODULE_LOWERCASE}} meta monitoring layers
Group: Applications/Multimedia
AutoReq: no
AutoProv: no
Requires: metwork-mfext-layer-monitoring-{{MFEXT_BRANCH}}
%description monitoring-{{MFEXT_BRANCH}}
metwork {{MODULE_LOWERCASE}} meta monitoring layers
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

{% if MODULE_HAS_HOME_DIR == "1" -%}
%pre layer-root-{{MODULE_BRANCH}}
N=`cat /etc/group |grep '^metwork:' |wc -l`
if test ${N} -eq 0; then
  groupadd metwork >/dev/null 2>&1
  N=`cat /etc/group |grep '^metwork:' |wc -l`
  if test ${N} -eq 0; then
    echo "ERROR: impossible to create the metwork group"
    exit 1
  fi
fi
N=`cat /etc/passwd |grep '^{{MODULE_LOWERCASE}}:' |wc -l`
if test ${N} -eq 0; then
  useradd -d /home/{{MODULE_LOWERCASE}} -g metwork -s /bin/bash {{MODULE_LOWERCASE}} >/dev/null 2>&1
  echo {{MODULE_LOWERCASE}} |passwd --stdin {{MODULE_LOWERCASE}} >/dev/null 2>&1
  {% if MODULE == "MFDATA" -%}
     useradd -M -d /home/{{MODULE_LOWERCASE}}/var/in -g metwork -s /sbin/nologin depose >/dev/null 2>&1
     echo depose |passwd --stdin {{MODULE_LOWERCASE}} >/dev/null 2>&1
     chmod g+rx /home/{{MODULE_LOWERCASE}} >/dev/null 2>&1
  {% endif -%}
  N=`cat /etc/passwd |grep '^{{MODULE_LOWERCASE}}:' |wc -l`
  if test ${N} -eq 0; then
    echo "ERROR: impossible to create the {{MODULE_LOWERCASE}} user"
    exit 1
  fi
  rm -Rf /home/{{MODULE_LOWERCASE}}
fi
{% endif -%}

%build

%install
mkdir -p %{buildroot}/{{MODULE_HOME}} 2>/dev/null
ln -s {{MODULE_HOME}} %{buildroot}{{TARGET_LINK}}
{% if MODULE_HAS_HOME_DIR == "1" -%}
mkdir -p %{buildroot}/home/{{MODULE_LOWERCASE}} 2>/dev/null
{% endif -%}
mv metwork-{{MODULE_LOWERCASE}}-%{version}-%{release}/{{MODULE_LOWERCASE}}-%{version}-%{release}/* %{buildroot}{{MODULE_HOME}}/
mv metwork-{{MODULE_LOWERCASE}}-%{version}-%{release}/{{MODULE_LOWERCASE}}-%{version}-%{release}/.layerapi2* %{buildroot}{{MODULE_HOME}}/
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
  {% if MODULE_HAS_HOME_DIR == "1" -%}
  userdel -f -r {{MODULE_LOWERCASE}} 2>/dev/null
  rm -Rf /home/{{MODULE_LOWERCASE}} 2>/dev/null
  {% endif -%}
  {% if MODULE == "MFCOM" -%}
    rm -f /etc/rc.d/init.d/metwork >/dev/null 2>&1
  {% endif -%}
  rm -Rf /etc/metwork.config.d/{{MODULE_LOWERCASE}}
fi

%clean
rm -fr %{buildroot}

%files
%defattr(-,root,root,-)
# FIXME: try to avoid to hardcode /opt here
{{TARGET_LINK}}

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

{% for layer in layers_list -%}
%files layer-{{layer}}-{{MODULE_BRANCH}}
%defattr(-,root,root,-)
{{MODULE_HOME}}/opt/{{layer}}
{% endfor -%}

%files core-{{MFEXT_BRANCH}}
%defattr(-,root,root,-)

{% if MODULE == "MFEXT" -%}
%files devtools-{{MFEXT_BRANCH}}
%defattr(-,root,root,-)

%files python2-devtools-{{MFEXT_BRANCH}}
%defattr(-,root,root,-)

%files scientific-{{MFEXT_BRANCH}}
%defattr(-,root,root,-)

%files nodejs-{{MFEXT_BRANCH}}
%defattr(-,root,root,-)

%files mapserver-{{MFEXT_BRANCH}}
%defattr(-,root,root,-)

%files java-{{MFEXT_BRANCH}}
%defattr(-,root,root,-)

%files python2-scientific-{{MFEXT_BRANCH}}
%defattr(-,root,root,-)

%files monitoring-{{MFEXT_BRANCH}}
%defattr(-,root,root,-)
{% endif -%}

{% if MODULE == "MFSERV" -%}
%files nodejs-{{MODULE_BRANCH}}
%defattr(-,root,root,-)
{% endif -%}

{% if MODULE == "MFEXT" or MODULE == "MFCOM" or MODULE == "MFDATA" or MODULE == "MFSERV" -%}
%files python2-{{MODULE_BRANCH}}
%defattr(-,root,root,-)
{% endif -%}
