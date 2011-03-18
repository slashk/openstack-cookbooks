maintainer       "Ken Pepple"
maintainer_email "ken.pepple@rabbityard.com"
license          "Apache 2.0"
description      "Installs bazaar"
version          "0.1"

%w{ ubuntu debian }.each do |os|
  supports os
end
