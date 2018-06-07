function ia
	set -gx PATH /opt/anaconda/bin $PATH
	source (conda info --root)/etc/fish/conf.d/conda.fish
end
