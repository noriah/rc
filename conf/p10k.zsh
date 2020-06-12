# Powerlevel10k Config
# Noriah (code@noriah.dev)

'builtin' 'local' '-a' 'p10k_config_opts'
[[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
[[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
[[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')
'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'

function _left_with_plugin() {
  item="$1"
  if (( ${+2} )); then other="$2"; else other="$item"; fi
  if zash_has_plugin "$item"
  then
    POWERLEVEL9K_LEFT_PROMPT_ELEMENTS+=("$other")
  fi
}

function _right_with_plugin() {
  item="$1"
  if (( ${+2} )); then other="$2"; else other="$item"; fi
  if zash_has_plugin "$item"
  then
    POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS+=("$other")
  fi
}

() {
  emulate -L zsh

  typeset -g ZLE_RPROMPT_INDENT=0

  unset -m 'POWERLEVEL9K_*'

  setopt no_unset extended_glob

  autoload -Uz is-at-least && is-at-least 5.1 || return

  zmodload zsh/langinfo
  if [[ ${langinfo[CODESET]:-} != (utf|UTF)(-|)8 ]]; then
    local LC_ALL=${${(@M)$(locale -a):#*.(utf|UTF)(-|)8}[1]:-en_US.UTF-8}
  fi

  typeset -g POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
  typeset -g POWERLEVEL9K_DISABLE_INSTANT_PROMPT=true
  typeset -g POWERLEVEL9K_MODE=nerdfont-complete

  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon dir dir_writable vcs newline prompt_char)
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time history background_jobs)

  _right_with_plugin direnv
  _right_with_plugin terraform

  POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS+=(
    virtualenv pyenv goenv nodenv
    context ranger vim_shell vpn_ip
  )

  POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS+=(
    load
    time
    newline
  )

  _right_with_plugin golang go_version

  _right_with_plugin rust rust_version

  _right_with_plugin node node_version

  POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS+=(
    battery
  )

  _right_with_plugin todo

  typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

  typeset -g POWERLEVEL9K_VISUAL_IDENTIFIER_EXPANSION='${P9K_VISUAL_IDENTIFIER// }'

  typeset -g POWERLEVEL9K_{BACKGROUND_JOBS,DIRENV,VIM_SHELL,VPN_IP}_VISUAL_IDENTIFIER_EXPANSION='${P9K_VISUAL_IDENTIFIER// }'

  typeset -g POWERLEVEL9K_BACKGROUND=
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_BACKGROUND=
  typeset -g POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_GAP_BACKGROUND=
  typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_GAP_BACKGROUND=

  typeset -g POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR='\uE0B1'
  typeset -g POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR='\uE0B3'
  typeset -g POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR='\uE0BC'
  typeset -g POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR='\uE0BA'
  typeset -g POWERLEVEL9K_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL='\uE0B1'
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL='\uE0B3'
  typeset -g POWERLEVEL9K_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL=''
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_LAST_SEGMENT_END_SYMBOL=''

  typeset -g POWERLEVEL9K_OS_ICON_FOREGROUND=7
  # typeset -g POWERLEVEL9K_OS_ICON_BACKGROUND=0
  typeset -g POWERLEVEL9K_OS_ICON_CONTENT_EXPANSION='%B${P9K_CONTENT}'

  typeset -g POWERLEVEL9K_STATUS_{EXTENDED_STATES,OK,OK_PIPE,ERROR,ERROR_SIGNAL,ERROR_PIPE}=true
  typeset -g POWERLEVEL9K_STATUS_{OK,OK_PIPE}_VISUAL_IDENTIFIER_EXPANSION='✔'
  typeset -g POWERLEVEL9K_STATUS_{OK,OK_PIPE}_FOREGROUND=2

  typeset -g POWERLEVEL9K_STATUS_{ERROR,ERROR_SIGNAL,ERROR_PIPE}_VISUAL_IDENTIFIER_EXPANSION='✘'
  typeset -g POWERLEVEL9K_STATUS_{ERROR,ERROR_SIGNAL,ERROR_PIPE}_FOREGROUND=196
  typeset -g POWERLEVEL9K_STATUS_VERBOSE_SIGNAME=false

  typeset -g POWERLEVEL9K_PROMPT_CHAR_BACKGROUND=
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=2
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=196
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='❯'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION='❮'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIVIS_CONTENT_EXPANSION='Ⅴ'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIOWR_CONTENT_EXPANSION='▶'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OVERWRITE_STATE=true
  typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=
  typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL=
  typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_{LEFT,RIGHT}_WHITESPACE=

  typeset -g POWERLEVEL9K_DIR_FOREGROUND=80
  typeset -g POWERLEVEL9K_DIR_{SHORTENED,ANCHOR}_FOREGROUND=80
  typeset -g POWERLEVEL9K_DIR_VISUAL_IDENTIFIER_EXPANSION='${P9K_VISUAL_IDENTIFIER// }'
  typeset -g POWERLEVEL9K_DIR_ANCHOR_BOLD=true
  typeset -g POWERLEVEL9K_DIR_MAX_LENGTH=40

  if zash_has_plugin "workspace"
  then
    pro_dir="$WORKSPACE_DIR/$WORKSPACE_PRO_KEY"
    corp_dir="$WORKSPACE_DIR/$WORKSPACE_CORP_KEY"
    local_dir="$WORKSPACE_DIR/$WORKSPACE_LOCAL_KEY"
    vault_dir="$WORKSPACE_DIR/vault"

    typeset -g POWERLEVEL9K_DIR_CLASSES=(
      '/etc|/etc/*' ETC '\uF013'
      '~' HOME '\uF015'
      "$WORKSPACE_DIR" WORKSPACE '%B\uF44F'
      "$pro_dir|$pro_dir/*" WORKSPACE_PRO '%B\uE780'
      "$corp_dir|$corp_dir/*" WORKSPACE_CORP '%B\uF0F7'
      "$local_dir|$local_dir/*" WORKSPACE_LOCAL '%B\uF7C9'
      "$vault_dir|$vault_dir/*" WORKSPACE_VAULT '%B\uFC71'
      '~/*' HOME_SUBFOLDER '\uF07C'
      '*' DEFAULT '\uF115'
    )

    # typeset -g POWERLEVEL9K_DIR_WORKSPACE_PRO_FOREGROUND=209
    # typeset -g POWERLEVEL9K_DIR_VISUAL_IDENTIFIER
    typeset -g POWERLEVEL9K_DIR_WORKSPACE_VISUAL_IDENTIFIER_COLOR=202
    typeset -g POWERLEVEL9K_DIR_WORKSPACE_PRO_VISUAL_IDENTIFIER_COLOR=210
    typeset -g POWERLEVEL9K_DIR_WORKSPACE_CORP_VISUAL_IDENTIFIER_COLOR=3
    typeset -g POWERLEVEL9K_DIR_WORKSPACE_LOCAL_VISUAL_IDENTIFIER_COLOR=5
    typeset -g POWERLEVEL9K_DIR_WORKSPACE_VAULT_VISUAL_IDENTIFIER_COLOR=1
    # typeset -g POWERLEVEL9K_DIR_PATH_HIGHLIGHT_FOREGROUND=210
    # typeset -g POWERLEVEL9K_DIR_WORKSPACE_CORP_FOREGROUND=254
    # typeset -g POWERLEVEL9K_DIR_WORKSPACE_LOCAL_FOREGROUND=254
  fi

  typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=
  typeset -g POWERLEVEL9K_SHORTEN_DELIMITER='->'
  typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=2

  typeset -g POWERLEVEL9K_HISTORY_FOREGROUND=204
  # typeset -g POWERLEVEL9K_HISTORY_CONTENT_EXPANSION='%B${P9K_CONTENT}'

  typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND=2
  typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=3
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=2
  typeset -g POWERLEVEL9K_VCS_CONFLICTED_FOREGROUND=3
  typeset -g POWERLEVEL9K_VCS_LOADING_FOREGROUND=8
  typeset -g POWERLEVEL9K_VCS_{STAGED,UNSTAGED,UNTRACKED,CONFLICTED,COMMITS_AHEAD,COMMITS_BEHIND}_MAX_NUM=-1
  typeset -g POWERLEVEL9K_VCS_BACKENDS=(git)

  typeset -g POWERLEVEL9K_TODO_FOREGROUND=3
  typeset -g POWERLEVEL9K_TODO_HIDE_ZERO_TOTAL=false
  typeset -g POWERLEVEL9K_TODO_HIDE_ZERO_FILTERED=false
  typeset -g POWERLEVEL9K_TODO_VISUAL_IDENTIFIER_EXPANSION=$'\u2611'

  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=3
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=3
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=0
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FORMAT='d h m s'

  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND=6
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_{VERBOSE,VERBOSE_ALWAYS}=true

  typeset -g POWERLEVEL9K_VPN_IP_FOREGROUND=6
  typeset -g POWERLEVEL9K_VPN_IP_CONTENT_EXPANSION=
  typeset -g POWERLEVEL9K_VPN_IP_INTERFACE='(wg|(.*tun))[0-9]*'

  typeset -g POWERLEVEL9K_VI_COMMAND_MODE_STRING=NORMAL
  typeset -g POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND=2
  typeset -g POWERLEVEL9K_VI_VISUAL_MODE_STRING=VISUAL
  typeset -g POWERLEVEL9K_VI_MODE_VISUAL_FOREGROUND=4
  typeset -g POWERLEVEL9K_VI_OVERWRITE_MODE_STRING=OVERTYPE
  typeset -g POWERLEVEL9K_VI_MODE_OVERWRITE_FOREGROUND=3
  typeset -g POWERLEVEL9K_VI_INSERT_MODE_STRING=INSERT
  typeset -g POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND=8

  typeset -g POWERLEVEL9K_LOAD_WHICH=1
  typeset -g POWERLEVEL9K_LOAD_NORMAL_FOREGROUND=140
  typeset -g POWERLEVEL9K_LOAD_WARNING_FOREGROUND=3
  typeset -g POWERLEVEL9K_LOAD_CRITICAL_FOREGROUND=1

  typeset -g POWERLEVEL9K_CONTEXT_FOREGROUND=3
  typeset -g POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND=1
  typeset -g POWERLEVEL9K_CONTEXT_{REMOTE,REMOTE_SUDO}_FOREGROUND=2
  typeset -g POWERLEVEL9K_CONTEXT_TEMPLATE='%n@%m'
  typeset -g POWERLEVEL9K_CONTEXT_{REMOTE,REMOTE_SUDO}_TEMPLATE='%n@%m'

  typeset -g POWERLEVEL9K_CONTEXT_{DEFAULT,SUDO}_{CONTENT,VISUAL_IDENTIFIER}_EXPANSION=

  typeset -g POWERLEVEL9K_{VIRTUALENV,PYENV,GOENV,NODEENV}_PROMPT_ALWAYS_SHOW=false
  typeset -g POWERLEVEL9K_{VIRTUALENV,PYENV,GOENV,NODEENV}_{LEFT,RIGHT}_DELIMITER=
  typeset -g POWERLEVEL9K_VIRTUALENV_SHOW_PYTHON_VERSION=false
  typeset -g POWERLEVEL9K_PYENV_SOURCES=(shell local global)
  typeset -g POWERLEVEL9K_NODEENV_SHOW_NODE_VERSION=false

  typeset -g POWERLEVEL9K_BATTERY_LOW_THRESHOLD=20
  typeset -g POWERLEVEL9K_BATTERY_LOW_FOREGROUND=1
  typeset -g POWERLEVEL9K_BATTERY_{CHARGING,CHARGED}_FOREGROUND=2
  # typeset -g POWERLEVEL9K_BATTERY_HIDE_ABOVE_THRESHOLD=20
  typeset -g POWERLEVEL9K_BATTERY_DISCONNECTED_FOREGROUND=3
  typeset -g POWERLEVEL9K_BATTERY_STAGES=$'\uf58d\uf579\uf57a\uf57b\uf57c\uf57d\uf57e\uf57f\uf580\uf581\uf578'
  typeset -g POWERLEVEL9K_BATTERY_VERBOSE=true

  typeset -g POWERLEVEL9K_TIME_FOREGROUND=159
  typeset -g POWERLEVEL9K_TIME_FORMAT='%D{%H:%M:%S}'
  typeset -g POWERLEVEL9K_TIME_UPDATE_ON_COMMAND=true

  typeset -g POWERLEVEL9K_GO_VERSION_VISUAL_IDENTIFIER_EXPANSION=$'\ufcd1'
  typeset -g POWERLEVEL9K_GO_VERSION_VISUAL_IDENTIFIER_COLOR=87
  typeset -g POWERLEVEL9K_GO_VERSION_FOREGROUND=11

  typeset -g POWERLEVEL9K_RUST_VERSION_VISUAL_IDENTIFIER_EXPANSION=$'\uf827'
  typeset -g POWERLEVEL9K_RUST_VERSION_VISUAL_IDENTIFIER_COLOR=166
  typeset -g POWERLEVEL9K_RUST_VERSION_FOREGROUND=11

  typeset -g POWERLEVEL9K_NODE_VERSION_PROJECT_ONLY=true
  # typeset -g POWERLEVEL9K_NODE_VERSION_VISUAL_IDENTIFIER_EXPANSION=$'\u'
  typeset -g POWERLEVEL9K_NODE_VERSION_VISUAL_IDENTIFIER_COLOR=10
  typeset -g POWERLEVEL9K_NODE_VERSION_FOREGROUND=11

  typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=true

  # (( ! $+functions[p10k] )) || p10k reload
}

(( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
'builtin' 'unset' 'p10k_config_opts'
