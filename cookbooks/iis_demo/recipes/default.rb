#
# Cookbook Name:: iis_demo
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
powershell_script 'Install IIS' do
  code 'add-windowsfeature Web-Server'
end


pool_members = search("node","recipes:iis*")

template 'c:\inetpub\wwwroot\Default.htm' do
  source 'Default.htm.erb'
  variables(:pool_members => pool_members)
end

service 'w3svc' do
  action [:start, :enable]
end

