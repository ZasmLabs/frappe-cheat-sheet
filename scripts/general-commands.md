# ERPNext / Frappe — Day-to-Day Command Reference

_Run from inside your bench directory. Replace `yoursite.local`, `app_name`, paths, and credentials with your own._


## 1. Discovery / Inventory

- show bench and all app versions (frappe, erpnext, custom apps)

```bench --version```


- list every site on this bench

```find sites -maxdepth 2 -name site_config.json -printf '%h\n' | sed 's#sites/##'```

- list apps installed on a specific site

```bench --site yoursite.local list-apps```

- list apps available in the bench environment

```bench list-apps```

- show the effective config for a site (db, redis, flags)

```bench --site yoursite.local show-config```

## 2. Backup & Restore

- back up the database only (fast, for routine snapshots)

```bench --site yoursite.local backup```

- back up database + public & private files (before any risky change)

```bench --site yoursite.local backup --with-files```

- back up every site on the bench, with files

```bench --site all backup --with-files```

- list where backups are written

```ls -lh sites/yoursite.local/private/backups/```

- restore a database (DESTRUCTIVE: overwrites current data)

```bench --site yoursite.local --force restore /path/to/database.sql.gz```

- restore database together with files (DESTRUCTIVE)

```bench --site yoursite.local --force restore /path/to/database.sql.gz --with-public-files /path/to/files.tar  --with-private-files /path/to/private-files.tar```

## 3. Users & Access Administration

- reset the Administrator password

```bench --site yoursite.local set-admin-password 'NewPassword123'```

- create a new System Manager user

```bench --site yoursite.local add-system-manager user@example.com --first-name Admin --password 'NewPassword123'```

- reset any user's password (one-off via execute)
```bench --site yoursite.local execute frappe.utils.password.update_password --args "['user@example.com', 'NewPassword123']"```

- reset any user's password reliably (via console, commits explicitly)
```bench --site yoursite.local console <<< 'from frappe.utils.password import update_password; update_password ("user@example.com", "NewPassword123"); frappe.db.commit()'```

## 4. Maintenance Mode & Service Control

- turn ON maintenance mode for a site

```bench --site yoursite.local set-config maintenance_mode 1```

- turn OFF maintenance mode for a site

```bench --site yoursite.local set-config maintenance_mode 0```

- restart all bench processes (web, workers, scheduler)

```bench restart```

- check production process status (supervisor)

```sudo supervisorctl status```

- validate and reload nginx

```sudo nginx -t && sudo systemctl reload nginx```

## 5. Updates & Migrations

- run pending migrations/patches for one site

```bench --site yoursite.local migrate```

- run migrations for every site

```bench --site all migrate```

- apply patches + migrate without pulling new code (safer)

```bench update --patch```

- full update: pull code, build, migrate, restart (RISKY ON PROD — back up first)

```bench update```

- switch frappe + erpnext to another branch and upgrade (RISKY — back up first)

```bench switch-to-branch version-15 frappe erpnext --upgrade```

- fetch a new app into the bench from git

```bench get-app https://github.com/org/app_name```

- install an app onto a site

```bench --site yoursite.local install-app app_name```

- uninstall an app from a site (DESTRUCTIVE — drops the app's data)

```bench --site yoursite.local uninstall-app app_name```

## 6. Cache & Build

- clear cache for a site

```bench --site yoursite.local clear-cache```

- clear website (portal) cache

```bench --site yoursite.local clear-website-cache```

- rebuild all JS/CSS assets

```bench build```

- rebuild assets for one app

```bench build --app app_name```

- build minified production assets

```bench build --production```

## 7. Scheduler & Background Jobs

- show scheduler status

```bench --site yoursite.local scheduler status```

- enable the scheduler

```bench --site yoursite.local scheduler enable```

- disable the scheduler

```bench --site yoursite.local scheduler disable```

- pause the scheduler (keeps it enabled but holds jobs)

```bench --site yoursite.local scheduler pause```

- resume the scheduler

```bench --site yoursite.local scheduler resume```

- overall bench health (workers, redis, scheduler)

```bench doctor```

## 8. Database & Console Access

- open the site's MariaDB/MySQL console

```bench --site yoursite.local mariadb```

- open a python console with frappe loaded

```bench --site yoursite.local console```

- run a server-side method directly

```bench --site yoursite.local execute frappe.utils.scheduler.enable_scheduler```

## 9. Logs & Config

- follow the web/gunicorn log

```tail -f logs/web.log```

- follow the background worker log

```tail -f logs/worker.log```

- follow the scheduler log

```tail -f logs/schedule.log```

- show all config values for a site

```bench --site yoursite.local show-config```

- set a config value (example: max upload size in bytes)

```bench --site yoursite.local set-config max_file_size 10485760```

- enable developer mode (development only)
```bench --site yoursite.local set-config developer_mode 1```
