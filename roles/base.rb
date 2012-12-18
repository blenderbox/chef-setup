name "base"
description "Baseline configuration for all systems."

run_list(
  "recipe[apt]",
  "recipe[ntp]",
  "recipe[build-essential]",
  "recipe[git]",
  "recipe[bbox::users]"
)

default_attributes(
  "ntp" => {
    "servers" => ["0.pool.ntp.org", "1.pool.ntp.org",
                  "2.pool.ntp.org", "3.pool.ntp.org"]
  },

  "authorization" => {
    "sudo" => {
      "groups" => ["admin", "sysadmin", "wheel"]
    }
  },

  "user" => {
    "home_root" => "/home",
    "default_shell" => "/bin/bash",
    "manage_home" => true,
    "create_group" => true,
    "create_user_group" => true,
    "ssh_keygen" => true,
    "data_bag_name" => "users"
  },

  "users" => ["deploy"],

  "bbox" => {
    "users" => {
      "use_janus" => true,
      "custom_dotfiles" => true
    }
  }
)
