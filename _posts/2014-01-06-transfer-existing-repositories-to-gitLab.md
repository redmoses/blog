---
layout: post
title: Transfer existing Repositories to GitLab
description: "Moving from Gerrit to Gitlab"
modified: 2014-01-06
tags: [existing repositories, gitlab, gitlab 6, gitlab 7, import, repositories]
---

The developer team in my office were using Gerrit Code Review along with git-web before migrating to GitLab. So we had to transfer all our existing repositories to GitLab. This tutorial can also be used for migrating from other git based issue tracking systems. The GitLab documentation says to put all your bare repositories, the ".git" directories, into this location - "/home/git/repositories" and then use the import command. But this doesn't do the job, it only creates blank empty projects under the Admin group with no source files or previous issues. So to solve this, just follow the steps below -

{% highlight bash %}
# You should change $newdir into something you prefer
# The command is going to create a new directory inside the repositories directory

sudo cp -R /usr/local/gerrit2/git /home/git/repositories/$newdir

# Change ownership of the directory
sudo chown -R git:git /home/git/repositories/$newdir
{% endhighlight %}

This is for Gitlab versions 6 and less
{% highlight bash %}
# And now you can run this command, provided by the GitLab Team
# Change to root user and go to GitLab's directory

cd /home/git/gitlab
sudo su

sudo -u git -H bundle exec rake gitlab:import:repos RAILS_ENV=production
{% endhighlight %}

For Gitlab versions 7 and onwards (That is, if you've installed Gitlab using the debian package)
{% highlight bash %}
# Just run the following command
sudo gitlab-rake gitlab:import:repos
{% endhighlight %}

When you run the above command GitLab is going to create a new group named $newdir (i.e., the directory's name) and import the repositories perfectly. Now you can access GitLab with your admin account and access all the projects under the newly created group.
