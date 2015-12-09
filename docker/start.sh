#!/bin/bash

# Execute update
(cd core/install ; php -f update.php)

# Remove installation folder
rm -rf core/install

# Start service
php5-fpm -F
