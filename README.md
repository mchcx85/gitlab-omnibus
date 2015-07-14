# Omnibus GitLab

This project creates full-stack platform-specific [downloadable packages for GitLab][downloads].
For other installation options please see the
[GitLab installation page][installation].

## Canonical source

The source of omnibus-gitlab is [hosted on
GitLab.com](https://gitlab.com/gitlab-org/omnibus-gitlab) and there are mirrors
to make contributing as easy as possible.

## Documentation version

Please make sure you are viewing the documentation for the version of
omnibus-gitlab you are using. In most cases this should be the highest numbered
stable branch (example shown below).

![documentation version](doc/images/omnibus-documentation-version.png)

## Omnibus fork

Omnibus GitLab is using a fork of [omnibus project](https://github.com/chef/omnibus). Fork is located at [gitlab.com](https://gitlab.com/gitlab-org/omnibus).

## GitLab CI

To setup GitLab CI please see the [separate GitLab CI
documentation](doc/gitlab-ci/README.md).

## Configuration options

See [doc/settings/configuration.md](doc/settings/configuration.md).

##### Configuring the external URL for GitLab

See [doc/settings/configuration.md](doc/settings/configuration.md#configuring-the-external-url-for-gitlab).

##### Storing Git data in an alternative directory

See [doc/settings/configuration.md](doc/settings/configuration.md#storing-git-data-in-an-alternative-directory).

##### Changing the name of the Git user / group

See [doc/settings/configuration.md](doc/settings/configuration.md#changing-the-name-of-the-git-user-group).

##### Setting up LDAP sign-in

See [doc/settings/ldap.md](doc/settings/ldap.md).

##### Enable HTTPS

See [doc/settings/nginx.md](doc/settings/nginx.md#enable-https).

##### Redirect `HTTP` requests to `HTTPS`.

See [doc/settings/nginx.md](doc/settings/nginx.md#redirect-http-requests-to-https).

##### Change the default port and the ssl certificate locations.

See [doc/settings/nginx.md](doc/settings/nginx.md#change-the-default-port-and-the-ssl-certificate-locations).

##### Use non-packaged web-server

For using an existing Nginx, Passenger, or Apache webserver see [doc/settings/nginx.md](doc/settings/nginx.md#using-a-non-bundled-web-server).

##### Using a non-packaged PostgreSQL database management server

To connect to an external PostgreSQL or MySQL DBMS see [doc/settings/database.md](doc/settings/database.md) (MySQL support in the Omnibus Packages is Enterprise Only).

##### Using a non-packaged Redis instance

See [doc/settings/redis.md](doc/settings/redis.md).

##### Adding ENV Vars to the Gitlab Runtime Environment

See
[doc/settings/environment-variables.md](doc/settings/environment-variables.md).

##### Changing gitlab.yml settings

See [doc/settings/gitlab.yml.md](doc/settings/gitlab.yml.md).

##### Specify numeric user and group identifiers

See [doc/settings/configuration.md](doc/settings/configuration.md#specify-numeric-user-and-group-identifiers).

##### Sending application email via SMTP

See [doc/settings/smtp.md](doc/settings/smtp.md).

##### Omniauth (Google, Twitter, GitHub login)

Omniauth configuration is documented in
[doc.gitlab.com](http://doc.gitlab.com/ce/integration/omniauth.html).

##### Adjusting Unicorn settings

See [doc/settings/unicorn.md](doc/settings/unicorn.md).

##### Setting the NGINX listen address or addresses

See [doc/settings/nginx.md](doc/settings/nginx.md).

##### Inserting custom NGINX settings into the GitLab server block

See [doc/settings/nginx.md](doc/settings/nginx.md).

##### Inserting custom settings into the NGINX config

See [doc/settings/nginx.md](doc/settings/nginx.md).

## Installation

Please follow the steps on the [downloads page][downloads].

### After installation

Run `sudo gitlab-ctl status`; the output should look like this:

```
run: nginx: (pid 972) 7s; run: log: (pid 971) 7s
run: postgresql: (pid 962) 7s; run: log: (pid 959) 7s
run: redis: (pid 964) 7s; run: log: (pid 963) 7s
run: sidekiq: (pid 967) 7s; run: log: (pid 966) 7s
run: unicorn: (pid 961) 7s; run: log: (pid 960) 7s
```

If any of the processes is not behaving like expected, try tailing their logs
to see what is wrong.

```
sudo gitlab-ctl tail postgresql
```

Your GitLab instance should reachable over HTTP at the IP or hostname of your server.
You can login as an admin user with username `root` and password `5iveL!fe`.

#### Starting and stopping

After omnibus-gitlab is installed and configured, your server will have a Runit
service directory (`runsvdir`) process running that gets started at boot via
`/etc/inittab` or the `/etc/init/gitlab-runsvdir.conf` Upstart resource.  You
should not have to deal with the `runsvdir` process directly; you can use the
`gitlab-ctl` front-end instead.

You can start, stop or restart GitLab and all of its components with the
following commands.

```shell
# Start all GitLab components
sudo gitlab-ctl start

# Stop all GitLab components
sudo gitlab-ctl stop

# Restart all GitLab components
sudo gitlab-ctl restart
```

Note that on a single-core server it may take up to a minute to restart Unicorn
and Sidekiq. Your GitLab instance will give a 502 error until Unicorn is up
again.

It is also possible to start, stop or restart individual components.

```shell
sudo gitlab-ctl restart sidekiq
```

Unicorn supports zero-downtime reloads. These can be triggered as follows:

```shell
sudo gitlab-ctl hup unicorn
```

Note that you cannot use a Unicorn reload to update the Ruby runtime.

### Updating

Instructions for updating your Omnibus installation and upgrading from a manual installation are in the [update doc](doc/update.md).

### Uninstalling omnibus-gitlab

To uninstall omnibus-gitlab, preserving your data (repositories, database, configuration), run the following commands.

```
# Stop gitlab and remove its supervision process
sudo gitlab-ctl uninstall

# Debian/Ubuntu
sudo dpkg -r gitlab

# Redhat/Centos
sudo rpm -e gitlab
```

To remove all omnibus-gitlab data use `sudo gitlab-ctl cleanse`.

To remove all users and groups created by omnibus-gitlab, before removing the gitlab package (with dpkg or yum) run `sudo gitlab-ctl remove_users`. *Note* All gitlab processes need to be stopped before runnign the command.

### Common installation problems

This section has been moved to the separate document [doc/common_installation_problems.md](doc/common_installation_problems.md).

Section below remains for historical reasons(mainly to not break existing links). Each section contains the link to the new location.

##### Apt error 'The requested URL returned error: 403'

See [doc/common_installation_problems.md](doc/common_installation_problems.md#apt-error-the-requested-url-returned-error-403).

##### GitLab is unreachable in my browser

See [doc/common_installation_problems.md](doc/common_installation_problems.md#gitlab-is-unreachable-in-my-browser).

##### GitLab CI shows GitLab login page

See [doc/common_installation_problems.md](doc/common_installation_problems.md#gitlab-ci-shows-gitlab-login-page).

##### Emails are not being delivered

See [doc/common_installation_problems.md](doc/common_installation_problems.md#emails-are-not-being-delivered).

##### Reconfigure freezes at `ruby_block[supervise_redis_sleep] action run`

See [doc/common_installation_problems.md](doc/common_installation_problems.md#reconfigure-freezes-at-ruby_blocksupervise_redis_sleep-action-run).

##### TCP ports for GitLab services are already taken

See [doc/common_installation_problems.md](doc/common_installation_problems.md#tcp-ports-for-gitlab-services-are-already-taken).

##### Git SSH access stops working on SELinux-enabled systems

See [doc/common_installation_problems.md](doc/common_installation_problems.md#git-ssh-access-stops-working-on-selinux-enabled-systems
).

##### Postgres error 'FATAL:  could not create shared memory segment: Cannot allocate memory'

See [doc/common_installation_problems.md](doc/common_installation_problems.md#postgres-error-fatal-could-not-create-shared-memory-segment-cannot-allocate-memory).

##### Reconfigure complains about the GLIBC version

See [doc/common_installation_problems.md](doc/common_installation_problems.md#reconfigure-complains-about-the-glibc-version).

##### Reconfigure fails to create the git user

See [doc/common_installation_problems.md](doc/common_installation_problems.md#reconfigure-fails-to-create-the-git-user).

##### Failed to modify kernel parameters with sysctl

See [doc/common_installation_problems.md](doc/common_installation_problems.md#failed-to-modify-kernel-parameters-with-sysctl).

##### I am unable to install omnibus-gitlab without root access

See [doc/common_installation_problems.md](doc/common_installation_problems.md#i-am-unable-to-install-omnibus-gitlab-without-root-access).

##### gitlab-rake assets:precompile fails with 'Permission denied'

See [doc/common_installation_problems.md](doc/common_installation_problems.md#gitlab-rake-assetsprecompile-fails-with-permission-denied).

##### 'Short read or OOM loading DB' error

See [doc/common_installation_problems.md](doc/common_installation_problems.mdr#short-read-or-oom-loading-db-error).


## Configuration

### Backup and restore omnibus-gitlab configuration

All configuration for omnibus-gitlab is stored in `/etc/gitlab`. To backup your
configuration, just backup this directory.

```shell
# Example backup command for /etc/gitlab:
# Create a time-stamped .tar file in the current directory.
# The .tar file will be readable only to root.
sudo sh -c 'umask 0077; tar -cf $(date "+etc-gitlab-%s.tar") -C / etc/gitlab'
```

You can extract the .tar file as follows.

```shell
# Rename the existing /etc/gitlab, if any
sudo mv /etc/gitlab /etc/gitlab.$(date +%s)
# Change the example timestamp below for your configuration backup
sudo tar -xf etc-gitlab-1399948539.tar -C /
```

Remember to run `sudo gitlab-ctl reconfigure` after restoring a configuration
backup.

NOTE: Your machines SSH host keys are stored in a separate location at `/etc/ssh/`. Be sure to also [backup and restore those keys](https://superuser.com/questions/532040/copy-ssh-keys-from-one-server-to-another-server/532079#532079) to avoid man-in-the-middle attack warnings if you have to perform a full machine restore.



## Backups

If you are using non-packaged database see [documentation on using non-packaged database](doc/settings/database.md#using-a-non-packaged-postgresql-database-management-server).

### Creating an application backup

To create a backup of your repositories and GitLab metadata, follow the [backup create documentation](http://doc.gitlab.com/ce/raketasks/backup_restore.html#create-a-backup-of-the-gitlab-system).

Backup create will store a tar file in `/var/opt/gitlab/backups`.

Similarly for CI, backup create will store a tar file in `/var/opt/gitlab/ci-backups`.

If you want to store your GitLab backups in a different directory, add the
following setting to `/etc/gitlab/gitlab.rb` and run `sudo gitlab-ctl
reconfigure`:

```ruby
gitlab_rails['backup_path'] = '/mnt/backups'
```

### Restoring an application backup

See [backup restore documentation](http://doc.gitlab.com/ce/raketasks/backup_restore.html#omnibus-installations).

### Upload backups to remote (cloud) storage

For details check [backup restore document of GitLab CE](https://gitlab.com/gitlab-org/gitlab-ce/blob/966f68b33e1f15f08e383ec68346ed1bd690b59b/doc/raketasks/backup_restore.md#upload-backups-to-remote-cloud-storage).

## Invoking Rake tasks

To invoke a GitLab Rake task, use `gitlab-rake` (for GitLab) or
`gitlab-ci-rake` (for GitLab CI). For example:

```shell
sudo gitlab-rake gitlab:check
sudo gitlab-ci-rake -T
```

Leave out 'sudo' if you are the 'git' user or the 'gitlab-ci' user.

Contrary to with a traditional GitLab installation, there is no need to change
the user or the `RAILS_ENV` environment variable; this is taken care of by the
`gitlab-rake` and `gitlab-ci-rake` wrapper scripts.

## Directory structure

Omnibus-gitlab uses four different directories.

- `/opt/gitlab` holds application code for GitLab and its dependencies.
- `/var/opt/gitlab` holds application data and configuration files that
  `gitlab-ctl reconfigure` writes to.
- `/etc/gitlab` holds configuration files for omnibus-gitlab. These are
  the only files that you should ever have to edit manually.
- `/var/log/gitlab` contains all log data generated by components of
  omnibus-gitlab.

## Omnibus-gitlab and SELinux

Although omnibus-gitlab runs on systems that have SELinux enabled, it does not
use SELinux confinement features:
- omnibus-gitlab creates unconfined system users;
- omnibus-gitlab services run in an unconfined context.

The correct operation of Git access via SSH depends on the labeling of
`/var/opt/gitlab/.ssh`. If needed you can restore this labeling by running
`sudo gitlab-ctl reconfigure`.

Depending on your platform, `gitlab-ctl reconfigure` will install SELinux
modules required to make GitLab work. These modules are listed in
[files/gitlab-selinux/README.md](files/gitlab-selinux/README.md).

NSA, if you're reading this, we'd really appreciate it if you could contribute back a SELinux profile for omnibus-gitlab :)
Of course, if anyone else is reading this, you're welcome to contribute the SELinux profile too.

### Logs

This section has been moved to separate document [doc/settings/logs.md](doc/settings/logs.md).

##### Tail logs in a console on the server

See [doc/settings/logs.md](doc/settings/logs.md#tail-logs-in-a-console-on-the-server).

##### Runit logs

See [doc/settings/logs.md](doc/settings/logs.md#runit-logs).

##### Logrotate

See [doc/settings/logs.md](doc/settings/logs.md#logrotate).

##### UDP log shipping (GitLab Enterprise Edition only)

See [doc/settings/logs.md](doc/settings/logs.md#udp-log-shipping-gitlab-enterprise-edition-only)

## Starting a Rails console session

If you need access to a Rails production console for your GitLab installation
you can start one with the command below. Please be warned that it is very easy
to inadvertently modify, corrupt or destroy data from the console.

```shell
# start a Rails console for GitLab
sudo gitlab-rails console

# start a Rails console for GitLab CI
sudo gitlab-ci-rails console
```

This will only work after you have run `gitlab-ctl reconfigure` at least once.

## Using a MySQL database management server (Enterprise Edition only)

See [doc/settings/database.md](doc/settings/database.md).

### Create a user and database for GitLab

See [doc/settings/database.md](doc/settings/database.md).

### Configure omnibus-gitlab to connect to it

See [doc/settings/database.md](doc/settings/database.md).

### Seed the database (fresh installs only)

See [doc/settings/database.md](doc/settings/database.md).

## Only start omnibus-gitlab services after a given filesystem is mounted

If you want to prevent omnibus-gitlab services (nginx, redis, unicorn etc.)
from starting before a given filesystem is mounted, add the following to
`/etc/gitlab/gitlab.rb`:

```ruby
# wait for /var/opt/gitlab to be mounted
high_availability['mountpoint'] = '/var/opt/gitlab'
```

## Building your own package

See [the separate build documentation](doc/build.md).

## Running a custom GitLab version

It is not recommended to make changes to any of the files in `/opt/gitlab`
after installing omnibus-gitlab: they will either conflict with or be
overwritten by future updates. If you want to run a custom version of GitLab
you can [build your own package](doc/build.md) or use [another installation
method][CE README].

## Acknowledgments

This omnibus installer project is based on the awesome work done by Chef in
[omnibus-chef-server][omnibus-chef-server].

[downloads]: https://about.gitlab.com/downloads/
[CE README]: https://gitlab.com/gitlab-org/gitlab-ce/blob/master/README.md
[omnibus-chef-server]: https://github.com/opscode/omnibus-chef-server
[database.yml.mysql]: https://gitlab.com/gitlab-org/gitlab-ce/blob/master/config/database.yml.mysql
[svlogd]: http://smarden.org/runit/svlogd.8.html
[installation]: https://about.gitlab.com/installation/
[gitlab.rb.template]: https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/files/gitlab-config-template/gitlab.rb.template
