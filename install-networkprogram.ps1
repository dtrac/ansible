---
- name: install program from domain share
  hosts:
  tasks:
  - name: copy the executable to a local path
    win_copy:
      src: \\192.168.1.10\programs\program.msi
      dest: C:\temp\program.msi
    become: yes
    become_method: runas
    become_flags: logon_type=new_credentials logon_flags=netcredentials_only
    vars:
      ansible_become_user: DOMAIN\username
      ansible_become_pass: Password01

  - name: install program
    win_package:
      path: C:\temp\program.msi
      state: present
