# <a name="about"></a> About
This is an intro to a functioning chef setup. I've added some
customizations that I myself like, for instance my dotfiles, and
installing vim with janus. This uses chef solo, with the knife-solo
plugin.


# <a name="setup"></a> Setup
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

4. *Optional*: If you want to use this setup with Vagrant, I've created
   a Vagrantfile to make it smoother:
    * Install the vagrant gem.
    * Start up your new vagrant box.
    * Get the SSH connection string
```bash
$ gem install vagrant
$ vagrant up
$ vagrant ssh-config --host chef-setup > config.ssh
```


# <a name="how-to"></a> How To Use
1. Once you've created a vanilla server, you'll want to prepare it for
   chef. You can do this with the `knife prepare` command. This command
   takes the host information as an argument. Assuming you've put your 
   ssh configuration in a file called `config.ssh`, and your host is
   called `chef-setup`:
```bash
$ knife prepare chef-setup -F config.ssh
```

2. Now your server has a chef installation on it, and it is ready to
   receive commands. Before we tell chef to install everything, we need
   to customize some settings. Check the available [customizations]("#customize")
   below. At the very least, you'll have to add your pub key to
   `data_bags/users/deploy.json`.

3. Now that you've added some customizations, you can go ahead and run:
```bash
$ knife cook chef-setup -F config.ssh nodes/default.json
```

4. Once this is finished running, you'll have a fully operational
   server.


# <a name="customize"></a> Customize
There's a lot of things you may want to customize with your chef setup.
This only covers a few options that are specific to this project, for
more info, consult the [chef documentation](http://wiki.opscode.com/display/chef/Home),
and take a look at all of the
[available cookbooks](https://github.com/opscode-cookbooks/).

* **Users**: The first thing you'll want to change are the users. As an
example, there's one user that gets created called "deploy". To create
more users, copy `data_bags/users/deploy.json` to
`data_bags/users/<username>.json`. Then modify the "id" to match the
name of the file, and update the `ssh_keys` array. To see more available
configuration attributes, check the
[chef-user documentation](https://github.com/fnichol/chef-user/blob/master/README.md).

* **Nodes**: A node is the server you're setting up with chef. Once you
run the `knife prepare` command, you'll notice that a new file has
been created called `nodes/<hostname>.json`. Using `nodes/default.json`
as a reference, you can add things to the `run_list`. For instance, if
you've installed the [php cookbook](https://github.com/opscode-cookbooks/php)
and you don't want to use the `pythonapp` role, your json file would
look something like this:
```json
{
  "run_list": [
    "role[base]",
    "role[appserver]",
    "recipe[php]"
  ]
}
```
Here, you can also modify default attributes of a recipe or a role. If
you look at `roles/base.rb` you'll see several attributes being set
inside the `default_attributes` call. For example, if you wanted to
change the default shell for all users to sh:
```json
{
  "user": { "default_shell": "/bin/sh" },
  "run_list": [...]
}
```
