===
Conntrack Formula
===

Installs and sets up conntrackd to share firewall states across multiple machines.

init.sls
========

* install conntrack
* setup with data from pillar (look at pillar.example)
* restart conntrack if something changed

sysctl.sls
==========

* add config to sysctl:  net.netfilter.nf_conntrack_max=32100
* reload sysctl config

heartbeat.sls
=============

* add resources to heartbeat resources.d to switch master/slave



