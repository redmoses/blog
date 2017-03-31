---
layout: post
title: Dockerizing a Python Application
date: 2015-12-20T19:19:18+06:00
modified: 2015-12-23
categories: 
description: Using docker to deploy a python application
tags: ['docker', 'python', 'flask', 'mysql']
---

Life is amazing with Docker. We don't need to run to Digital Ocean or any other tutorial sites 
anymore to get started with something new. With docker its extremely easy to set up something 
like a mail server or an infrastructure monitoring software like Sensu. <!-- more -->

With this it came to me that we should dockerize our custom inhouse applications as well. This just 
makes things easier and gives you a feeling of an almost 1-click installer.

So I dove into github and looked at a few examples. I was really inspired by a dockerized mail server 
project called [dockermail](https://github.com/lava/dockermail). It showed me the beauty of Makefiles.

We will need a sample python application for this tutorial. To keep things simple I'll just use the 
application from on of my previous posts, [Flask and Shell](/flask-and-shell). This application is also
available on Github at this [location](https://github.com/redmoses/flaskshell).