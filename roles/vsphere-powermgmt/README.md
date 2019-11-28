vsphere-powermgmt
======================

Ansible role for managing vsphere vm power state.


Requirements
------------
Python module on executing host:

- PyVmomi

vSphere versions:

- 5.5, 6.0, 6.5


Role Variables
--------------

* vm_name
* power_state
* state_change_timeout
* force
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
         name: vsphere-powermgmt
       vars:
         vm_name: "vm1"
         power_state: "powered-off" # "powered-off" | "powered-on" | "reboot-guest" | "restarted" | "shutdown-guest"
         state_change_timeout: 60
         force: yes
         vcenter_host: "vcenter.local"
```

Author Information
------------------

Dan Tracey (dtracey@hotmail.co.uk)