# mirrorfy

This project created for manage rsync directories.
It's upload files to server every change.

## install
```Bash
curl https://mirrorfy.ahmetozer.org/mirrorfy -o /usr/bin/mirrorfy
chmod +x /usr/bin/mirrorfy
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
Remote server address  
Ex. `mirrorfy add -a 1.1.1.1`
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
```Bash
mirrorfy add -n myproject1 -a mirrorfy.ahmetozer.org -d /my/remote/dir
mirrorfy add -n myproject1 -a mirrorfy.ahmetozer.org -d /my/remote/dir -p 68
mirrorfy add -n myproject1 -a mirrorfy.ahmetozer.org -d /my/remote/dir -l /my/local/dir/
mirrorfy add -n myproject1 -a mirrorfy.ahmetozer.org -d /my/remote/dir -p 99 -l /my/local/directory/
```
