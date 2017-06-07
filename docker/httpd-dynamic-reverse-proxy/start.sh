#!\bin\bash

# Set ips

CONF_FILE="/etc/apache2/sites-available/001-reverse-proxy.conf"
#CONF_FILE="docker/httpd-dynamic-reverse-proxy/conf/sites-available/001-reverse-proxy.conf"

sed -i "s/{{ip_express_dynamic}}/$IP_EXPRESS_DYNAMIC/g" $CONF_FILE
sed -i "s/{{ip_httpd_ajax}}/$IP_HTTPD_AJAX/g" $CONF_FILE

# Start apache2
apache2 -DFOREGROUND