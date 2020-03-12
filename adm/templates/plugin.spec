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
cp -RTvf %{pwd} %{buildroot}/metwork_plugin/%{name}
# FIXME: remove these 2 next lines
if test -d %{buildroot}/metwork_plugin/%{name}/bin; then chmod u+x  %{buildroot}/metwork_plugin/%{name}/bin/*; fi
if test -f %{buildroot}/metwork_plugin/main.py; then chmod u+x  %{buildroot}/metwork_plugin/main.py; fi

%clean
rm -fr %{buildroot}

%files
%defattr(-,-,-)
/metwork_plugin
