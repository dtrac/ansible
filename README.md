# Ansible roles for Windows 
Repository containing various Windows roles and helper scripts.

### common
Ansible role to configure Windows server base OS.

This role configures registry settings, installs packages and PowerShell modules, configures networking, joins a domain and adds administrative users.


### wsus-server
Ansible role to install Windows Server Update Services pre-reqs and features.

This role bootstraps a new WSUS server. It installs the Windows Update Services Role and Management Tools, creates a folder to store content, installs .Net Framework 3.5 and installs Microsoft Report Viewer 2008.

This role also configures WSUS with the following parameters:

```
* Synchronize from Microsoft Update
* Enable only English Language Updates
* Use a proxy server
* Update only certain products - 'Windows Server 2008 R2', 'Windows Server 2012 R2', 'Windows Server 2016'
* Update only certain classifications - 'Critical Updates', 'Security Updates
* Configure automatic synchronization - Nightly @ 00:00
* Configure automatic approvals

