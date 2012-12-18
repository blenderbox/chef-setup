name "web"
description "Sets up mysql, nginx, and memcached."

run_list(
  "recipe[bbox::nginx]",
  "recipe[memcached]",
  "recipe[mysql::server]",
  "recipe[mysql::client]"
)

default_attributes(
  "nginx" => {
    "default_site_enabled" => false,
    "gzip_comp_level" => 5,
    "gzip_types" => [
      "text/css",
      "text/plain",
      "text/x-component",
      "application/javascript",
      "application/json",
      "application/xml",
      "application/xhtml+xml",
      "application/x-font-ttf",
      "application/x-font-opentype",
      "application/vnd.ms-fontobject",
      "image/svg+xml",
      "image/x-icon"
    ]
  },

  "mysql" => {
    "server_root_password" => "root",
    "server_debian_password" => "root",
    "server_repl_password" => "root"
  },

  "memcached" => {
    "memory" => 512,
    "listen" => "127.0.0.1"
  }
)
