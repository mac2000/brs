Backup, restore and sync scripts
================================

	TODO: make install script

Get needed scripts and change their settings.

Make them executable and not accessible for everyone else: `chmod 700 backup.sh`, and add them to daily cron job:

	sudo ln -s /home/mac/backup.sh /etc/cron.daily/mac-backup

Important thing here is to remember that cron include only files without extensions.

Also do not forget to create backups directory:

	mkdir -p /home/mac/backups

And make it not accessible:

	chmod 700 /home/mac/backups