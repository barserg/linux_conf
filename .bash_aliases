# This configuration file I use not only for bash aliases but for all my custom .bashrc settings
#
# For these settings to be loaded on user login, your .bashrc file should have something like this:
#       [ -f ~/.bash_aliases ] && . ~/.bash_aliases

### Aliases block #############

# Some default ls aliases (just in case)
alias ll='ls -alF --group-directories-first'
alias la='ls -A'
alias l='ls -CF'

# Custom aliases for lazy:
alias m='mcedit'
alias v='mcview'
alias c='cat'
alias grepcfg='grep -v "^\(\s*#\|\s*$\)"'
alias scprsync="rsync --partial --progress --rsh=ssh"
#alias dush='du -s *|sort -nr|cut -f 2-|while read a;do du -hs "$a";done'
alias dush='du -sh * | sort -hr'

# Custom alias functions:
function mkdc { mkdir $@ && cd ${!#}; }

# My packages packs
alias aptInstallMySoftPack='apt install mc htop sudo vim git w3m curl p7zip pigz sysstat rsync tmux nload iftop iotop atop tcpdump ntfs-3g cifs-utils samba dnsutils psmisc'
alias yumInstallMySoftPack='yum install mc htop sudo vim git w3m curl p7zip pigz sysstat rsync tmux nload iftop iotop atop tcpdump ntfs-3g cifs-utils samba'

###############################


# SSH-Agent auto start ########
mySSHkey=~/.ssh/barserg
env=~/.ssh/agent.env

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
        (umask 077; ssh-agent >| "$env")
        . "$env" >| /dev/null ; }

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2= agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
        agent_start
        ssh-add "$mySSHkey"
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
        ssh-add
fi

unset env
unset mySSHkey
###############################




