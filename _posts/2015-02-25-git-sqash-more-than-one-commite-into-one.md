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
