Name: {{NAME}}
Summary: {{SUMMARY}}
Version: {{VERSION}}
Release: 1
License: {{LICENSE}}
Group: Development/Tools
URL: {{URL}}
Buildroot: %{_tmppath}/%{name}-root
Packager: {{PACKAGER | default('unknow') }}
Vendor: {{VENDOR}}
AutoReq: no
AutoProv: no
Prefix: /metwork_plugin

%description
{{SUMMARY}}

%build

%install
rm -rf %{buildroot}
mkdir -p %{buildroot}/metwork_plugin/%{name}/ 2>/dev/null
cd %{pwd} && cp -Rpvf * %{buildroot}/metwork_plugin/%{name}/
cp -pvf .layerapi2_* %{buildroot}/metwork_plugin/%{name}/
cp -pvf .autorestart_* %{buildroot}/metwork_plugin/%{name}/ >/dev/null 2>&1 || true
rm -f %{buildroot}/metwork_plugin/%{name}/Makefile
rm -f %{buildroot}/metwork_plugin/%{name}/*.plugin
find %{buildroot}/metwork_plugin/%{name}/ -type d -name ".svn" -exec rm -Rf {} \; >/dev/null 2>&1 || true
find %{buildroot}/metwork_plugin/%{name}/ -type d -name ".git" -exec rm -Rf {} \; >/dev/null 2>&1 || true
find %{buildroot}/metwork_plugin/%{name}/ -type f -name ".git*" -exec rm -Rf {} \; >/dev/null 2>&1 || true
rm -Rf %{buildroot}/metwork_plugin/%{name}/python3_virtualenv
rm -Rf %{buildroot}/metwork_plugin/%{name}/python2_virtualenv
rm -Rf %{buildroot}/metwork_plugin/%{name}/local
rm -Rf %{buildroot}/metwork_plugin/%{name}/src
rm -Rf %{buildroot}/metwork_plugin/%{name}/doc
rm -Rf %{buildroot}/metwork_plugin/%{name}/docs
find %{buildroot}/metwork_plugin/%{name}/ -type d -name "__pycache__" -exec rm -Rf {} \; >/dev/null 2>&1 || true
find %{buildroot}/metwork_plugin/%{name}/ -type f -name "*.pyc" -exec rm -f {} \; >/dev/null 2>&1 || true
if test -d %{buildroot}/metwork_plugin/%{name}/bin; then chmod u+x  %{buildroot}/metwork_plugin/%{name}/bin/*; fi
if test -f %{buildroot}/metwork_plugin/main.py; then chmod u+x  %{buildroot}/metwork_plugin/main.py; fi

%clean
rm -fr %{buildroot}

%files
%defattr(-,-,-)
/metwork_plugin
