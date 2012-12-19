# About
This is an intro to a functioning chef setup. I've added some
customizations that I myself like, for instance my dotfiles, and
installing vim with janus. This uses chef solo, with the knife-solo
plugin.


# Setup
1. Clone this repository to your computer:
```bash
$ git clone git@github.com:blenderbox/chef-setup.git
```

2. Go into the cloned directory. This will initialize the RVM and
   install the necessary gems. If you don't have RVM installed, [install
   it](https://rvm.io/rvm/install/), then go through the setup process, and
   finally cd out and back into the directory.
```bash
$ cd chef-setup
```

3. Now install all of the chef cookbooks, which are managed with
   `librarian`.
```bash
$ librarian-chef install
```

4. *Optional*: If you want to use this setup with Vagrant:
    * Install the vagrant gem.
    * Add a vagrant box to use.
    * Initialize the `precise64` box you just downloaded.
    * Start up your new vagrant box.
```bash
$ gem install vagrant
$ vagrant box add precise64 http://files.vagrantup.com/precise64.box
$ vagrant init precise64
$ vagrant up
```

      **Note**: The default connection string for vagrant is:
        `vagrant@127.0.0.1 -p 2222 -i ~/.vagrant.d/insecure_private_key`


# How To Use
1. Once you've created a vanilla server, you'll want to prepare it for
   chef. You can do this with the `knife prepare` command. This command
   takes the host information as an argument. *It will default to using
   your ssh configuration.*
```bash
$ knife prepare user@host -p 22 -i ~/.ssh/my_id
```

2. Now your server has a chef installation on it, and it is ready to
   receive commands. Before we tell chef to install everything, we need
   to customize some settings.
    * First, open `data_bags/users/deploy.json`. This file is a regular
      json file, which describes a user. The `id` and name of the file
      correspond to the username. `groups` is a list of groups the user
      will be added to (`sysadmin` is setup as a passwordless sudo
      group). Overwrite `ssh-rsa ...== some@email.com` with the contents
      of your public ssh key, found in `~/.ssh/id_*sa.pub`.
    * Next open `nodes/default.json`. This file tells chef what recipes
      to run on your server (also known as a node). In the `run_list`
      you'll find three roles which will run when you invoke chef. You
      can look at the code for each of these in `roles/<name>.rb`.  
      * `base` installs the basics for a server, and sets up the
        `deploy` user you've defined.
      * `appserver` will install `nginx`, `memcached`, and `mysql`
        (both client and server).
      * `pythonapp` will install `python`, `pip`, and `virtualenv`.


3. Now that you've added some customizations, you can go ahead and run:
```bash
$ knife cook user@host -p 22 -i ~/.ssh/my_id nodes/default.json
```

4. Once this is finished running, you'll have a fully operational
   server.
