[ -f ~/.profile ] && source ~/.profile
[ -f ~/.bashrc ] && source ~/.bashrc
alias "tb=source ~/toolbox/toolbox"
# iTerm Badge
printf "\e]1337;SetBadgeFormat=%s\a" \
  $(echo -n "\(session.name)" | base64)

# Please dont source the toolbox in here. It messes up iTerm profiles. Thanks
