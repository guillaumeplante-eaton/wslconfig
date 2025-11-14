<center>
<img src="img/title.png" alt="title" />
</center>

### Overview

This personal repository  goal is to keep track of the various WSL configuration that I use and to be able to quickly switch configuration for specific uses cases (packet capture, memory limit, etc...). It can propably prove helpful for anyone looking to better understand and fine-tune WSL for their needs. 

**Collaborate!** Don't be shy to send any comments / suggestions [my way](mailto:GuillaumePlante@eaton.com) because I want this to be as useful and informative as possible for our dev team!

### WSL Configuration ?

The ```wsl.conf```[^1] and ```.wslconfig```[^2] files are used to configure advanced settings in the wsl virtual machine.

Personally, my config goals are: network and performance. I need to change my configuration in order to have a clean, sane network config that *works*, and hopefully have a wsl vm running smnoothly without taxing the host sstem.


### Memory Management: Configure Memory Limits

One of the most effective ways to optimize WSL2 is to set appropriate memory limits. 

```bash
[wsl2]
memory=6GB
processors=4
swap=2GB
```

This configuration:

1. Limits WSL2 to 6GB of RAM
2. Allocates 4 processor cores
3. Sets a 2GB swap file

of coursem adjust these values based on your system’s specifications and workload requirements.


### systemd support

Many Linux distributions run "systemd" by default (including Ubuntu) and WSL has recently added support for this system/service manager so that WSL is even more similar to using your favorite Linux distributions on a bare metal machine. To enable systemd:

*/etc/wsl.conf*

```bash
[boot]
systemd=true
```


### Network settings

```bash
generateHosts = false
generateResolvConf = false
hostname = CASROWHP6123123
```




[^1] **wsl.conf** is a per-distro configuration that affects only the distirb where it exists (like set default user, automount + net config)
[^2] **.wslconfig** is the global configuration for WSL2 and it sets the configuration for all distributions. It's the **host-side** virtualization settings (ps: wsl2 only)