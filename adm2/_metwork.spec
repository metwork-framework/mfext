{% set MFEXT_BRANCH = MFEXT_VERSION.split('.')[0:-2]|join('.') %}
{% if MODULE != "MFEXT" %}
{% set MFCOM_BRANCH = MFCOM_VERSION.split('.')[0:-2]|join('.') %}
{% endif %}
{% set MODULE_BRANCH = MODULE_VERSION.split('.')[0:-2]|join('.') %}
%define __jar_repack %{nil}
%define __os_install_post %{nil}
%define debug_package %{nil}
{% set version_release = [VERSION_BUILD, RELEASE_BUILD] %}
{% set version_release_string = version_release|join('-') %}
{% set epoch_vr = [EPOCH, version_release_string] %}
{% set FULL_VERSION = epoch_vr|join(':') %}

Name: metwork-{{MODULE_LOWERCASE}}
Summary: metwork {{MODULE_LOWERCASE}} module
Version: {{VERSION_BUILD}}
Release: {{RELEASE_BUILD}}
Epoch: {{EPOCH}}
License: Meteo
Source0: {{MODULE_LOWERCASE}}-{{VERSION_BUILD}}-{{RELEASE_BUILD}}-linux64.tar.bz2
Group: Applications/Multimedia
URL: http://metwork.meteo.fr
Buildroot: %{_topdir}/tmp/%{name}-root
Packager: Fabien MARTY <fabien.marty@meteo.fr>
Vendor: Metwork
ExclusiveOs: linux
AutoReq: no
AutoProv: no
Obsoletes: metwork-{{MODULE_LOWERCASE}}-full
{% if MODULE == "MFEXT" %}
Requires: which
Requires: metwork-mfext-core-{{MFEXT_BRANCH}} = {{FULL_VERSION}}, metwork-mfext-python2-{{MFEXT_BRANCH}} = {{FULL_VERSION}}, metwork-mfext-devtools-{{MFEXT_BRANCH}} = {{FULL_VERSION}}, metwork-mfext-python2-devtools-{{MFEXT_BRANCH}} = {{FULL_VERSION}}, metwork-mfext-scientific-{{MFEXT_BRANCH}}, metwork-mfext-python2-scientific-{{MFEXT_BRANCH}}, metwork-mfext-nodejs-{{MFEXT_BRANCH}}, metwork-mfext-mapserver-{{MFEXT_BRANCH}}
{% if METWORK_BUILD_OS|default('unknown') == "centos7" %}
Requires: openssl >= 1.0.2
Requires: openssl-libs >= 1.0.2
{% else %}
Requires: openssl
{% endif %}
{% else %}
Requires: metwork-mfext
{% if MODULE == "MFCOM" %}
Requires: metwork-mfcom-core-{{MFCOM_BRANCH}} = {{FULL_VERSION}}, metwork-mfcom-python2-{{MFEXT_BRANCH}} = {{FULL_VERSION}}
{% else %}
Requires: metwork-mfcom
{% if MODULE == "MFDATA" %}
Requires: metwork-mfdata-core-{{MODULE_BRANCH}} = {{FULL_VERSION}}, metwork-mfdata-python2-{{MODULE_BRANCH}} = {{FULL_VERSION}}
{% else %}
{% if MODULE == "MFSERV" %}
Requires: metwork-mfserv-core-{{MODULE_BRANCH}} = {{FULL_VERSION}}, metwork-mfserv-python2-{{MODULE_BRANCH}} = {{FULL_VERSION}}, metwork-mfserv-nodejs-{{MODULE_BRANCH}}
{% else %}
Requires: metwork-{{MODULE_LOWERCASE}}-core-{{MODULE_BRANCH}} = {{FULL_VERSION}}
{% endif %}
{% endif %}
{% endif %}
{% endif %}

%description
This package provides the full {{MODULE_LOWERCASE}} module of the metwork framework

%package core-{{MODULE_BRANCH}}
Summary: metwork {{MODULE_LOWERCASE}} core layer
Group: Applications/Multimedia
AutoReq: no
AutoProv: no
{% if MODULE == "MFEXT" %}
{% if METWORK_BUILD_OS|default('unknown') == "centos7" %}
#Fixme : libgfortran because numpy is installed in layers python2[3]
#rather than in layers python2[3]_scientific
Requires: libgfortran
Requires: libicu
{% endif %}
{% elif MODULE == "MFCOM" %}
Requires: metwork-mfext-core-{{MFEXT_BRANCH}}
{% else %}
Requires: metwork-mfcom-core-{{MFCOM_BRANCH}}
{% endif %}
%description core-{{MODULE_BRANCH}}
metwork {{MODULE_LOWERCASE}} core layer

{% if MODULE == "MFCOM" or MODULE == "MFDATA" or MODULE == "MFEXT" or MODULE == "MFSERV" %}
%package python2-{{MODULE_BRANCH}}
Summary: metwork {{MODULE_LOWERCASE}} python2 layer
Group: Applications/Multimedia
AutoReq: no
AutoProv: no
Requires: metwork-{{MODULE_LOWERCASE}}-core-{{MODULE_BRANCH}}
{% if MODULE == "MFEXT" %}
{% elif MODULE == "MFCOM" %}
Requires: metwork-mfext-python2-{{MFEXT_BRANCH}}
{% else %}
Requires: metwork-mfcom-python2-{{MFCOM_BRANCH}}
{% endif %}
%description python2-{{MODULE_BRANCH}}
metwork {{MODULE_LOWERCASE}} python2 layer
{% endif %}

{% if MODULE == "MFSERV" %}
%package nodejs-{{MODULE_BRANCH}}
Summary: metwork {{MODULE_LOWERCASE}} nodejs layer
Group: Applications/Multimedia
AutoReq: no
AutoProv: no
Requires: metwork-{{MODULE_LOWERCASE}}-core-{{MODULE_BRANCH}}
Requires: metwork-mfext-nodejs-{{MFEXT_BRANCH}}
%description nodejs-{{MODULE_BRANCH}}
metwork {{MODULE_LOWERCASE}} nodejs layer
{% endif %}

{% if MODULE == "MFEXT" %}
%package devtools-{{MFEXT_BRANCH}}
Summary: metwork {{MODULE_LOWERCASE}} devtools layer
Group: Applications/Multimedia
AutoReq: no
AutoProv: no
Requires: metwork-mfext-core-{{MFEXT_BRANCH}}
%description devtools-{{MFEXT_BRANCH}}
metwork {{MODULE_LOWERCASE}} devtools layer

%package python2-devtools-{{MFEXT_BRANCH}}
Summary: metwork {{MODULE_LOWERCASE}} python2 devtools layer
Group: Applications/Multimedia
AutoReq: no
AutoProv: no
Requires: metwork-mfext-python2-{{MFEXT_BRANCH}}
Requires: metwork-mfext-devtools-{{MFEXT_BRANCH}}
%description python2-devtools-{{MFEXT_BRANCH}}
metwork {{MODULE_LOWERCASE}} python2 devtools layer

%package scientific-{{MFEXT_BRANCH}}
Summary: metwork {{MODULE_LOWERCASE}} scientific layer
Group: Applications/Multimedia
AutoReq: no
AutoProv: no
Requires: metwork-mfext-core-{{MFEXT_BRANCH}}
Requires: libX11 libXext pango fontconfig freetype libgfortran libgomp libjpeg-turbo atlas libpng
{% if METWORK_BUILD_OS|default('unknown') == "centos7" %}
Requires: libquadmath
{% endif %}
%description scientific-{{MFEXT_BRANCH}}
metwork {{MODULE_LOWERCASE}} scientific layer

%package nodejs-{{MFEXT_BRANCH}}
Summary: metwork {{MODULE_LOWERCASE}} nodejs layer
Group: Applications/Multimedia
AutoReq: no
AutoProv: no
Requires: metwork-mfext-core-{{MFEXT_BRANCH}}
%description nodejs-{{MFEXT_BRANCH}}
metwork {{MODULE_LOWERCASE}} nodejs layer

%package mapserver-{{MFEXT_BRANCH}}
Summary: metwork {{MODULE_LOWERCASE}} mapserver layer
Group: Applications/Multimedia
AutoReq: no
AutoProv: no
Requires: metwork-mfext-core-{{MFEXT_BRANCH}}, metwork-mfext-scientific-{{MFEXT_BRANCH}}
%description mapserver-{{MFEXT_BRANCH}}
metwork {{MODULE_LOWERCASE}} mapserver layer

%package python2-scientific-{{MFEXT_BRANCH}}
Summary: metwork {{MODULE_LOWERCASE}} python2 scientific layer
Group: Applications/Multimedia
AutoReq: no
AutoProv: no
Requires: metwork-mfext-python2-{{MFEXT_BRANCH}}
Requires: metwork-mfext-scientific-{{MFEXT_BRANCH}}
%description python2-scientific-{{MFEXT_BRANCH}}
metwork {{MODULE_LOWERCASE}} python2 scientific layer

%package integration-tests-{{MFEXT_BRANCH}}
Summary: metwork {{MODULE_LOWERCASE}} integration-tests layer
Group: Applications/Multimedia
AutoReq: no
AutoProv: no
%description integration-tests-{{MFEXT_BRANCH}}
metwork {{MODULE_LOWERCASE}} integration tests layer
{% endif %}

%prep
cd %{_builddir} || exit 1
rm -Rf %{name}-%{version}-%{release}
rm -Rf {{MODULE_LOWERCASE}}-%{version}-%{release}
bzip2 -dc %{_sourcedir}/{{MODULE_LOWERCASE}}-%{version}-%{release}-linux64.tar.bz2 | tar -xf -
mkdir %{name}-%{version}-%{release}
mv {{MODULE_LOWERCASE}}-%{version}-%{release} %{name}-%{version}-%{release}/
cd %{name}-%{version}-%{release}
rm -f mf*_link

{% if MODULE_HAS_HOME_DIR == "1" %}
%pre core-{{MODULE_BRANCH}}
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
  {% if MODULE == "MFDATA" %}
     useradd -M -d /home/{{MODULE_LOWERCASE}}/var/in -g metwork -s /sbin/nologin depose >/dev/null 2>&1
     echo depose |passwd --stdin {{MODULE_LOWERCASE}} >/dev/null 2>&1
     chmod g+rx /home/{{MODULE_LOWERCASE}} >/dev/null 2>&1
  {% endif %}
  N=`cat /etc/passwd |grep '^{{MODULE_LOWERCASE}}:' |wc -l`
  if test ${N} -eq 0; then
    echo "ERROR: impossible to create the {{MODULE_LOWERCASE}} user"
    exit 1
  fi
  rm -Rf /home/{{MODULE_LOWERCASE}}
fi
{% endif %}

%build

%install
mkdir -p %{buildroot}/{{MODULE_HOME}} 2>/dev/null
ln -s {{MODULE_HOME}} %{buildroot}{{MODULE_HOME}}/../metwork-{{MODULE_LOWERCASE}}
{% if MODULE_HAS_HOME_DIR == "1" %}
mkdir -p %{buildroot}/home/{{MODULE_LOWERCASE}} 2>/dev/null
{% endif %}
mv metwork-{{MODULE_LOWERCASE}}-%{version}-%{release}/{{MODULE_LOWERCASE}}-%{version}-%{release}/* %{buildroot}{{MODULE_HOME}}/
mv metwork-{{MODULE_LOWERCASE}}-%{version}-%{release}/{{MODULE_LOWERCASE}}-%{version}-%{release}/.layerapi2* %{buildroot}{{MODULE_HOME}}/
rm -Rf %{buildroot}{{MODULE_HOME}}/html_doc
{% if MODULE_HAS_HOME_DIR == "1" %}
ln -s {{MODULE_HOME}}/share/bashrc %{buildroot}/home/{{MODULE_LOWERCASE}}/.bashrc
ln -s {{MODULE_HOME}}/bash_profile %{buildroot}/home/{{MODULE_LOWERCASE}}/.bash_profile
chmod -R go-rwx %{buildroot}/home/{{MODULE_LOWERCASE}}
chmod -R u+rX %{buildroot}/home/{{MODULE_LOWERCASE}}
{% if MODULE == "MFDATA" %}
chmod g+rx %{buildroot}/home/{{MODULE_LOWERCASE}}
{% endif %}
{% endif %}
chmod -R a+rX %{buildroot}{{MODULE_HOME}}
rm -Rf %{_builddir}/%{name}-%{version}-%{release} 2>/dev/null
{% if MODULE == "MFCOM" %}
mkdir -p %{buildroot}/etc/security/limits.d/
cat >%{buildroot}/etc/security/limits.d/50-metwork.conf <<EOF
@metwork    soft    nofile  65536
@metwork    hard    nofile  65536
@metwork    soft    nproc  100000
@metwork    hard    nproc  100000
EOF
{% endif %}

%post core-{{MODULE_BRANCH}}
if test -f /etc/metwork.config; then
  touch /etc/metwork.config >/dev/null 2>&1
fi
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
if ! test -f /etc/metwork.config; then
    echo GENERIC >/etc/metwork.config
fi
{% if MODULE != "MFCOM" and MODULE != "MFEXT" %}
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

%postun core-{{MODULE_BRANCH}}
if [ "$1" = "0" ]; then # last uninstall only
  rm -Rf {{MODULE_HOME}}/../metwork-{{MODULE_LOWERCASE}} 2>/dev/null
  rm -Rf {{MODULE_HOME}} 2>/dev/null
  {% if MODULE_HAS_HOME_DIR == "1" %}
  userdel -f -r {{MODULE_LOWERCASE}} 2>/dev/null
  rm -Rf /home/{{MODULE_LOWERCASE}} 2>/dev/null
  {% endif %}
  {% if MODULE == "MFCOM" %}
    rm -f /etc/rc.d/init.d/metwork >/dev/null 2>&1
  {% endif %}
  rm -Rf /etc/metwork.config.d/{{MODULE_LOWERCASE}}
fi

%clean
rm -fr %{buildroot}

%files
%defattr(-,root,root,-)
# FIXME: try to avoid to hardcode /opt here
/opt/metwork-{{MODULE_LOWERCASE}}

%files core-{{MODULE_BRANCH}}
%defattr(-,root,root,-)
{% if MODULE_HAS_HOME_DIR == "1" %}
%defattr(-,{{MODULE_LOWERCASE}},metwork,-)
/home/{{MODULE_LOWERCASE}}
{% endif %}
{% if MODULE == "MFEXT" %}
{{MFEXT_HOME}}/.layerapi2_label
{{MFEXT_HOME}}/bin
{{MFEXT_HOME}}/config
{{MFEXT_HOME}}/lib
{{MFEXT_HOME}}/include
{{MFEXT_HOME}}/share
{{MFEXT_HOME}}/opt/core
{{MFEXT_HOME}}/opt/default
{{MFEXT_HOME}}/opt/python
{{MFEXT_HOME}}/opt/openresty
{{MFEXT_HOME}}/opt/python3
{{MFEXT_HOME}}/opt/python3_core
{{MFEXT_HOME}}/opt/python3_circus
{{MFEXT_HOME}}/opt/rpm
{% elif MODULE == "MFDATA" %}
{{MODULE_HOME}}/.layerapi2_label
{{MODULE_HOME}}/.layerapi2_dependencies
{{MODULE_HOME}}/bin
{{MODULE_HOME}}/config
{{MODULE_HOME}}/share
{{MODULE_HOME}}/opt/python3
{% elif MODULE == "MFSERV" %}
{{MODULE_HOME}}.layerapi2_label
{{MODULE_HOME}}/.layerapi2_dependencies
{{MODULE_HOME}}/bin
{{MODULE_HOME}}/config
{{MODULE_HOME}}/share
{{MODULE_HOME}}/opt/python3
{% elif MODULE == "MFCOM" %}
{{MODULE_HOME}}/.layerapi2_label
{{MODULE_HOME}}/.layerapi2_dependencies
{{MODULE_HOME}}/bin
{{MODULE_HOME}}/config
{{MODULE_HOME}}/include
{{MODULE_HOME}}/lib
{{MODULE_HOME}}/opt/python3
{{MODULE_HOME}}/share
{% else %}
{{MODULE_HOME}}
{% endif %}
{% if MODULE == "MFCOM" %}
/etc/security/limits.d/50-metwork.conf
{% endif %}

{% if MODULE == "MFEXT" %}
%files devtools-{{MFEXT_BRANCH}}
%defattr(-,root,root,-)
{{MFEXT_HOME}}/opt/devtools
{{MFEXT_HOME}}/opt/python3_devtools
{{MFEXT_HOME}}/opt/python3_devtools_jupyter

%files python2-devtools-{{MFEXT_BRANCH}}
%defattr(-,root,root,-)
{{MFEXT_HOME}}/opt/python2_devtools

%files scientific-{{MFEXT_BRANCH}}
%defattr(-,root,root,-)
{{MFEXT_HOME}}/opt/scientific
{{MFEXT_HOME}}/opt/postgresql
{{MFEXT_HOME}}/opt/python3_scientific

%files nodejs-{{MFEXT_BRANCH}}
%defattr(-,root,root,-)
{{MFEXT_HOME}}/opt/nodejs

%files mapserver-{{MFEXT_BRANCH}}
%defattr(-,root,root,-)
{{MFEXT_HOME}}/opt/mapserver

%files python2-scientific-{{MFEXT_BRANCH}}
%defattr(-,root,root,-)
{{MFEXT_HOME}}/opt/python2_scientific

%files integration-tests-{{MFEXT_BRANCH}}
%defattr(-,root,root,-)
{{MFEXT_HOME}}/opt/integration_tests
{% endif %}

{% if MODULE == "MFSERV" %}
%files nodejs-{{MODULE_BRANCH}}
%defattr(-,root,root,-)
{{MODULE_HOME}}/opt/nodejs
{% endif %}

{% if MODULE == "MFEXT" or MODULE == "MFCOM" or MODULE == "MFDATA" or MODULE == "MFSERV" %}
%files python2-{{MODULE_BRANCH}}
%defattr(-,root,root,-)
{{MODULE_HOME}}/opt/python2
{% if MODULE == "MFEXT" %}
{{MODULE_HOME}}/opt/python2_core
{% endif %}
{% endif %}
