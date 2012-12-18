maintainer       "Blenderbox"
maintainer_email "technology@blenderbox.com"
license          "All rights reserved"
description      "Installs/Configures Nginx with some customizations"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

%w{ nginx python mysql memcached sudo }.each do |cb|
  depends cb
end
