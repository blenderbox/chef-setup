maintainer       "Blenderbox: Damon Jablons"
maintainer_email "djablons@blenderbox.com"
license          "All rights reserved"
description      "Installs/Configures a standard web server with some cusomizations"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

%w{ nginx python mysql memcached sudo user }.each do |cb|
  depends cb
end
