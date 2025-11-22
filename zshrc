# ~/.zshrc

# --- 1. TEMEL AYARLAR ---
setopt autocd              # Klasör ismini yazınca git
setopt interactivecomments # Yorum satırı izni
setopt promptsubst         # Prompt içinde değişken kullanımı
bindkey -e                 # Emacs modu

# --- 2. KALI LINUX PROMPT ---
local PR_SYMBOL='㉿'
[ "$EUID" -eq 0 ] && PR_SYMBOL='💀'

PROMPT=$'%F{blue}┌──${debian_chroot:+($debian_chroot)─}(%B%F{red}%n'$PR_SYMBOL$'%m%b%F{blue})-[%B%F{reset}%~%b%F{blue}]
└─%B%(#.%F{red}#.%F{blue}$)%b%F{reset} '

# --- 3. RENKLER VE ALIASLAR ---
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -l'
alias la='ls -a'

# Ok tuşları ile geçmişte arama
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# --- 4. EKLENTİLER (AKILLI YOL BULUCU) ---

# A) AUTOSUGGESTIONS (GRİ YAZI)
# Dosya yolunu otomatik ara
if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
else
    echo "UYARI: Autosuggestions bulunamadı! (pacman -Ql zsh-autosuggestions ile yolu kontrol et)"
fi
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# B) SYNTAX HIGHLIGHTING (RENKLENDİRME)
# Dosya yolunu otomatik ara
if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
    echo "UYARI: Syntax Highlighting bulunamadı! (pacman -Ql zsh-syntax-highlighting ile yolu kontrol et)"
fi