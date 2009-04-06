package :build_essential do
  description 'Build tools'
  apt 'build-essential' do
    pre :install, ['apt-get update', 'aptitude safe-upgrade -y', 'aptitude full-upgrade -y']
  end
end

