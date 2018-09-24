=====================
ROLE openshift_backup
=====================

.. image:: https://img.shields.io/github/license/adfinis-sygroup/ansible-role-openshift_backup.svg?style=flat-square
  :target: https://github.com/adfinis-sygroup/ansible-role-openshift_backup/blob/master/LICENSE

.. image:: https://img.shields.io/travis/adfinis-sygroup/ansible-role-openshift_backup.svg?style=flat-square
  :target: https://github.com/adfinis-sygroup/ansible-role-openshift_backup

.. image:: https://img.shields.io/badge/galaxy-adfinis--sygroup.openshift_backup-660198.svg?style=flat-square
  :target: https://galaxy.ansible.com/adfinis-sygroup/openshift_backup

A brief description of the role goes here.


Requirements
=============

The oc and jq binaries are required for the backup scripts. On CentOS they're
installed by the role itself.

Role Variables
===============

A description of the settable variables for this role should go here, including
any variables that are in defaults/main.yml, vars/main.yml, and any variables
that can/should be set via parameters to the role. Any variables that are read
from other roles and/or the global scope (ie. hostvars, group vars, etc.)
should be mentioned here as well.


Dependencies
=============

A list of other roles hosted on Galaxy should go here, plus any details in
regards to parameters that may need to be set for other roles, or variables
that are used from other roles.


Example Playbook
=================

Including an example of how to use your role (for instance, with variables
passed in as parameters) is always nice for users too:

.. code-block:: yaml

  - hosts: server
    roles:
       - { role: adfinis-sygroup.openshift_backup }


License
========

`Apache-2.0 <https://github.com/adfinis-sygroup/ansible-role-openshift_backup/blob/master/LICENSE>`_


Author Information
===================

openshift_backup role was written by:

* Adfinis SyGroup AG | `Website <https://www.adfinis-sygroup.ch/>`_ | `Twitter <https://twitter.com/adfinissygroup>`_ | `GitHub <https://github.com/adfinis-sygroup>`_
