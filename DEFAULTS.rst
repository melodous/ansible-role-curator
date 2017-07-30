.. vim: foldmarker=[[[,]]]:foldmethod=marker

curator ansible role default variables
======================================

.. contents:: Sections
   :local:

curator docker management
-------------------------

.. envvar:: curator_docker_image

curator docker image

::

  curator_docker_image: melodous/curator




.. envvar:: curator_version

   curator docker image version (TAG)

::

  curator_version: 5.1.3




.. envvar:: curator_docker_labels

   Yaml dictionary which maps Docker labels.
   os_environment: Name of the environment, example: Production, by default "default".
   os_contianer_type: Type of the container, by default curator.

::

  curator_docker_labels:
    os_environment: "{{ docker_os_environment | default('default') }}"
    os_contianer_type: curator





curator configuration
---------------------

.. envvar:: curator_monitoring

   ElasticSearch nodes list

::

  curator_es_node: 127.0.0.1




.. envvar:: curator_loglevel

   Loglevel for curator (DEBUG,INFO,WARNING,ERROR,CRITICAL)

::

  curator_loglevel: INFO




.. envvar:: curator_logfile

   Logfile for curator, it will be created on host, mounted on the container
   and logrotated

::

  curator_logfile: /var/log/curator.log




.. envvar:: curator_logformat

   Curator format for the log, (default, json, logstash)

::

  curator_logformat: default




.. envvar:: curator_delete_action

   Curator action file: Ref
   https://www.elastic.co/guide/en/elasticsearch/client/curator/current/actions.html

::

  curator_delete_action:
    - id: 1
      pattern: logstash-
      age_unit: days
      age_count: 7




.. envvar::  curator_delete_run_at_hour

   Delete index will run every dat at this hour

::

  curator_delete_run_at_hour: 4



