Ivy Education
=============

[nb. While ivy was used daily both by myself and other teachers, I
should stress that, in terms of the general public, ivy is Beta
software. It was developed using Agile methodologies.]

Personal Background
-------------------

From about 2003 until 2008, I was a music teacher. I also happened to
be a software developer so when I got frustrated with the problems of
Blackboard & Firstclass (the educational software our school used) I
wrote my own software. First in PHP and then in Rails. I'm not really
sure why I switched from PHP to Rails.. probably because I like
learning new things.

Overview
--------

Originally I wrote ivy to help with the logistics of teaching. It
helped with attendance and note-taking. Then I added the ability to
plan and schedule and incorporated the concept of 'activities'. This
subtle change actually turned ivy into a curriculum development
tool. I could scan backwards in time within a specific class as well
as through the years, to help figure out what might work best for my
current group of students.

At this point, activities are represented simply as names although
adding further descriptions and material requirements would be quite
simple.

The basic idea is to log which activity or activities were used during
class and to also take notes on the success of each class/activity. Of
course, this should be done as soon as possible so you don't forget -
if possible, I'd do it during class, otherwise, I'd do it between
classes.

Installation
------------

So, development stopped a while ago. That being the case, you need to
revert to older versions of things to get everything working. While
the newest version of, say, mysql, might work, I'd suggest first
getting everything running and then, once you're all cooking,
upgrade. Here is what I had to setup to get things working:

> mysql: mysql Ver 14.14 Distrib 5.5.15, for osx10.6 (i386) using readline 5.1
>
> ruby: ruby 1.8.7 (2010-01-10 patchlevel 249) [universal-darwin10.0]
>
> rails: 1.2.3
>
> ivy: get it here

Without typing out a lesson on how to use Rails, basically, you get
mysql setup and running. Then you edit the config/database.yml file in
the ivy distribution to match your usernames & passwords. Then you run
"rake db:migrate" within the top directory of the distribution. When
that all works, you can run script/server and go to
http://0.0.0.0:3000. That the gist. There's a README in the
distribution which will help. Also, feel free to contact me.

Educational Note
----------------

One of the benefits with activity-based education is that you're
putting what works before what you think the students need. You
cannot, of course, teach someone something that they do not care to
learn about. Not easily, at least. Those activities that are more
successful will be selected for, those less gradually eliminated or
changed. Kind of evolutionarily.

Design Note
-----------

Just in case some of y'all are wondering, I thought I'd mention a
thing about my design philosophy, specifically the UI. Basically this
is how I look at things: the smaller and simpler the better. I'm
talking from an energy standpoint. If the user has to upload all sorts
of cute little gifs and other graphics and whatnot, it simply takes
more energy. Sure, it might not be a lot, per person. But it adds
up. And why use more energy if it's not really necessary? Soooo, all
things & functionalities being equal, I'm actually trying to reduce
the amounts of bytes sent across the internet.
