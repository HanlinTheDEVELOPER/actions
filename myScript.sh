#bin/bash

sudo apt install cowsay -y
cowsay -f dragon "Want Some BBQ?" >> dragon.txt
sudo grep -i "BBQ" dragon.txt
