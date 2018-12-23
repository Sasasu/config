set -gx fish_greeting ""
    function ia
	set platform (uname | grep Darwin)
	if [ $platform ]
		echo "set mac PATH"
		set -gx PATH /Users/$USER/anaconda2/bin $PATH
	else
		echo "set linux PATH"
		set -gx PATH /opt/anaconda/bin $PATH
	end
	source (conda info --root)/etc/fish/conf.d/conda.fish
end

set -gx PATH ~/.cargo/bin $PATH
export SSH_AUTH_SOCK=(gpgconf --list-dirs agent-ssh-socket)
