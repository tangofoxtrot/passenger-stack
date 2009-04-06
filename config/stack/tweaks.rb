package :server_tweaks do
  description 'Misc tweaks to the server'

  push_text 'export PS1="\[\e[32;1m\]\u\[\e[0m\]\[\e[32m\]@\h\[\e[36m\]\w \[\e[33m\]\$ \[\e[0m\]"', '~/.bash_profile'
  
  post :install, 'sudo perl -pi -e \'s/(PermitRootLogin)\s+yes$/\1 no/g\' /etc/ssh/sshd_config'
  post :install, 'sudo perl -pi -e \'s/(Port)\s+22$/\1 222/g\' /etc/ssh/sshd_config'
  post :install, 'sudo /etc/init.d/ssh reload'
end