pit-windows-update
======================

Ansible role for installing Windows Updates.


Requirements
------------
PowerShell v4+ required to support the scheduled task method of installing updates.
Supported OSes:

- Windows Server 2008 SP2
- Windows Server 2008 R2 SP1
- Windows Server 2012
- Windows Server 2012 R2
- Windows Server 2016
- Windows Server 2019


Role Variables
--------------

* *create_snapshot* - creates a VM snapshot prior to Windows update in order to provide rollback capability in the event of failure (currently GCE only).
* *update_choco_packages* - optionally performs an update of all installed chocolatey packages (in development)


Dependencies
------------

* A Windows Update source must be configured - usually via a vRO workflow or the installation of the SCCM client (e.g):

```
HKLM:\software\policies\Microsoft\Windows\WindowsUpdate\WUServer = $wsusServer
HKLM:\software\policies\Microsoft\Windows\WindowsUpdate\WUStatusServer = $wsusServer
HKLM:\software\policies\Microsoft\Windows\WindowsUpdate\AU\UseWUServer = 1
```




Example Playbook
----------------

Example playbook using the role.

    - hosts: all
      vars:
        create_snapshot: no
        update_choco_packages: no
      roles:
         - pit-windows-update


Author Information
------------------

Dan Tracey (dan.tracey@johnlewis.co.uk)