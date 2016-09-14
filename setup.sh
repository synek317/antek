#/bin/bash

wget http://www.openfl.org/builds/haxe/haxe-3.2.1-linux-installer.tar.gz
tar -xzf haxe-3.2.1-linux-installer.tar.gz
./install-haxe.sh -y
haxelib install openfl
haxelib run openfl setup
haxelib install flixel
haxelib update flixel
haxelib install flixel-tools
haxelib run flixel-tools setup

rm haxe-3.2.1-linux-installer.tar.gz
rm install-haxe.sh