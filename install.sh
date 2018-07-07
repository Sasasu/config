#!/bin/bash

get_os_type(){
  os=$(uname)
    case $os in
      "Drawin")
         echo "Drawin"
          ;;
      *)
         echo "Arch"
         ;;
    esac
}

os_type=$(get_os_type)


cp ./.clang-format ~/
mkdir -p ~/.config/nvim
cp ./init.vim  ~/.config/nvim/
cp ./init.vim ~/.vimrc

cp config.fish ../../.config/fish/config.fish

if [[ $os_type == "Drawin" ]];then
    sudo cp bin/mac/* /usr/local/bin/
elif [[ $os_type == "Arch" ]];then
    sudo cp bin/linux/* /usr/local/bin/
else
    echo "not support";return 1
fi
sudo cp bin/both/* /usr/local/bin/
