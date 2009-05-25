package :munin, :provides => :monitoring do
  description 'Muinin Server Monitoring'
  apt "munin munin-node" do
    post :install, 'htpasswd -cmb /etc/apache2/access.htpasswd user some_password'
    post :install, 'touch /etc/apache2/sites-available/munin.conf'

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
  requires :apache, :apache2_prefork_dev, :ruby_enterprise
end

