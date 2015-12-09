# docker-vbulletin

Dockerfile to build a vBulletin container image.
Faster update for new vBulletin versions.

Download vBulletin zip from [Members area](https://members.vbulletin.com/), rename it, and put in this folder: `./vbulletin5.zip`

### Build container

```
$ docker build -t vbulletin .
```

### docker-compose

Use Docker compose for start the application.
See `docker-compose.yml`

* nginx (port 80)
* vbulletin

Change `/var/www` host path to your persistent vBulletin assets.

```
$ docker-compose up -d
```

### Additional notes

* Change the location of vBulletin files in docker-compose.yml: `/var/www`
* `start.sh` perform vBulletin upgrade at every launch
* You should clear cache in: `Admin CP > Maintenance > Clear System Cache`
* You may perform maintenance operation:
	* `Maintenance > General Update Tools > Rebuild Forum Information`
	* `Maintenance > General Update Tools > Rebuild Styles`


## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request ;)
