# pepyakabox #

Vagrant box for amateur PHP development.

Pepyakas included.

## What's under the hood?

### nginx

Somewhat universal config can be found in `etc/nginx/sites-available/template`.

Site logs are stored in the `log/<project_name>/` directory.

### MySQL 5.6

Default user: `root`.

Default password: `root`.

### PHP

Both FPM and CLI.

Available versions:

* 5.6
* 7.1

Available modules:

* mysql
* curl
* gd
* xml
* mbstring
* zip
* sqlite3
* mcrypt
* intl
* soap 
* imagick
* xdebug
* bcmath
* imap

### git

`__git_ps1` and git autocomplete included.

### E-mail catcher

Catches all e-mails sent with `mail()` PHP function and stores them in the `log/sendmail/` directory.

### BlackFire Agent

Not configured, though.

## How do I shot the web?

1. Install VirtualBox and Vagrant

2. Clone the repo:

	```
	$ git clone git@bitbucket.org:torunar/pepyakabox.git pepyakabox
	```

3. Provision the enviroment:

	```
	$ cd pepyakabox
	```

	```
	$ vagrant up
	```

4. Put your source code into the `www/<project_name>` directory.

5. Add new site using default nginx config:

    ```
    $ ./tools/site-add <project_name>
    ```

6. All done.
