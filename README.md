itmhost Cookbook
================
Simple IBM Tivoli Monitoring (ITM) Configuration

This cookbook provides simple Centos configuration and downloads a minimal ITM runtime.

Requirements
------------
Centos is the only supported operating system for this sample configuration.

ITM runtime image contains ITM Tivoli Enterprise Monitoring Server (TEMS),
ITM Linux Operating System Monitoring Agent (KLZ), and
ITM Tivoli Enterprise Automation Server with
Open Services for Lifecycle Colaboration (OSLC) Performance Monitoring [OSLC-PM] Service Provider (KAS).

Miminal ITM runtime: [Download](https://dl.dropboxusercontent.com/u/20692025/centos-64-x64-itm-lite.tar.gz)

Attributes
----------
None. Attributes will be added in the future.


Usage
-----
#### itmhost::default
Everything is done in the default rule.

Just include `itmhost` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[itmhost]"
  ]
}
```

Contributing
------------
This is a practice cookbook. There are probably lots of things to improve.

License and Authors
-------------------
Authors: Dean Okamura (dokamura@us.ibm.com)
