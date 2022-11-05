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

    For `debian` based distributions, download [oblv_0.4.0_amd64.deb](https://api.oblivious.ai/oblv-ccli/0.4.0/packages/oblv_0.4.0_amd64.deb)
    and run
    
    ```
    wget "https://api.oblivious.ai/oblv-ccli/0.4.0/packages/oblv_0.4.0_amd64.deb"
    sudo dpkg -i oblv_0.4.0_amd64.deb
    ```
- RPM based distributions

    For `rpm` based distributions, download [oblv-0.4.0-1.x86_64.rpm](https://api.oblivious.ai/oblv-ccli/0.4.0/packages/oblv-0.4.0-1.x86_64.rpm) and run.
    
    ```
    wget https://api.oblivious.ai/oblv-ccli/0.4.0/packages/oblv-0.4.0-1.x86_64.rpm
    sudo rpm --install oblv-0.4.0-1.x86_64.rpm
    ```

### Windows

For windows, download [oblv-0.4.0-x86_64.msi](https://api.oblivious.ai/oblv-ccli/0.4.0/packages/oblv-0.4.0-x86_64.msi)


### Binaries

You can also download the [binaries here](https://docs.oblivious.ai/cli/binaries).

### Documentation

For usage, please refer to [oblivious documentation](https://docs.oblivious.ai/cli/available_commands)
