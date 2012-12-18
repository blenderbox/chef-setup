#
# Cookbook Name:: bbox
# Recipe:: default
#
# Copyright 2012, Blenderbox
#
# All rights reserved - Do Not Redistribute
#

include_recipe "bbox::users"
include_recipe "bbox::nginx"
include_recipe "bbox::python"
