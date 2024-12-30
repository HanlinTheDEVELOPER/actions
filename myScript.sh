#bin/sh

sudo apt install cowsay -y
cowsay -f dragon "Want Some BBQ? I will supplies fuel" >> dragon.txt
sudo grep -i "BBQ" dragon.txt
cat dragon.txt