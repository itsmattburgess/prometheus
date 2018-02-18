# Prometheus playground
Playground for experimenting with prometheus and related tools such as Grafana and PagerDuty. This is quite crufty and **shouldn't** be used as a reference of how to do this in prod.

This currently builds an environment in AWS with 1 prometheus master, and a few other nodes which publish node metrics. Ansible configures the machines and terraform builds the environment. To get started run ```make build```. Once you've finished playing run ```make destroy```.
