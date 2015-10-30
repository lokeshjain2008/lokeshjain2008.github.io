---
layout: post
date: "Wed Feb 25 17:34:04 2015"
comments: true
title: "git squash more than one commit into one and other tricks"
tags: [git, github, git tricks]
---
##Git and some daily tasks for git.

Git is great and but still there is a lot to learn for big projects to complete.

1. some basic git commands

```bash
git log
git log --oneline
git log --graph --oneline
git log --graph --oneline --all
#create new branch and checkout the branch
git checkout -b <branch-name>
git branch -v #verbose branch listing
git branch -a #all branch remote+local
git branch -r #all remote branch
```
2. Convert commits into one commit follow the process
---

```bash
git log --oneline #count how many commits you want to squash into one
git rebase -i HAED~<counts-to-sqash> #this will open up your editor if added for the git
# change pick to `squash`(want to remote) and have at-least one pick(you want to show).
# now save it. Then again you need to have only commit message. save it
git push origin :<branch> # this will delete the remote branch on origin
git push origin <branch> # This will create the remote branch again. Now every thing will look fine.
```
3. sublime error for the git.
---
I encountered sublime error

`Unable to save ~/Documents/code/myapp/.git/rebase-emrge/git-rebase-todo`

solution
---

```bash
git config --global core.editor "subl -n -w"
```
### Git: if removed file using `git rm`
Then
If you already commited changes, then:

```bash
git reset (--hard) HEAD~1
```
If not then:

```bash
git reset
git checkout -- $(git ls-files -d)
```
To restore deleted files the last part should look like git ls-files -d and thet it will recover only deleted files.

4. view git log only for current branch

Assuming that your branch was created off of master :

```sh
git cherry -v master

```
or
If your branch was made off of origin/master, then say origin/master instead of master.

```sh

git log master..

```

5. git rebase

If your current branch is running behind the master branch then

```sh
git checkout feature

git rebase master

```
6. To cache the username/password in git push

```sh
git config --global credential.helper osxkeychain

```

7. Git push to other branch from one branch
if we want to push branch(feature) to the remote origin/branch then use

```sh

git checkout feature
git push origin feature:master

```
8. delete remote branch

```sh

git push origin :<branch-name>

```

9. git-checkout specific files from another branch.
As an example, this is how you could update your gh-pages branch on GitHub (used to generate a static site for your project) to include the latest changes made to a file that is on the master branch.

```sh

# On branch master
git checkout gh-pages
git checkout master -- myplugin.js
git commit -m "Update myplugin.js from master"

```

10. Add username/password of git project to cache from `HTTPS`.
----

You can also have Git store your credentials permanently using the following:

git config credential.helper store
Note: While this is convenient, Git will store your credentials in clear text in a local file (.git-credentials) under your project directory (see below for the "home" directory). If you don't like this, delete this file and switch to using the cache option.

If you want Git to resume to asking you for credentials every time it needs to connect to the remote repository, you can run this command:

`git config --unset credential.helper`
To store the passwords in .git-credentials in your %HOME% directory as opposed to the project directory: use the --global flag

`git config --global credential.helper store`

for the osX users

`git config --global credential.helper osxkeychain`

For more [click](http://stackoverflow.com/questions/5343068/is-there-a-way-to-skip-password-typing-when-using-https-github)

11. Add branch to the git repo short hand.

`git push <repo> <branch> -u`
