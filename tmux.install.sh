file=`eval echo ~$USER`/.tmux.conf
config="
# основные настройки\n
set-window-option -g mode-keys vi # vi key\n
set-option -g status-keys vi\n
set-window-option -g utf8 on # поддержка utf-8\n

#set -g mode-mouse on # влючить 'мышь'\n
#set -g mouse-select-pane off\n
#set -g mouse-resize-pane off\n
#set -g mouse-select-window off\n
\n
#set -g default-terminal 'screen-256color'\n
\n
# режим копирования на клавише 'Esc'\n
#unbind [\n
#bind Escape copy-mode\n
\n
# переместить буфер обмена tmux в буфер обмена X\n
#bind-key C-y run-shell 'tmux show-buffer | xclip' \; display-message 'Copied tmux buffer to system clipboard'#linux\n
bind-key Y run-shell 'tmux show-buffer | reattach-to-user-namespace pbcopy' \; display-message 'Copied tmux buffer to system clipboard'#mac\n
\n
# разделение на панели и перемещение\n
set-option -g mouse-select-pane on\n
#bind + split-window -h # horizontal split\n
#bind _ split-window -v # vertical split\n
#bind C-j previous-window\n
#bind C-k next-window\n
\n
# заголовок окна\n
set-option -g set-titles on\n
set-option -g set-titles-string '#S:#I.#P #W' # window number,program name,active (or not)\n
set-window-option -g automatic-rename on # auto name\n
\n
# сообщения\n
#set-window-option -g mode-bg magenta\n
#set-window-option -g mode-fg black\n
#set-option -g message-bg magenta\n
#set-option -g message-fg black\n
\n
# следующее окно\n
#bind-key -n C-right next\n
\n
# предыдущее окно\n
#bind-key -n C-left prev\n
\n
# панель состояния\n
set-option -g status-utf8 on\n
set-option -g status-justify right\n
set-option -g status-bg black\n
set-option -g status-fg cyan\n
set-option -g status-interval 5\n
set-option -g status-left-length 30\n
set-option -g status-left '#[fg=magenta]» #[fg=blue,bold]#T#[default]'\n
set-option -g status-right '#[fg=cyan]»» #[fg=blue,bold]###S #[fg=magenta]%R %m-%d#(acpi | cut -d ',' -f 2)#[default]'\n
set-option -g visual-activity on\n
#set-window-option -g monitor-activity on\n
set-window-option -g window-status-current-fg white\n
\n
# часы\n
set-window-option -g clock-mode-colour cyan\n
set-window-option -g clock-mode-style 24\n
"
if [ -f $file ]
then
	echo $file" exists"
else
	touch $file
	echo $file" created"
fi
while :
do
	echo "file $file (r)replace/(a)append/(c)cancel/(s)show"
	read line
	case "$line" in
		r)
			echo -e $config > $file
			exit 0
		;;
		a) 
			echo -e $config >> $file
			exit 0
		;;
		c)
			echo "cancel"
			exit 0
		;;
		s)
			echo -e $config
		;;
	esac
done

exit 0
