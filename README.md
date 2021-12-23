# nixfiles

My NixOS configuration for various devices.

### structure

* A **machine** has one or more role and one or more user.
* A **role** is a collection of **packages** and **services**.
* A **user** is a configuration for particular user.
* A **package** is a custom nix package.
* A **hardware** is a definition of a device used by machine.

### apply configuration

```
sudo rebuild-nix <target>
```

Where current targets are: *lambda* and *omega*.

### contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### license

Distributed under the MIT License. See `LICENSE` for more information.
