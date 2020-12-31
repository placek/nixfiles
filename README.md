# nixfiles

My NixOS configuration for various devices.

### structure

* A **machine** has one or more role.
* A **role** is a collection of **packages** and **services**.

### secrets.nix

Secrets are stored in `secrets.nix` in the following form:

```
{
  users = [
    {
      name = "someone";
      isNormalUser = true;
      description = "Some One";
      hashedPassword = "secret password for Some One";
      ...
    }
    ...
  ];
}
```

### configuration.nix

```
{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./machines/some-machine.nix
    ];
}
```

### contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### license

Distributed under the MIT License. See `LICENSE` for more information.
