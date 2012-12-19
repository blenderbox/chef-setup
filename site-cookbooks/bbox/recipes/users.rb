#
# Cookbook Name:: bbox
# Recipe:: users
#
# Copyright 2012, Blenderbox
#
# All rights reserved - Do Not Redistribute
#

include_recipe "sudo"
include_recipe "user::data_bag"

# Use the sudo template in the bbox cookbook
resources(:template => "/etc/sudoers").instance_exec do
  cookbook "bbox"
end

# The packages to install with apt-get
pkgs = ["vim", "mercurial", "subversion", "git-core", "ruby-dev", "rake",
        "exuberant-ctags", "ack-grep", "xclip", "curl"]

# Install the packages
pkgs.each do |pkg|
  package pkg do
    action :install
  end
end

# Dotfiles and Vim
bbox_users = search(:users, "*:*")

bbox_users.each do |login|
  bboxer = data_bag_item("users", login['id'])
  username = login['id']
  home = "/home/#{username}"

  # Install Janus
  if node['bbox']['users']['use_janus']
    vim_dir = "#{home}/.vim"
    git vim_dir do
      repository "git://github.com/carlhuda/janus.git"
      reference "master"
      user username
      group username
      enable_submodules true
      action :sync
    end

    execute "rake" do
      cwd vim_dir
      user username
      group username
      action :run
      environment ({'HOME' => home})
    end
  end

  # Install dotfiles
  dotfiles_dir = "#{home}/dotfiles"

  # Clone the remote dotfiles directory
  if node['bbox']['users']['custom_dotfiles']
    git dotfiles_dir do
      repository "git://github.com/blackrobot/dotfiles.git"
      reference "master"
      user username
      group username
      enable_submodules true
      action :sync
      only_if {File.directory?(home)}
    end

    # Delete the existing .bashrc file
    file "#{home}/.bashrc" do
      action :delete
    end

    linx = [".bashrc", ".gitconfig", ".fonts"]

    if node['bbox']['users']['use_janus']
      linx += [".janus", ".vimrc.before", ".vimrc.after"]
    end

    # Create the symlinks
    linx.each do |lnk|
      link "#{home}/#{lnk}" do
        to "#{dotfiles_dir}/#{lnk}"
        owner username
        group username
      end
    end
  end

end
