# mirrorfy

This project created for manage rsync directories.
It's upload files to server every change.

## install

Currently Supports most of the linux computers, WSL1  
Tested on WSL1 Ubuntu and Debian.

Currently WSL2 not supported.
```Bash
sudo curl https://mirrorfy.ahmetozer.org/mirrorfy -o /usr/bin/mirrorfy
sudo chmod +x /usr/bin/mirrorfy
```

## install dependencies
```bash
# For ubuntu or Ubuntu on WSL
sudo apt install inotify-tools openssh rsync screen
```

## Commands

### start
`mirrorfy start`
  Start mirrorfy daemon.  
  It watchs your directories and every change uploads your directory to remote
  location.

### run
`mirrorfy run`
  Run your mirrorfy only once.  
  Upload all mirrorfy directories to remote servers.

### list
`mirrorfy list`
  List your all directories in config.

### add
`mirrorfy add`
  Add locations to mirrorfy config list.
  This functions has a some flags. Some ones required and showed with **<span style="color:#FC427B">bold<span/>**.
- **<span style="color:#FC427B">-n<span/>**  
Config name.  
Ex. `mirrorfy add -n project1`
- **<span style="color:#FC427B">-a<span/>**  
Remote server address. You can also define custom user.
Ex. `mirrorfy add -a 1.1.1.1` `mirrorfy add -a ahmet@1.1.1.1`
- **<span style="color:#FC427B">-d<span/>**  
Remote server directory  
Ex. `mirrorfy add -d /my/remote/directory`
- -l  
Local directory.
If it is not defined, program will be select current working directory.  
Ex. `mirrorfy add -l /my/sync/dir`
- -p  
Custom ssh port.
Normally ssh uses port number 22 but if you changed to another port, you have to inform about to program with -p flag.  
Ex. `mirrorfy add -p 422`
- -r   
Custom rsync arguments.
Mirrorfy  is uses "-avzhp --delete" arguments for rsync, but if you want to use custom arguments you can define with -r flag. **Note:** Do not forget to use **"** while writing rsync arguments.  
Ex. `mirrorfy add -r "-avzhp"`

#### **Example Commands**
```bash
mirrorfy add -n myproject1 -a mirrorfy.ahmetozer.org -d /my/remote/dir
mirrorfy add -n myproject1 -a ahmet@mirrorfy.ahmetozer.org -d /my/remote/dir -p 68
mirrorfy add -n myproject1 -a sync@mirrorfy.ahmetozer.org -d /my/remote/dir -l /my/local/dir/
mirrorfy add -n myproject1 -a mirrorfy.ahmetozer.org -d /my/remote/dir -p 99 -l /my/local/directory/
```

### service
`mirrorfy service` You can control mirrorfy service on your linux or windows machine
- start  
Start mirrorfy service
- stop  
Stop mirrorfy service
- restart  
Restart mirrorfy service
- register  
Add mirrorfy to startup in linux or Create task in Windows
- unregister  
Delete mirrorfy at startup in linux or Delete task in Windows


## Add startup

### Linux
Run `mirrorfy service register` to add mirrorfy startup folder.

### Windows

Run cmd as Administrator and enter to WSL enviroment with wsl command, then execute `mirrorfy service register` command to register Mirrorfy service on windows.


---
**Note:**
You have to create SSH keys on your pc and upload this keys to your server.
After uploading ssh key, Please make test connection to your server before adding mirrorfy. You can found more information to creating ssh key and upload, Please visit  [ahmetozer.org](https://ahmetozer.org/Push-files-to-server-every-change-Alternative-use-samba-or-ftp-to-realtime-sync.html)
