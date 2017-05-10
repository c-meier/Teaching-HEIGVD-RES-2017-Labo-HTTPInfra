FROM httpd:2.4
LABEL maintainer Daniel Palumbo <daniel.palumbo@heig-vd.ch>
LABEL maintainer Christopher Meier <christopher.meier@heig-vd.ch>


# We copy the configuration of the server.
COPY ./custom_httpd.conf /usr/local/apache2/conf/httpd.conf

# We copy the web site files.
COPY ./httpdoc/ /usr/local/apache2/htdocs/

