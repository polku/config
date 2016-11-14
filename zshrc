PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/texbin
HISTFILE=~/.zshrc_history
SAVEHIST=5000
HISTSIZE=5000

setopt inc_append_history
setopt share_history

if [[ -f ~/.myzshrc ]]; then
  source ~/.myzshrc
fi

USER=`/usr/bin/whoami`
export USER
GROUP=`/usr/bin/id -gn $user`
export GROUP
MAIL="$USER@student.42.fr"
export MAIL

PROMPT="%~> "

alias gg='llvm-gcc -Wall -Wextra -Werror'
alias gcc='llvm-gcc -g -Wall -Wextra'
alias ll='ls -lhG'
alias ruby='/nfs/zfs-student-2/users/2013/jmaurice/ruby-2.1.0/bin/ruby'
alias e='emacs -nw'

mkcd () {
    mkdir $1 && cd $1
}

export PATH=$PATH:~/bin/
export PATH=$PATH:~/.brew/bin/
