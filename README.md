#  Arch Linux: Kali Style Zsh Kurulumu

Bu rehber; Arch Linux terminaline **Kali Linux'un ikonik görünümünü**, **otomatik tamamlamasını** (autosuggestions) ve **kod renklendirmesini** (syntax highlighting) kazandırır.

Sıradan Bash kabuğundan sıkılanlar ve Arch Linux'un gücünü Kali Linux'un karizmasıyla birleştirmek isteyenler için hazırlanmıştır.

## Özellikler

*   **Kali Linux Prompt:** Root kullanıcı için kurukafa (💀), normal kullanıcı için Kali logosu (㉿).
*   **Çift Satırlı Yapı:** Klasör yolu üstte, komut satırı altta (daha temiz bir görünüm).
*   **Autosuggestions:** Geçmiş komutları gri renk ile otomatik önerir.
*   **Syntax Highlighting:** Komutları doğru yazdığınızda yeşil, hatalı yazdığınızda kırmızı gösterir.
*   **Akıllı Geçmiş:** Yukarı/Aşağı ok tuşları ile geçmiş komutlar arasında akıllı arama yapar.

---

## 📦 1. Adım: Gerekli Paketlerin Kurulumu

Zsh kabuğunu ve gerekli eklentileri resmi Arch depolarından yükleyin:

```bash
sudo pacman -S zsh zsh-syntax-highlighting zsh-autosuggestions zsh-completions fzf
```

## 📦2. Adım: Çakışan Paketlerin Temizlenmesi

Arch tabanlı hazır sistemlerde (ALG, EndeavourOS, Manjaro vb.) gelen ve ayarları bozan varsayılan yapılandırma paketini kaldırın.

```bash
sudo pacman -Rns grml-zsh-config
#Not: Eğer "Paket bulunamadı" hatası alırsanız sorun yok, zaten yüklü değildir. Bir sonraki adıma geçin.
```


## 3. Adım: .zshrc Yapılandırması

Kullanıcı ayar dosyasını favori editörünüzle açın (nano, vim veya mousepad):


```bash
nano ~/.zshrc
# veya
mousepad ~/.zshrc
```
Dosyanın içini tamamen temizleyin ve aşağıdaki kodu yapıştırıp kaydedin:

```bash
# ~/.zshrc
# Arch Linux için Kali Style Yapılandırma

# --- 1. TEMEL AYARLAR ---
setopt autocd              # Klasör ismini yazınca içine gir
setopt interactivecomments # Komut satırında yoruma izin ver
setopt promptsubst         # Prompt içinde değişken kullan
bindkey -e                 # Standart tuş düzeni

# --- 2. GEÇMİŞ (HISTORY) AYARLARI ---
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups    # Tekrarlayan komutları kaydetme
setopt share_history       # Geçmişi terminaller arası paylaş

# --- 3. KALI LINUX PROMPT (GÖRÜNÜM) ---
# Root kullanıcısı için kurukafa, normal kullanıcı için Kali logosu
local PR_SYMBOL='㉿'
[ "$EUID" -eq 0 ] && PR_SYMBOL='💀'

# Çift satırlı, renkli prompt yapısı
PROMPT=$'%F{blue}┌──${debian_chroot:+($debian_chroot)─}(%B%F{red}%n'$PR_SYMBOL$'%m%b%F{blue})-[%B%F{reset}%~%b%F{blue}]
└─%B%(#.%F{red}#.%F{blue}$)%b%F{reset} '

# --- 4. RENKLENDİRME VE ALIASLAR ---
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ip='ip --color=auto'
alias ll='ls -l'
alias la='ls -a'

# Yukarı/Aşağı ok tuşları ile geçmişte akıllı arama
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# --- 5. EKLENTİLER (AKILLI YÜKLEME) ---
# Arch Linux'ta olası dosya yollarını kontrol edip yükler.

# A) AUTOSUGGESTIONS (Gri Yazı Tamamlama)
if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8' # Gri renk tonu

# B) SYNTAX HIGHLIGHTING (Renkli Komutlar)
# DİKKAT: Bu modül her zaman EN SONDA yüklenmelidir.
if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
# --- 6. GELİŞMİŞ TUŞ BAĞLANTILARI (KEYBINDINGS) - Arch + Modern Terminal için ---
# Ctrl+Left / Ctrl+Right → kelime atlama
bindkey '^[[1;5C' forward-word   # Ctrl + Right
bindkey '^[[1;5D' backward-word  # Ctrl + Left

# Bazı terminaller (kitty, alacritty, wezterm) farklı sekans gönderir
bindkey '^[[C' forward-word      # Bazen sadece Right bile yeter
bindkey '^[[D' backward-word
bindkey '^[OC' forward-word      # ESC + OC (bazı terminaller)
bindkey '^[OD' backward-word

# Alt+Left / Alt+Right (bazı kullanıcılar bunu da sever)
bindkey '^[f' forward-word       # Alt + f (emacs stili)
bindkey '^[b' backward-word      # Alt + b

# Home / End tuşları düzgün çalışsın
bindkey '^[[H' beginning-of-line # Home
bindkey '^[[F' end-of-line       # End
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line

# Delete tuşu
bindkey '^[[3~' delete-char

# Ctrl+Backspace → bir kelime sil
bindkey '^H' backward-kill-word   # Ctrl + Backspace
bindkey '^[[3;5~' kill-word       # Ctrl + Delete

# Ctrl+U → satırın başından imlece kadar sil (çok kullanışlı)
bindkey '^U' backward-kill-line

# Ctrl+W → bir kelime geri sil (bash gibi)
bindkey '^W' backward-kill-word

# Bonus: fzf ile geçmiş arama (eğer fzf kuruluysa, çok güzel olur)
if command -v fzf >/dev/null 2>&1; then
    source /usr/share/fzf/key-bindings.zsh 2>/dev/null || \
    source /usr/share/doc/fzf/examples/key-bindings.zsh 2>/dev/null
fi
```

##  4. Adım: Varsayılan Kabuğu Değiştirme

Sistemin varsayılan olarak Zsh kullanması için şu komutu girip şifrenizi yazın:


```bash
chsh -s /bin/zsh
```

## 5. Adım: Uygulama

Değişiklikleri görmek için terminali kapatıp açın veya şu komutu girin:

```bash
zsh
```

## 📦 6. Adım: Fontu Resmi Depolardan Yükle

Fire code fontunu yükleyin:

```bash
sudo pacman -S ttf-fira-code
```


## 📦 7. Adım: Font Önbelleğini Güncelle

Sistemin yeni yüklenen fontu hemen tanıması için font önbelleğini yenilememiz gerekir:

```bash
fc-cache -fv
```

