#
# Cookbook Name:: bbox
# Recipe:: nginx
#
# Copyright 2012, Blenderbox
#
# All rights reserved - Do Not Redistribute
#

include_recipe "nginx"

cookbook_file "/etc/nginx/mime.types" do
  source "nginx/mime.types"
  mode 0640
  owner "root"
  group "root"
  notifies :restart, resources(:service => "nginx")
end
