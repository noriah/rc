# Setup
ZSH_CACHE_DIR="$HOME/.cache/zsh"

[ ! -d "$ZSH_CACHE_DIR" ] && mkdir -p "$ZSH_CACHE_DIR"

ZSH_COMP_FILE="$ZSH_CACHE_DIR/.zcompdump"

ZSH_DIR="${0:h}"
ZSH_BASE_DIR="$ZSH_DIR/base"
ZSH_CONF_DIR="$ZSH_DIR/conf"
ZSH_LIB_DIR="$ZSH_DIR/lib"
ZSH_PLUGIN_DIR="$ZSH_DIR/plugins"

EDITOR=vi

CORP_KEY=${CORP_KEY:-corp}

# Zash
source "${0:h}/zash.zsh"

# Base
zash base alias
zash base appearance
zash base completion
zash base directory
zash base functions
zash base history
zash base keys
zash base load
zash base misc
zash base terminal

env_default 'PAGER' 'less'
env_default 'LESS' '-R'

zash plugins "${0:h}/plugins-osx"

# Theme
zash library p10k

# Zash stuff
zash do autoload
zash do hook
