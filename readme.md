# About
This is an intro to a functioning chef setup. I've added some
customizations that I myself like, for instance my dotfiles, and
installing vim with janus. This uses chef solo, with the knife-solo
plugin.


# Setup
1. Clone this repository to your computer:
    `git clone git@github.com/.../`

2. Go into the cloned directory. This will initialize the RVM and
   install the necessary gems. If you don't have RVM installed, [install
   it](https://rvm.io/rvm/install/), then go through the setup process, and
   finally cd out and back into the directory.
    `cd chef-setup`

3. If you want to use vagrant to setup a test box, install the vagrant
   gem, and [setup the box](http://vagrantup.com/v1/docs/getting-started/index.html).
    `gem install vagrant`


# How To Use
1. Once you've created a vanilla server, you'll want to prepare it for
   chef. You can do this with the `knife` command.
    `knife prepare user@host -p 22 -i ~/.ssh/my_id`

2. Now your server has a chef installation on it, and is ready to
   receive commands. Before we tell chef to install everything, we need
   to customize some settings. First, open `data_bags/users/deploy.json`. In
   this file, you'll want to add your public key. Next, you'll want to
   modify `nodes/default.json`. In this file, you'll see there are three
   roles being used: `base`, `appserver`, and `pythonapp`.
    * `base` will install the deploy user and install some basic packages
      like `vim`.
    * `appserver` will install `nginx`, `memcached`, and `mysql` (both
      server and client.
    * `pythonapp` will install `python`, `pip`, and `virtualenv`.

3. Now that you've added some customizations, you can go ahead and run:
    `knife cook user@host -p 22 -i ~/.ssh/my_id nodes/default.json`

4. Once this is finished running, you'll have a fully operational
   server.
