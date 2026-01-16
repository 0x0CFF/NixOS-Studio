let
  # 导入公钥
  DATAGC00 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAZcb2XAlok0msZfJt6kGfLnlsOH/LYlvODXv4hrzj6R 0x0CFF@DATAGC00";
in {
  "dify-db-password.age".publicKeys = [
    DATAGC00
  ];
  "dify-redis-password.age".publicKeys = [
    DATAGC00
  ];
}