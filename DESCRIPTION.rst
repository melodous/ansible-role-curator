CURATOR
=======

Ansible role to install elasticsearch curator as container.

Requirements
------------

Docker engine up and running.

Dependencies
------------

N/A

Example Playbook
----------------

.. code::

  - hosts: servers
    roles:
      - { role: curator }
