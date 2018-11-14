X.org Infra
===========


Playbooks to manage all X.org servers.


Install
-------

.. code-block:: shell

    $ make update

Structure
---------

``inventory/hosts.ini``:
    List of all hosts

``inventory/group_vars/<GROUP>.ini``:
    Variables applying for servers of said group

``inventory/host_vars/<HOST>.ini``:
    Host-specific variables


``foo.yml``:
    A standard playbook.
    It should only link together a group of hosts, variables, and roles from the ``roles/`` folder.

``roles/playbook/foo/``:
    A playbook-related role. Describes all tasks for a server with that role.

``roles/include-many/``:
    A role that could be included several times in the same playbook (e.g setting up a vhost)

``roles/include-once/``:
    A role that installs system-wide elements.
    Those roles **MUST NOT** take any parameters (except listed in ``host_vars``), since they may be applied
    from several groups.

Tagging tasks
-------------

A role' tasks **MUST** be flagged with at least one of the following tags:

``setup``:
    All 'once and for all' tasks (installing packages, generating keys, etc.)

``config``:
    Anything related to writing configuration files

``app``:
    Related to installing our custom software pieces.


Example:

.. code-block:: yaml

    # roles/shared/nginx/tasks.yml

    - name: Ensure nginx is installed
      apt:
        name: nginx
        state: installed
      tags: [setup]

    - name: Configure nginx
      file:
        src: nginx.conf
        dest: /etc/nginx/nginx.conf
      tags: [config]
