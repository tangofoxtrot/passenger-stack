# Install a firewall
package :ufw, :provides => :firewall do
  description 'UFW Firewall'
  apt 'ufw' do
    post :install, "sudo ufw enable"
    post :install, "sudo ufw default deny"
    post :install, "sudo ufw allow 222"
    post :install, "sudo ufw allow 80"                  
    post :install, "sudo ufw allow 443"   
    post :install, "sudo ufw allow 8767"
    post :install, "sudo ufw allow 123"
    post :install, "sudo ufw allow 5222"
    post :install, "sudo ufw allow 5223"
    post :install, "sudo ufw allow 7777"
    post :install, "sudo ufw allow 8030"
  end
  requires :server_tweaks   
end
