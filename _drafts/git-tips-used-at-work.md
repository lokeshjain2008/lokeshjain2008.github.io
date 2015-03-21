---
layout: post
comments: true
title: git tricks used at work
tags: [git, github, git commit, git revert]
categories: [git,tutorials]
---
`git reset --hard <version-no>`

links for the helps
[git tags and categories] (http://www.minddust.com/post/tags-and-categories-on-github-pages/)

[great link](http://stackoverflow.com/questions/4114095/revert-to-a-previous-git-commit)

- trick if want to do the current commit structure.
1. git reset :  remove the applied changes
2. git checkout . : will revert all the changes and project will be clean

git push -f 

Merge options dear...
http://stackoverflow.com/questions/10697463/resolve-git-merge-conflicts-in-favor-of-their-changes

There is one more this....
http://stackoverflow.com/questions/173919/is-there-a-theirs-version-of-git-merge-s-ours


http://stackoverflow.com/questions/12657168/can-i-use-my-existing-git-repo-with-openshift


Trick how may files `modified`

git status | grep modified|  wc

[git tricks](http://rypress.com/tutorials/git/tips-and-tricks)