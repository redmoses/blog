---
layout: post
title: Deploy Ladon web service with Gunicorn
description: "Using Gunicorn to deploy Ladon web service."
modified: 2014-07-02
tags: [deploy, gunicorn, ladon, python]

---

Before starting I would like to mention that this article is not intended to teach Ladon or Gunicorn. It is rather for people who have worked their way around each of these libraries individually and are now seeking for a way to use them together.

(You need to have Ladon and Gunicorn libraries installed in your environment)
I am using the example given on Ladon's website. Let this be our **calculator.py**:

{% highlight python %}
class Calculator(object):
    #ladonize the method
    @ladonize(int, int, rtype=int)
    def add(self, a, b):
        return a + b
{% endhighlight %}

Since we are using Gunicorn for a custom application we would need to implement it from our application. To deploy this application with Gunicorn I used the [custom application](http://docs.gunicorn.org/en/latest/custom.html) template given on Gunicorn's documentation. Lets create our <b>server.py</b> which is going to be our WSGI handler.

{% highlight python %}
import multiprocessing
import gunicorn.app.base
from gunicorn.six import iteritems
from ladon.server.wsgi import LadonWSGIApplication
from os.path import abspath, dirname

# The ladon wsgi application
application = LadonWSGIApplication(
              ['calculator'],
              [dirname(abspath(__file__))],
              catalog_name='My Ladon webservice catalog',
              catalog_desc='This is the root of my cool webservice catalog')

# Inherit from gunicorn base application class to create our application
class StandaloneApplication(gunicorn.app.base.BaseApplication):
    def __init__(self, app, options=None):
        self.options = options or {}
        self.application = app
        super(StandaloneApplication, self).__init__()

    # Extract config options
    def load_config(self):
        config = dict([(key, value) for key, value in iteritems(self.options)
                 if key in self.cfg.settings and value is not None])

        for key, value in iteritems(config):
            self.cfg.set(key.lower(), value)

    def load(self):
        return self.application


    if __name__ == '__main__':
        # Set the options
        options = {
                # For simplicity I am using these default configurations:
                # Localhost Ip(127.0.0.1), Default Port(5656) and Default no. of workers 4
                # You can take arguments from the command line for these attributes
                'bind': '%s:%s' % ('127.0.0.1', '5656'),
                'workers': 4,
        }

    # Run the application
    StandaloneApplication(application, options).run()
{% endhighlight %}

From *lines 9-13*, I am using LadonWSGIApplication to create a WSGI application from our calculator.py (this would be your actual code).

From *lines 16-31*, I am just inheriting from the Gunicorn base application class to create my own custom application.

And finally there's the main method which runs our application. You must notice that I'm passing the "*application*" variable (*line 45*) I had previously declared on *line 9* with the some basic configurations like ip address and ports to bind to start the application.

To run the application just use "python server.py" and it would start running on port 5656. To access the application visit [http://localhost:5656](http://localhost:5656) from your browser.
