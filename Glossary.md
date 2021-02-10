**Glossary**

**pwd** - Prints the working directory.
```
pwd
```

**ls** - Lists computer files. "-la" flag will show files in long format and hidden files.
```
ls -la
```

**mkdir** - A command that will make a new directory.
```
mkdir directoryName
```

**mv** - A command that will move a file. Can also be used to rename files.
```
mv fileName newFileName
```

**cp** - A command that will copy files or directories. Use the "-r" flag to copy recursively for directories.
```
cp sourceDirectory newDirectory
```

**rm** - A command to remove a file. Use the "-r" flag to remove recursively.
```
rm -r directoryName
```

**chmod** - A command that can change access permissions for the user, the user's group, and others. An octal system can be used to specify permissions.
```
chmod 777 fileName
```

**cat** - A command that will concatenate files, or essentially prints the file.
```
cat fileName
```

**file** - A command that will display the type of a file.
```
file Glossary.md
```

**cd** - A command that will change the current directory. Just "cd" will take the user back to their home directory.
```
cd newhomatcis241/
```

**touch** - A command that will create an empty file in the current directory.
```
touch newFile.txt
```

**man** - A command that will print the manual for the command the user specifies.
```
man cd
```

**echo** - A command that can move data into a file, ussually text. Uses the ">>" symbols to append to or create a file.
```
echo text >> fileName.txt
```

**vim** - A command that will open up the vim editor so a file can be edited.
```
vim fileName.txt.
```

**chown** - A command that can be used to change file ownership.
```
chown user file
```

**chgrp** - A command that can be used to change a group's file ownership.
```
chgrp group file
```

**ln** - A command that can create a link to a file. The "-s" flag means that the link is symbolic.
```
ln -s fileName linkName
```

**mount** - A command used to attach file systems and removable devices.
```
mount device directory
```

**git add** - A command that will add changes to a file that can later be committed.
```
git add fileName
```

**git commit** - A command that will record file changes to a repository. Use "-m" flag to record a message.
```
git commit -m "message"
```

**git status** - A command that will show changes that need to be added or committed.
```
git status
```

**git push** - A command that will update remote repositories with file changes.
```
git push
```

**git pull** - A command that will pull updates from a remote repository and add the changes to the local repository.
```
git pull
```

**find** - A command that will locate files based on specfic criteria like a file name. Use "-name", "-type", etc.
```
find /home -name "text.txt"
```

**history** - A command that will print items in regard to previous commands. Use "-c" to clear history.
```
history -c
```

