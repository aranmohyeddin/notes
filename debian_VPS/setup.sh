adduser aran
usermod -aG sudo aran
su aran
sudo apt update
sudo apt upgrade
sudo apt install -y \
    curl \
    sudo \
    ufw \
    python3-pip \
    build-essential \
    libssl-dev \
    libffi-dev \
    postgresql \
    postgresql-contrib \
    git \
    zsh \
    tree \
    cmake \
    fail2ban \
    nginx

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sudo hostname aran_vps
PROMPT="%F{blue}%M[%T]%F{cyan} %.%B%F{92}$%b%f "
export PATH="$PATH:/home/aran/.local/bin/"
source virtualenvwrapper_lazy.sh
sudo -u postgres createuser --interactive
sudo ufw allow OpenSSH
sudo ufw enable
