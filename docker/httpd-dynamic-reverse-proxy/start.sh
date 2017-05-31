#!\bin\bash

# Set ips
read -p "Waiting 1 ..."

CONF_FILE="/etc/apache2/sites-available/001-reverse-proxy.conf"
#CONF_FILE="docker/httpd-dynamic-reverse-proxy/conf/sites-available/001-reverse-proxy.conf"

read -p "Waiting 2 ..."

sed -i "s/{{ip_express_dynamic}}/$IP_EXPRESS_DYNAMIC/g" $CONF_FILE
sed -i "s/{{ip_httpd_ajax}}/$IP_HTTPD_AJAX/g" $CONF_FILE

read -p "Waiting 3 ..."

# Start apache2
apache2 -DFOREGROUND

read -p "Waiting 4 ..."