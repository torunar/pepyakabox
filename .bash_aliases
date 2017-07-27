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
alias g-hs='git log --pretty=%s%nhttps://github.com/`git remote -v | tail -n 1 | cut -d":" -f 2 | cut -d" " -f 1 | sed -E "s#(\.git|//github\.com/)##g"`/commit/%H%n'
