---
layout: post
title: Deploy Ladon web service with Gunicorn
description: "Using Gunicorn to deploy Ladon web service."
tags: [deploy, gunicorn, ladon, python]
---

Before starting I would like to mention that this article is not intended to teach Ladon or Gunicorn. It is rather for people who have worked their way around each of these libraries individually and are now seeking for a way to use them together.

(You need to have Ladon and Gunicorn libraries installed in your environment)
I am using the example given on Ladon's website. Let this be our **calculator.py**:

{% gist redmoses/d82efea640348198871c %}

Since we are using Gunicorn for a custom application we would need to implement it from our application. To deploy this application with Gunicorn I used the [custom application](http://docs.gunicorn.org/en/latest/custom.html) template given on Gunicorn's documentation. Lets create our <b>server.py</b> which is going to be our WSGI handler.

{% gist redmoses/53baaa32ce76660fced7 %}

From *lines 9-13*, I am using LadonWSGIApplication to create a WSGI application from our calculator.py (this would be your actual code).

From *lines 16-31*, I am just inheriting from the Gunicorn base application class to create my own custom application.

And finally there's the main method which runs our application. You must notice that I'm passing the "*application*" variable (*line 45*) I had previously declared on *line 9* with the some basic configurations like ip address and ports to bind to start the application.

To run the application just use "python server.py" and it would start running on port 5656. To access the application visit [http://localhost:5656](http://localhost:5656) from your browser.
