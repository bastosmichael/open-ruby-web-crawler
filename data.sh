#!/bin/bash

if [ $# -eq 0 ]
then
	echo "data.sh [options] all|sellers|categories|listings|offers"
elif [ $1 == 'all' ]; then
        echo "Migrating All Files..."
        cat sellers.yml db/sellers.yml | sort | uniq > db/sellers.yml
        cat categories.yml db/categories.yml | sort | uniq > db/categories.yml
        cat listings.json db/listings.json | sort | uniq > db/listings.json
        cat offers.json db/offers.json | sort | uniq > db/offers.json
        echo "Done."
elif [ $1 == 'sellers' ]; then
        echo "Migrating Sellers YAML..."
        cat sellers.yml db/sellers.yml | sort | uniq > db/sellers.yml
        echo "Done."
elif [ $1 == 'categories' ]; then
        echo "Migrating Categories YAML..."
        cat categories.yml db/categories.yml | sort | uniq > db/categories.yml
        echo "Done."
elif [ $1 == 'listings' ]; then
        echo "Migrating Listings JSON..."
        cat listings.json db/listings.json | sort | uniq > db/listings.json
        echo "Done."
elif [ $1 == 'offers' ]; then
        echo "Migrating Offers JSON..."
        cat offers.json db/offers.json | sort | uniq > db/offers.json
        echo "Done."
fi