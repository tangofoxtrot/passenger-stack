package :munin, :provides => :monitoring do
  description 'Muinin Server Monitoring'
  apt "munin munin-node" do
    post :install, 'htpasswd -cmb /etc/apache2/access.htpasswd user some_password'
    post :install, 'touch /etc/apache2/sites-available/munin.conf'

    post :install, "curl http://gist.github.com/raw/118319/4ba7d81c29e10fb86e67d9a539ab5716704a61fc/Munin%20Passenger%20Memory%20Stats -o /etc/munin/plugins/passenger-memory"
    post :install, "curl http://gist.github.com/raw/118319/d293dc236800a1cf02b56fc8c0eeb617d7a3455c/Munin%20Passenger%20Status -o /etc/munin/plugins/passenger-status"
    post :install, "chmod a+x /etc/munin/plugins/passenger-status"
    post :install, "chmod a+x /etc/munin/plugins/passenger-memory"
    post :install, 'sudo perl -p -i.old -e \'s/PATH=\/sbin:\/bin:\/usr\/sbin:\/usr\/bin/PATH=\/sbin:\/bin:\/usr\/sbin:\/usr\/bin:\/usr\/local\/bin/g\' /etc/init.d/munin-node'
    post :install, "echo 'nobody ALL=(ALL) NOPASSWD:/usr/local/bin/passenger-status, /usr/local/bin/passenger-memory-stats' |sudo tee -a /etc/sudoers"
    post :install, "/etc/init.d/munin-node restart"


    [%q(<VirtualHost *:80>),
      %q(  ServerName munin.server.com),
      %q(  DocumentRoot /var/www/munin),
      %q(  <directory "/var/www/munin">),
      %q(   AuthName "Restricted"),
      %q(   AuthType Basic),
      %q(   AuthUserFile /etc/apache2/access.htpasswd),
      %q(   require valid-user),
      %q(   Order allow,deny),
      %q(   Allow from all),
      %q(  </directory>),
      %q(</VirtualHost>) 
    ].each do |line|
      post :install, "echo '#{line}' |sudo tee -a /etc/apache2/sites-available/munin.conf"
    end
  end
  
  verify do
    has_executable 'munin-node'
  end
  requires :apache, :apache2_prefork_dev, :ruby_enterprise, :misc
end

