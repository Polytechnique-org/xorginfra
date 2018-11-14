Account management
==================

Users are managed in the ``group_vars/all/accounts.yml`` file.

Supported features:

- Define login
- Define full name
- Whether the user has root access
- Upload SSH keys
- Define user password

Usernames
---------

The pattern is ``{profile}{promo}{lastname}``:

- ``profile`` a single letter for the user formation (``x``, ``m``, ``d``, etc.); see plat/al hruid building rules for reference;
- ``promo`` is the user promotion year, on 4 digits;
- ``lastname`` is the user lastname, in lower case.

Example: ``x1829vaneau``

Adding a new user
-----------------

* In the ``group_vars/all/accounts.yml`` file, add a new section for the user (under the ``accounts.users.<username>`` key);
* Add a file in ``files/ssh-keys/<username>.pub`` with the user's public SSH keys;
* Define the user's password in ``group_vars/all/vault.yml`` under the ``vault.accounts.<username>_password`` key;
* Check whether the configuration is valid:

  .. code-block:: sh

    ansible-playbook base.yml --tags=accounts --check

  The only change should be for that user.
  You should get an error when adding the SSH key (since the user doesn't exist yet)

* Run for real:

  .. code-block:: sh

    ansible-playbook base.yml --tags=accounts
