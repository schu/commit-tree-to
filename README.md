`commit-tree-to` is the answer to "can I commit the content of a
directory (aka tree) to a separate branch?". Yes, you can.

Common use case is to commit a rendered static website from an untracked
folder (for example `public/`) to a release branch (for example
[`gh-pages`](https://help.github.com/en/articles/configuring-a-publishing-source-for-github-pages)).

Example:

```
hugo                                        # render page to `public/` dir
commit-tree-to public/ gh-pages             # commit rendered page to `gh-pages` branch
git push --force-with-lease github gh-pages # publish new page
```

Note: `commit-tree-to` currently creates a new root commit on each invocation
and does not reference previous commits. You can use git's
[`reflog`](https://git-scm.com/docs/git-reflog) to restore a previous version,
if necessary. Or adapt the script to your liking :)
