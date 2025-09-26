
apt-get update && apt-get install --yes --no-install-suggests --no-install-recommends build-essential git mariadb-client libmariadb-dev pkg-config pv ntp wget curl supervisor file openssh-server nano vim less htop iputils-ping telnet software-properties-common gnupg libpango-1.0-0 libharfbuzz0b libpangoft2-1.0-0 libpangocairo-1.0-0 ca-certificates fontconfig libfreetype6 libjpeg-turbo8 libpng16-16 libx11-6 libxcb1 libxext6 libxrender1 xfonts-75dpi xfonts-base gcc libcups2-dev libmagic1 && rm -rf /var/lib/apt/lists/*


curl -fsSL https://packages.redis.io/gpg | gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg && echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb focal main" | tee /etc/apt/sources.list.d/redis.list && apt-get update && apt-get install --yes --no-install-suggests --no-install-recommends redis-server && rm -rf /var/lib/apt/lists/*


add-apt-repository ppa:deadsnakes/ppa && apt-get update && apt-get install --yes --no-install-suggests --no-install-recommends python3.11 python3.11-dev python3.11-distutils python3.11-venv && rm -rf /var/lib/apt/lists/*


wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.focal_amd64.deb && dpkg -i wkhtmltox_0.12.5-1.focal_amd64.deb && rm wkhtmltox_0.12.5-1.focal_amd64.deb


git clone --progress --depth 1 https://github.com/frappe/fonts.git /tmp/fonts && rm -rf /etc/fonts && mv /tmp/fonts/etc_fonts /etc/fonts && rm -rf /usr/share/fonts && mv /tmp/fonts/usr_share_fonts /usr/share/fonts && rm -rf /tmp/fonts && fc-cache -fv


wget https://raw.githubusercontent.com/nvm-sh/nvm/v0.36.0/install.sh && bash install.sh && . "/home/frappe/.nvm/nvm.sh" && nvm install 18.16.0 && nvm use v18.16.0 && nvm alias default v18.16.0 && rm install.sh && nvm cache clear


npm install -g yarn


wget https://bootstrap.pypa.io/get-pip.py && python3.11 get-pip.py


python3.11 -m pip install --upgrade frappe-bench==5.25.1


bench init --python /usr/bin/python3.11 --no-backups --frappe-path file:///home/frappe/context/apps/frappe frappe-bench
