#!/bin/bash

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar

mv wp-cli.phar /usr/local/bin/wp

cd /var/www/wordpress

chmod -R 755 /var/www/wordpress/

chown -R www-data:www-data /var/www/wordpress
#---------------------------------------------------ping mariadb---------------------------------------------------#
ping_mariadb_container() {
	nc -zv mariadb 3306 > /dev/null
	return $? # return the exit status of the ping command
}
start_time=$(date +%s)
end_time=$((start_time + 20))
while [ $(date +%s) -lt $end_time ]; do
	ping_mariadb_container
	if [ $? -eq 0 ]; then
		echo "[========MARIADB IS UP AND RUNNING========]"
		break
	else
		echo "[========WAITING FOR MARIADB TO START...========]"
		sleep 1
	fi
done

if [ $(date +%s) -ge $end_time ]; then
	echo "[========MARIADB IS NOT RESPONDING========]"
else
	echo $(( $(date +%s) - start_time )) "s PASSED TO CONNECT"
fi
#-------------------------------------------------wp installation-------------------------------------------------#
if [ ! -f "/var/www/wordpress/index.php" ]; then
	# download wordpress core files
	wp core download --allow-root
	# create wp-config.php file with database details
	wp core config --dbhost=mariadb:3306 --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PWD" --allow-root
	# install wordpress with the given title, admin username, password and email
	wp core install --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_N" --admin_password="$WP_ADMIN_P" --admin_email="$WP_ADMIN_E" --allow-root
	#create a new user with the given username, email, password and role
	wp user create "$WP_U_NAME" "$WP_U_EMAIL" --user_pass="$WP_U_PASS" --role="$WP_U_ROLE" --allow-root

	# Update discussion settings to auto-approve comments
	wp option update comment_whitelist 0 --allow-root
fi

#---------------------------------------------------php config---------------------------------------------------#

# change listen port from unix socket to 9000
sed -i '36 s@/run/php/php7.4-fpm.sock@9000@' /etc/php/7.4/fpm/pool.d/www.conf
# create a directory for php-fpm
mkdir -p /run/php
# start php-fpm service in the foreground to keep the container running
exec /usr/sbin/php-fpm7.4 -F