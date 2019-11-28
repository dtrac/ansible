vsphere-snapshot
======================

Ansible role for managing vsphere vm snapshots.


Requirements
------------
Python module on executing host:

- PyVmomi

vSphere versions:

- 5.5, 6.0, 6.5


Role Variables
--------------

* vm_name
* snapshot_state
* snapshot_name
* vcenter_host


Dependencies
------------

* TBC

Example Playbook
----------------

Example playbook using the role.

```
---
 - hosts: all
   gather_facts: no
   tasks:

     - import_role:
         name: pit-vsphere-snapshot
       vars:
         vm_name: "vm-1"
         snapshot_state: "absent" # "present" | "absent" | "revert"
         vcenter_host: "vcenter.local"
         snapshot_name: "snappy"
```      

Author Information
------------------

Dan Tracey (dtracey@hotmail.co.uk)