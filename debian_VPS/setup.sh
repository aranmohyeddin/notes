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
    python3-dev \
    build-essential \
    libssl-dev \
    libffi-dev \
    git \
    zsh \
    tree \
    cmake \
    fail2ban \
sudo apt autoremove

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sudo hostname aran_vps
PROMPT="%F{blue}%M[%T]%F{cyan} %.%B%F{92}$%b%f "
export PATH="$PATH:/home/aran/.local/bin/"
source virtualenvwrapper_lazy.sh
sudo ufw allow OpenSSH
sudo ufw enable

pip3 install --user virtualenvwrapper
export WORKON_HOME=~/.virtualenvs
export PATH=".local/bin/:$PATH"
source .local/bin/virtualenvwrapper_lazy.sh
#mkvirtualenv -p /usr/bin/python3
