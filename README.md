## A Sysconf profile

This is a [SYSCONF](https://github.com/geonef/sysconf.base)
profile. SYSCONF is a method and tool to manage custom system files
for easy install, backup and sync.


## PostgreSQL service

Once applied, a PostgreSQL should be running on the system:
```
tcp        0      0 0.0.0.0:5432            0.0.0.0:*               LISTEN      29057/postgres  
tcp6       0      0 :::5432                 :::*                    LISTEN      29057/postgres  
```


## Gitted import/export

This profile does not import/export anything by itself.

But its dependencies:
* sysconf.gitted [provides import/export](https://github.com/geonef/sysconf.gitted/tree/master/tree/etc/gitted/sync) of the ```sysconf/``` directory

* sysconf.gitted.postgresql
  [provides import/export](https://github.com/geonef/sysconf.gitted.postgresql/tree/master/tree/etc/gitted/sync)
  of PostgreSQL data


## Gitted integration

* To create a new Gitted repository, follow the instructions at
  [How to setup Gitted for an application](https://github.com/geonef/sysconf.gitted/blob/master/doc/howto-create-new.md)
  
* Then add this Sysconf profile:
```
git subtree add -P sysconf/sysconf.gitted.tt-rss git@github.com:geonef/sysconf.gitted.tt-rss.git master
```

* Integrate it in the dependency chain, for example:
```
echo sysconf.gitted.tt-rss >sysconf/actual/deps
```

* Then push it to the container:
```
sysconf/gitted-client register
git push <name> master
```


## Authors

Written by Jean-Francois Gigand <jf@geonef.fr>. Feel free to contact me!
