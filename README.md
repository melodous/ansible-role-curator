Welcome to curator Ansible Role’s documentation!
================================================

CURATOR
-------

Ansible role to install elasticsearch curator as container.

### Requirements

Docker engine up and running.

### Dependencies

N/A

### Example Playbook

    - hosts: servers
      roles:
        - { role: curator }

curator ansible role default variables
--------------------------------------

#### Sections

-   curator docker management
-   curator configuration

### curator docker management

`curator_docker_image`

curator docker image

    curator_docker_image: melodous/curator

`curator_version`

> curator docker image version (TAG)

    curator_version: 5.1.3

`curator_docker_labels`

> Yaml dictionary which maps Docker labels. os\_environment: Name of the
> environment, example: Production, by default “default”.
> os\_contianer\_type: Type of the container, by default curator.

    curator_docker_labels:
      os_environment: "{{ docker_os_environment | default('default') }}"
      os_contianer_type: curator

### curator configuration

`curator_monitoring`

> ElasticSearch nodes list

    curator_es_node: 127.0.0.1

`curator_loglevel`

> Loglevel for curator (DEBUG,INFO,WARNING,ERROR,CRITICAL)

    curator_loglevel: INFO

`curator_logfile`

> Logfile for curator, it will be created on host, mounted on the
> container and logrotated

    curator_logfile: /var/log/curator.log

`curator_logformat`

> Curator format for the log, (default, json, logstash)

    curator_logformat: default

`curator_delete_action`

> Curator action file: Ref
> <https://www.elastic.co/guide/en/elasticsearch/client/curator/current/actions.html>

    curator_delete_action:
      - id: 1
        pattern: logstash-
        age_unit: days
        age_count: 7

`curator_delete_run_at_hour`

> Delete index will run every dat at this hour

    curator_delete_run_at_hour: 4

Changelog
---------

**curator**

This project adheres to Semantic Versioning and human-readable
changelog.

### curator master - unreleased

##### Added

-   First addition

##### Changed

-   First change

### curator v0.0.1 - 2017/07/19

##### Added

-   Initial version

Copyright
---------

curator

Copyright (C) 2017/07/19 Raúl Melo
&lt;<raul.melo@opensolutions.cloud>&gt;

LICENSE
