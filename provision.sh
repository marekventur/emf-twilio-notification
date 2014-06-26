apt-get update
apt-get install apache2 libapache2-mod-wsgi python python-dev python-tz python-zopeinterface python-setuptools python-reportlab python-libxslt1 python-libxml2 python-imaging python-dateutil python-support libxslt1-dev libxml2-dev -y

easy_install -U setuptools
pip install virtualenv
easy_install -U pytz
easy_install -U reportlab
easy_install -U simplejson

virtualenv indico-dev

easy_install indico

a2enmod wsgi

# Set up daemon for zodb
cp zodb.sh /etc/init.d/zodb
chmod a+wr /usr/local/lib/python2.7/dist-packages/zc.queue-1.3-py2.7.egg/EGG-INFO/* # Don't ask me about this
service zodb start

# Set up apache config
a2disite 000-default
cp indico-apach /etc/apache2/sites-available/indico
a2ensite indico
sudo service apache2 restart

## From here on you might have to run the rest by hand
# sudo indico_initial_setup # <enter> , then "c" and a few more <enters>
# sudo service apache2 restart
