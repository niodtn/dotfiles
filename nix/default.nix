{self, ...}: {
  imports = [
    ./lib
  ];

  config = {
    systems = [
      "x86_64-linux"
      "aarch64-darwin"
      "aarch64-linux"
    ];
  };
}
