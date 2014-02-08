---
layout: post
title:  "Problem with the Row Count in Processing Code"
date:   2014-02-05 00:00:00
categories: post
author: garhodes
---

Seems to be a problem with how processing is counting rows.  If, in the in-class example, you try to have it process the last two rows, #10 and #11, it throws an error and they don't exist.  Row #0 does exist.  So it is stripping the header (row 1) and then starting its count at zero-- so aware if you are trying to track which row it is visualizing via excel, the row counts are off by 2.