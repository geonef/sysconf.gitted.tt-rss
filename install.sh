# Installer script for sysconf "actual"  -*- shell-script -*-

. /usr/lib/sysconf.base/common.sh


# Install required Debian packages
_packages=
_packages="$_packages nginx"
_packages="$_packages php5-fpm php5-cli php5-pgsql php5-mcrypt"
sysconf_require_packages $_packages

# Fix Nginx
_force_nginx_restart=no
if [ -r /etc/nginx/sites-enabled/default ]; then
    rm -f /etc/nginx/sites-enabled/default
    _force_nginx_restart=yes
fi
if ps x | grep nginx | grep -vq grep; then
    if [ $_force_nginx_restart = yes ]; then
        service nginx restart
    fi
else
    service nginx start
fi

# Fix php-fpm
_force_fpm_restart=no
if [ -r /etc/php5/fpm/pool.d/www.conf ]; then
    rm -f /etc/php5/fpm/pool.d/www.conf
    _force_fpm_restart=yes
fi
if ps x | grep php-fpm | grep -vq grep; then
    if [ $_force_fpm_restart = yes ]; then
        service php5-fpm restart
    fi
else
    service php5-fpm start
fi

# Install Tiny Tiny RSS
www_dir=/var/lib/tt-rss
url=https://github.com/gothfox/Tiny-Tiny-RSS/archive/1.15.3.tar.gz
if [ ! -f $www_dir/index.php ]; then
    mkdir -p $www_dir
    curl -L $url | tar xzv --strip-components=1 --directory $www_dir \
        || nef_fatal "could not download TinyTinyRSS archive: $url"
    cd $www_dir
    chown -R www-data:www-data .
fi
