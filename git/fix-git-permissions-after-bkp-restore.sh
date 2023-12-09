for i in $(,gitstat | grep '^/'); do cd $i; git reset --hard HEAD ; done

