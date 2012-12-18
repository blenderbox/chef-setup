#
# Cookbook Name:: bbox
# Recipe:: python
#
# Copyright 2012, Blenderbox
#
# All rights reserved - Do Not Redistribute
#

include_recipe "python"
include_recipe "python::pip"
include_recipe "python::virtualenv"

pkgs = ["supervisor", "libjpeg62", "libjpeg62-dev", "zlib1g-dev"]

pkgs.each do |pkg|
  package pkg do
    action :install
  end
end

# If Ubuntu and x86, symlink the x86 libs to the
# regular /usr/lib directory for PIL
if platform?("ubuntu") and node[:languages][:ruby][:host_cpu] == "x86_64"
  lib_def_path = "/usr/lib"
  lib_64_path = "/usr/lib/x86_64-linux-gnu"
  lib_files = ["libjpeg.so", "libz.so"]

  lib_files.each do |lib|
    link "#{lib_64_path}/#{lib}" do
      to "#{lib_def_path}/#{lib}"
      owner "root"
      group "root"
    end
  end
end


# Setup default supervisor conf
cookbook_file "/etc/supervisor/supervisord.conf" do
  source "python/supervisord.conf"
  mode 0640
  owner "root"
  group "root"
end
