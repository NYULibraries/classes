# Classes

A Rails 3.x application for managing and registering for NYU Libraries classes. For more information check out the [Classes](http://github.com/NYULibraries/classes/wiki) wiki.

## Configuring LDAP

The app uses LDAP to do a simple check making sure that the registrant's user ID is valid. So the server running the app has to have [OpenLDAP](http://www.openldap.org/) and the [ruby-new-ldap](https://github.com/ruby-ldap/ruby-net-ldap) gem installed. 

As we've encountered this issue in the past, the bind may not work and could return a "Can't connect to LDAP server" error message. This is because there is no valid certificate setup for talking between the application server and the LDAP server. According to the [ldap.conf manual](http://linux.die.net/man/5/ldap.conf) you can open this strict measure up to allow for a connection without a cert. 

* Locate `ldap.conf` on your file system (for Linux systems it's usually found at `/etc/openldap/ldap.conf`).
* Add the line `TLS_REQCERT allow` to bypass checking for a valid cert and save. The `allow` option tells OpenLDAP to look for the cert but if it's invalid or missing continue anyway. This is only slightly more secure than the `never` option which ignores any certs at all.
* Ideally, you will implement a cert and leave the default `TLS_REQCERT` value.

## Roadmap
We have big plans for this application. We want to make it a fully configurable open source class registration application. It can't serve all purposes but it can do much more. Check out our [roadmap](http://github.com/NYULibraries/classes/wiki/Roadmap) on the wiki and see how we are constantly trying to improve in our [issues](http://github.com/NYULibraries/classes/issues) tracker.

## Contributing
See a bug? Have a feature request? Want to help improve documentation? You're so welcome. See our [contributing](http://github.com/NYULibraries/classes/wiki/Contributing) section in the wiki for details.

