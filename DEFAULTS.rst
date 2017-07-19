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




.. envvar::  curator_delete_index_pattern

   Patter to delete indices

::

  curator_delete_index_pattern: logstash-




.. envvar::  curator_delete_days

   Delete indices older than this number of days

::

  curator_delete_days: 7




.. envvar::  curator_delete_run_at_hour

   Delete index will run every dat at this hour

::

  curator_delete_run_at_hour: 4



