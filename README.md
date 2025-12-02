# <img src="https://ubuntu-lionheart-website.indiepro.workers.dev/lion-small.png" height="32" alt="Lion Icon"> Ubuntu Lionheart
https://ubuntulionheart.org

Optimize Ubuntu into a stable, dependable powerhouse for your desktop or server.

This install script removes untested and politicized packages (like Rust uutils) and replaces them with classic, 
battle-tested alternatives and low-politics forks.

One-command install:
```
curl -fsSL https://ubuntulionheart.org/install.sh | bash
```

* Human readable Bash scripts
* Tested on Ubuntu 25.10+
* < 5 minutes to install

### The Packages You Need, Minus the Hassle
Our script installs the packages you need from each project's official, upstream sources. Repositories and PPAs are configured for you so that you always get the latest updates.

| Default Package | Replacement Package | Replacement Source                                                                                        |
|-----------------|---------------------|-----------------------------------------------------------------------------------------------------------|
| Rust uutils     | GNU coreutils       | Official Ubuntu Repos                                                                                     |
| Xorg X Server   | XLibre X Server     | https://xlibre-deb.github.io/ubuntu (cited by https://github.com/X11Libre/xserver/wiki/Are-We-XLibre-Yet) |
| Firefox         | Brave               | Official install script from https://brave.com/linux

Don't need them all?
The script lets you pick and choose which ones to install.

### How it Works
The main install script detects your version of Ubuntu and whether you are running in a desktop environment (X11 or Wayland) 
environment or a server environment (no graphical session). It then downloads and runs the appropriate 
install script for your system (e.g. https://ubuntulionheart.org/25.10/desktop.sh).

The scripts are all available in this repository. They are human-readable and thoroughly commented for your 
peace of mind.

## FAQ

### Why did you create this script?
We've been Ubuntu users pretty much since the beginning (6.06 "Dapper Drake" to be exact).

Like so many others, we've poured a lot of time and energy into helping make Ubuntu the distro and the community that it is today. We don't want to start over with a new distro if we can rescue all that good work.

It's also a reality that Ubuntu is everywhere, especially in cloud VPS infrastructure. Sometimes you don't have the option to go with an alternative like Devuan or OpenMandriva (though we love both of those projects!).

### What if something breaks during installation?
This script is only intended to be used on a brand new Ubuntu installation. It's highly unlikely to break (the script is pretty simple), but if it does, you should be able to start over with a fresh install. If it is not a fresh Ubuntu install, then always make backups first.

### Can I customize what gets installed?
Yes! If you are running on a desktop, the script will present you with a menu in the terminal so you can pick and choose what gets installed. If the script detects you are running on a server (no graphical session) then it only installs GNU coreutils (replacing Rust uutils) so there is no menu necessary. The server version is intended to be non-interactive so that it's easy to use in bash scripts, Dockerfiles, etc.

### How often is it updated?
Ubuntu Lionheart will be updated as needed for each new release of Ubuntu from 25.10 onward.

To paraphrase Aragorn: there may come a day when Ubuntu strays so far from its roots or goes so woke that we are forced to pick a new distro to run our infrastructure, but it is not this day!

### Does this work on existing Ubuntu installations?
Yes! You can run the script on an existing Ubuntu system. It will remove unwanted packages and install new ones, but won't affect your personal files. It's mostly just running more advanced apt commands. However, for obvious reasons we cannot accept any responsibility or liability if something goes wrong, so make backups.

### Why the name "Lionheart"?
Ubuntu Lionheart is named after Richard the Lionheart. This is for two reasons:
* The Lion imagery evokes Ubuntu's early roots with its Africa-inspired default theming.
* Richard the Lionheart was [extremely based](https://www.youtube.com/watch?v=YzQ4JYRwScI).

### Can I contribute to Ubuntu Lionheart?
Yes! We welcome contributions. Please report any issues and submit pull requests right here on the Github repo.

---

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://ubuntu-lionheart-website.indiepro.workers.dev/indiepro-long-white-text.png">
  <source media="(prefers-color-scheme: light)" srcset="https://ubuntu-lionheart-website.indiepro.workers.dev/indiepro-long-black-text.png">
  <img alt="IndiePro Logo" src="https://ubuntu-lionheart-website.indiepro.workers.dev/indiepro-long-white-text.png" height="32" />
</picture>

Ubuntu Lionheart is brought to you by the developers of IndiePro, the all-in-one, AI-enhanced platform for freelancers to find
clients, manage projects and make way more money.
https://getindiepro.com
