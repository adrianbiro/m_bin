# generate basic competion for yt-dlp
complete -W "$(yt-dlp -h | awk '$1 ~ /--.*/&&!/sponsorblock/{print $1}')" yt-dlp
