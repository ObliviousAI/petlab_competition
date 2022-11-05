# The OBLV Proxy ☎️

This guide is likely not relevant to most of you partaking in the competition, as we have set up a Datalore that will step you through the process in a consistent way.
However, if you decide to connect in from your personal device, it's actually quite straight forward. 
In this guide, we'll cover:

- Installing the proxy on:
  - MacOS
  - Windows
  - Linux

### MacOS


Oblivious-client proxy can be installed on MacOs using [homebrew](https://brew.sh/).

To install `oblivious client proxy` run:

```
brew tap ObliviousAI/oblv
brew install oblv
```

### Linux


- Debian based distributions

    For `debian` based distributions, download [oblv_0.4.0_amd64.deb](https://api.oblivious.ai/oblv-ccli/packages/0.4.0/oblv_0.4.0_amd64.deb)
    and run
    
    ```
    sudo dpkg -i oblv_0.4.0_amd64.deb
    ```
- RPM based distributions

    For `rpm` based distributions, download [oblv-0.4.0-1.x86_64.rpm](https://api.oblivious.ai/oblv-ccli/packages/0.4.0/oblv-0.4.0-1.x86_64.rpm) and run.
    
    ```
    sudo rpm --install oblv-0.4.0-1.x86_64.rpm
    ```

### Windows

For windows, download [oblv-0.4.0-x86_64.msi](https://api.oblivious.ai/oblv-ccli/packages/0.4.0/oblv-0.4.0-x86_64.msi)


### Other Linux Distros

On other Linux distros, `oblv` cli can be installed using

```
curl -L "https://api.oblivious.ai/oblv-ccli/install.sh"  | bash
```

### Test if OBLV works

To test if `OBLV` proxy works on your system,

- On `MacOS` and `Linux`, run

    ```
    oblv --help
    ```
- On windows, run

    ```
    oblv.exe --help
    ```
you would get the output something similar to this

```
Configuration file stored at: "/home/user/.config/oblv/oblv_config.yaml"

oblv 0.4.0
Oblivious Software Ltd. <oblivious.ai>
Oblivious client app for encrypted connection to secure enclave

USAGE:
    oblv <SUBCOMMAND>

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

SUBCOMMANDS:
    connect      Connect to enclave
    help         Prints this message or the help of the given subcommand(s)
    keygen       Generate public/private rsa key pair
    reconnect    Reconnect to a previously connected enclave

```