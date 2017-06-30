#software
alias vim='vim -p'

# git
alias g-co='git checkout'
alias g-st='git status -s'
alias g-ad='git add'
alias g-rm='git rm'
alias g-cm='git commit'
alias g-dt='git difftool'
alias g-fr='git fetch && git rebase'
alias g-hs='git log --pretty=%s%nhttps://github.com/`git remote -v | grep -Eioe "([a-z0-9_\-]+)/([a-z0-9_\-]+)" | tail -n 1`/commit/%H%n'
